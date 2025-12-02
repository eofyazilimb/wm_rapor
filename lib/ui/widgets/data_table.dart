import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:wm_rapor/document/document.dart';
import 'package:wm_rapor/document/pdf/pluto_grid_pdf_export.dart' as pdfexport;
import 'package:wm_rapor/model/report_data_model.dart';
import 'package:wm_rapor/ui/common/app_colors.dart';
import 'package:wm_rapor/utils/table_filter_utils.dart';
import 'package:wm_rapor/viewmodel/data_table_cubit.dart';
import 'package:pluto_grid_plus_export/pluto_grid_plus_export.dart'
    as pluto_grid_export;

class DataTableReport extends StatelessWidget {
  final ReportData reportData;
  final String reportName;
  double? height;
  final (bool, bool, bool) headerButtonsVisibility;
  late PlutoGridStateManager stateManager;

  DataTableReport({
    this.height,
    required this.reportData,
    required this.reportName,
    required this.headerButtonsVisibility,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dataTableCubit = context.read<DataTableCubit>();

    // Bu rapor için tablo henüz yüklenmediyse yükle
    if (dataTableCubit.reportData == null) {
      dataTableCubit.loadReportTable(reportData, name: reportName);
    }

    return BlocBuilder<DataTableCubit, DataTableState>(
      builder: (context, state) {
        return buildPlutoGrid(context, state);
      },
    );
  }

  buildPlutoGrid(BuildContext context, DataTableState state) {
    return Container(
      key: ValueKey(Uuid().v1()),
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: height,
        child: PlutoGrid(
          key: UniqueKey(),
          configuration: PlutoGridConfiguration(
            localeText: PlutoGridLocaleText.turkish(),
            style: const PlutoGridStyleConfig(
              //rowHeight: 30, columnHeight: 30,
              //   oddRowColor: EOFUIColors.lightGrey,

              //  cellColorGroupedRow: Color.fromARGB(128, 220, 219, 219),
            ),
            columnFilter: PlutoGridColumnFilterConfig(
              filters: [
                //  ...FilterHelper.defaultFilters,
                // custom filter
                TextContainsFilter(),
                GreaterThanFilter(),
                LessThanFilter(),
                EqualsFilter(),
                // DateGreaterThanFilter(),
                // DateLessThanFilter()
              ],
              resolveDefaultColumnFilter: (column, resolver) {
                if (column.type is PlutoColumnTypeText) {
                  return resolver<TextContainsFilter>() as PlutoFilterType;
                }
                if (column.type is PlutoColumnTypeDate) {
                  return resolver<EqualsFilter>() as PlutoFilterType;
                }
                if (column.type is PlutoColumnTypeNumber) {
                  return resolver<GreaterThanFilter>() as PlutoFilterType;
                }
                return resolver<TextContainsFilter>() as PlutoFilterType;
              },
            ),
          ),
          noRowsWidget: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 222, 223, 223),
                border: Border.all(color: Color.fromARGB(255, 165, 164, 164)),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue),
                    SizedBox(height: 5),
                    Text(
                      'Kayıt yok',
                      style: TextStyle(
                        color: Color.fromARGB(253, 116, 115, 115),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          mode: PlutoGridMode.readOnly,
          columns: state.columns,
          rows: state.rows,

          //columnGroups: columnGroups,
          onLoaded: (PlutoGridOnLoadedEvent event) {
            stateManager = event.stateManager;

            stateManager.setSortOnlyEvent(true);
            event.stateManager.setShowColumnFilter(true);

            //stateManager.setShowColumnFilter(false);
          },
          onChanged: (PlutoGridOnChangedEvent event) {},
          onSorted: (event) {
            context.read<DataTableCubit>().changeSort(
              sortType: event.column.sort,
              sortColumn: event.column,
            );
          },
          createHeader: (stateManager) => ExportHeader(
            stateManager: stateManager,
            reportName: reportName,
            reportData: reportData,
            headerButtonsVisibility: headerButtonsVisibility,
          ),
          createFooter: (stateManager) {
            stateManager.setPageSize(500, notify: false); // default 40
            return PlutoPagination(stateManager);
          },
        ),
      ),
    );
  }

  List<PlutoColumn> createPlutoColumns(
    BuildContext context,
    DataTableState state,
    ReportData reportData,
  ) {
    final firstRow = reportData.data.isNotEmpty ? reportData.data.first : {};

    return reportData.columns.map((columnName) {
      final sampleValue = firstRow[columnName];

      return PlutoColumn(
        title: columnName,
        field: columnName,
        type: context.read<DataTableCubit>().getColumnType(
          columnName,
          sampleValue,
        ),
        sort: (state.sortColumn?.field == columnName)
            ? (state.sorting ?? PlutoColumnSort.none)
            : PlutoColumnSort.none,
        enableFilterMenuItem: true,
      );
    }).toList();
  }

  PlutoColumnType getColumnType(String header, Map<String, dynamic> value) {
    if (header.contains("Tarih") || header.contains("TARIH")) {
      return PlutoColumnType.date(format: "dd.MM.yyyy");
    } else if (header.contains("Saat") || header.contains("SAAT")) {
      return PlutoColumnType.time();
    } else if (value[header].runtimeType == double ||
        value[header].runtimeType == int) {
      return PlutoColumnType.number(locale: 'TR-tr', format: '#.###');
    } else {
      return PlutoColumnType.text();
    }
  }

  bool enableFilter(String header, Map<String, dynamic> value) {
    if (getColumnType(header, reportData.data[0]) is PlutoColumnTypeText) {
      return true;
    } else {
      return false;
    }
  }
}

class ExportHeader extends StatefulWidget {
  final PlutoGridStateManager stateManager;
  final String reportName;
  final ReportData reportData;
  final (bool, bool, bool) headerButtonsVisibility;

  const ExportHeader({
    required this.stateManager,
    super.key,
    required this.reportName,
    required this.reportData,
    required this.headerButtonsVisibility,
  });

  @override
  State<StatefulWidget> createState() => ExportHeaderState();
}

class ExportHeaderState extends State<ExportHeader> {
  DateFormat df = DateFormat("ddMMyyyyHHmmss");
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 246, 245, 245),
        border: Border(
          top: BorderSide(color: Color(0xAAabaeb6)),
          left: BorderSide(color: Color(0xAAabaeb6)),
          right: BorderSide(color: Color(0xAAabaeb6)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.reportName,
                style: const TextStyle(
                  color: Color.fromARGB(255, 100, 100, 100),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /* IconButton(
                onPressed: () {
                  exportToPdfAndShare();
                },
                icon: const Icon(Icons.share,
                    color: Color.fromARGB(255, 72, 119, 220))),*/
              Visibility(
                visible: widget.headerButtonsVisibility.$1,
                child: SizedBox(
                  width: 33,
                  height: 24,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      exportToPdfAndShare();
                      //defaultExportGridAsCSVCompatibleWithExcel();
                    },
                    icon: PhosphorIcon(
                      PhosphorIcons.filePdf(),
                      size: 24,
                      color: AppColors.kcRed,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.headerButtonsVisibility.$2,
                child: SizedBox(
                  width: 33,
                  height: 24,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      exportToCsvAndShare();
                      //defaultExportGridAsCSVCompatibleWithExcel();
                    },
                    icon: PhosphorIcon(
                      PhosphorIcons.fileCsv(),
                      size: 24,
                      color: AppColors.kcGreen,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.headerButtonsVisibility.$3,
                child: SizedBox(
                  width: 33,
                  height: 24,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return Scaffold(
                            appBar: AppBar(title: Text(widget.reportName)),
                            body: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    width: MediaQuery.of(context).size.width,
                                    child: DataTableReport(
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.8,
                                      reportName: widget.reportName,
                                      reportData: widget.reportData,
                                      headerButtonsVisibility: (
                                        true,
                                        true,
                                        false,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ).then((value) {});
                    },
                    icon: PhosphorIcon(
                      PhosphorIcons.arrowsOut(),
                      size: 24,
                      color: AppColors.kcBlueGray,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void exportToPdfAndShare() async {
    // final themeData = pluto_grid_export.ThemeData.withFont(
    //   base: pluto_grid_export.Font.ttf(
    //     await rootBundle.load('assets/fonts/OpenSans-Regular.ttf'),
    //   ),
    //   bold: pluto_grid_export.Font.ttf(
    //     await rootBundle.load('assets/fonts/OpenSans-Bold.ttf'),
    //   ),
    // );

    var plutoGridPdfExport = pdfexport.PlutoGridDefaultPdfExport(
      title: widget.reportName,
      creator: "BaseService.userInfo!.aCIKLAMA",
      format: pluto_grid_export.PdfPageFormat.a4,
      // themeData: themeData,
    );

    await pluto_grid_export.Printing.sharePdf(
      bytes: await plutoGridPdfExport.export(widget.stateManager),
      filename: plutoGridPdfExport.getFilename(),
    );
  }

  void exportToPdf() async {
    // EasyLoading.showInfo("Lütfen Bekleyin...",
    //     maskType: EasyLoadingMaskType.black, dismissOnTap: false);
    final themeData = pluto_grid_export.ThemeData.withFont(
      base: pluto_grid_export.Font.ttf(
        await rootBundle.load('assets/fonts/OpenSans-Regular.ttf'),
      ),
      bold: pluto_grid_export.Font.ttf(
        await rootBundle.load('assets/fonts/OpenSans-Bold.ttf'),
      ),
    );

    var plutoGridPdfExport = pdfexport.PlutoGridDefaultPdfExport(
      title: widget.reportName,
      creator: "BaseService.userInfo!.aCIKLAMA",
      format: pluto_grid_export.PdfPageFormat.a4,
      themeData: themeData,
    );

    var exported = await plutoGridPdfExport.export(widget.stateManager);

    String fileName = "${widget.reportName}-${df.format(DateTime.now())}";

    //Document().saveAndDownloadFile(file, exported);
    //Document().downloadFile(fileName, exported, "pdf");
  }

  void exportToCsvAndShare() async {
    // EasyLoading.showInfo("Lütfen Bekleyin...",
    //     dismissOnTap: false, maskType: EasyLoadingMaskType.black);
    String fileName = "${widget.reportName}-${df.format(DateTime.now())}";

    var exportCSV = pluto_grid_export.PlutoGridExport.exportCSV(
      widget.stateManager,
      eol: '\n',
    );
    var exported = const Utf8Encoder().convert(
      pluto_grid_export.PlutoGridExport.exportCSV(widget.stateManager),
    );

    final box = context.findRenderObject() as RenderBox?;
    Document().shareFile(
      fileName: fileName,
      bytes: exported,
      ext: "csv",
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  /*void defaultExportGridAsCSVCompatibleWithExcel() async {
    EasyLoading.showInfo("Lütfen Bekleyin...");
    String fileName =
        "${widget.reportName}-${DateTime.now().millisecondsSinceEpoch}";
    Directory dir = Platform.isAndroid
        ? Directory('/storage/emulated/0/Download/')
        : await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/$fileName.csv');

    var exportCSV =
        pluto_grid_export.PlutoGridExport.exportCSV(widget.stateManager);
    var exported = const Utf8Encoder().convert(
        // FIX Add starting \u{FEFF} / 0xEF, 0xBB, 0xBF
        // This allows open the file in Excel with proper character interpretation
        // See https://stackoverflow.com/a/155176
        '\u{FEFF}$exportCSV');

    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        status = await Permission.storage.request();
      }
      if (status.isGranted) {
        try {
          await file.writeAsBytes(exported.buffer
              .asUint8List(exported.offsetInBytes, exported.lengthInBytes));
          EasyLoading.dismiss();
        } on FileSystemException catch (err) {
          throw err;
        }
      }
    } else if (Platform.isIOS) {
      try {
        await file.writeAsBytes(exported.buffer
            .asUint8List(exported.offsetInBytes, exported.lengthInBytes));
        EasyLoading.dismiss();
      } on FileSystemException catch (err) {
        throw err;
      }
    }*/
}
