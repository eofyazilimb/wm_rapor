import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';
import 'package:turkish/turkish.dart';
import 'package:wm_rapor/model/report_data_model.dart';

class DataTableCubit extends Cubit<DataTableState> {
  ReportData? reportData;
  String reportName = "RAPOR ADI";

  DataTableCubit() : super(const DataTableInitial());

  set setReportData(ReportData value) {
    reportData = value;
  }

  /// Rapor datasını yükle ve kolon/satırları hazırla
  void loadReportTable(ReportData data, {String? name}) {
    setReportData = data;
    if (name != null) {
      reportName = name;
    }

    final columns = createColumns(data);
    final rows = createRows(data);

    emit(
      state.copyWith(
        sortTable: data,
        sorting: PlutoColumnSort.none,
        sortColumn: null,
        columns: columns,
        rows: rows,
      ),
    );
  }

  /// PlutoGrid için satır üretimi
  List<PlutoRow> createRows(ReportData reportData) {
    return reportData.data.map((row) {
      final cells = <String, PlutoCell>{};
      for (final colName in reportData.columns) {
        cells[colName] = PlutoCell(value: row[colName]);
      }
      return PlutoRow(cells: cells);
    }).toList();
  }

  /// PlutoGrid için kolon üretimi
  List<PlutoColumn> createColumns(ReportData reportData) {
    final firstRow = reportData.data.isNotEmpty ? reportData.data.first : {};
    return reportData.columns.map((columnName) {
      final sampleValue = firstRow[columnName];

      return PlutoColumn(
        title: turkish.toUpperCase(columnName),
        field: columnName,
        type: getColumnType(columnName, sampleValue),
        sort: (state.sortColumn?.field == columnName)
            ? (state.sorting ?? PlutoColumnSort.none)
            : PlutoColumnSort.none,
        enableFilterMenuItem: true,
      );
    }).toList();
  }

  /// Kolon tipi belirleme (rapor modeline göre)
  PlutoColumnType getColumnType(String columnName, dynamic sampleValue) {
    // null ise text
    if (sampleValue == null) {
      return PlutoColumnType.text();
    }

    if (sampleValue is num) {
      return PlutoColumnType.number(format: '###,###.##', negative: true);
    }

    if (sampleValue is bool) {
      return PlutoColumnType.text();
    }

    if (sampleValue is DateTime) {
      return PlutoColumnType.date(format: 'dd.MM.yyyy');
    }

    if (sampleValue is String) {
      // ISO datetime gibi geliyor: "2025-11-26T00:00:00.000"
      try {
        final dt = DateTime.parse(sampleValue);
        // içinde saat var mı kontrol et
        if (dt.hour != 0 || dt.minute != 0 || dt.second != 0) {
          return PlutoColumnType.time();
        }
        return PlutoColumnType.date(format: 'dd.MM.yyyy');
      } catch (_) {
        // numeric string olabilir
        final numVal = num.tryParse(sampleValue.replaceAll(',', '.'));
        if (numVal != null) {
          return PlutoColumnType.number(format: '###,###.##', negative: true);
        }
        return PlutoColumnType.text();
      }
    }

    return PlutoColumnType.text();
  }

  /// PlutoGrid sort event'i buraya bağlanabilir
  void changeSort({
    required PlutoColumnSort sortType,
    required PlutoColumn sortColumn,
  }) {
    if (reportData == null) return;

    final sortedList = List<Map<String, dynamic>>.from(reportData!.data);

    sortedList.sort((a, b) {
      final av = a[sortColumn.field];
      final bv = b[sortColumn.field];

      // null güvenliği
      if (av == null && bv == null) return 0;
      if (av == null) return -1;
      if (bv == null) return 1;

      int result;
      if (av is num && bv is num) {
        result = av.compareTo(bv);
      } else {
        result = av.toString().compareTo(bv.toString());
      }

      return sortType.isAscending ? result : -result;
    });

    // reportData'yı kopyalamak yerine state'in rows'unu güncelliyorum
    final newRows = sortedList.map((row) {
      final cells = <String, PlutoCell>{};
      for (final colName in reportData!.columns) {
        cells[colName] = PlutoCell(value: row[colName]);
      }
      return PlutoRow(cells: cells);
    }).toList();

    emit(
      state.copyWith(
        sorting: sortType,
        sortColumn: sortColumn,
        sortTable: reportData,
        rows: newRows,
      ),
    );
  }
}

/// STATE

class DataTableState {
  final PlutoColumnSort? sorting;
  final PlutoColumn? sortColumn;
  final ReportData? sortTable;
  final List<PlutoColumn> columns;
  final List<PlutoRow> rows;

  const DataTableState({
    this.sorting,
    this.sortColumn,
    this.sortTable,
    this.columns = const [],
    this.rows = const [],
  });

  DataTableState copyWith({
    PlutoColumnSort? sorting,
    PlutoColumn? sortColumn,
    ReportData? sortTable,
    List<PlutoColumn>? columns,
    List<PlutoRow>? rows,
  }) {
    return DataTableState(
      sorting: sorting ?? this.sorting,
      sortColumn: sortColumn ?? this.sortColumn,
      sortTable: sortTable ?? this.sortTable,
      columns: columns ?? this.columns,
      rows: rows ?? this.rows,
    );
  }
}

class DataTableInitial extends DataTableState {
  const DataTableInitial()
    : super(
        sorting: PlutoColumnSort.none,
        sortColumn: null,
        sortTable: null,
        columns: const [],
        rows: const [],
      );
}
