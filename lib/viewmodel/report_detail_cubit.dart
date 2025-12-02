import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wm_rapor/model/report_data_model.dart';
import 'package:wm_rapor/model/report_model.dart';
import 'package:wm_rapor/services/repository/report_repository.dart';
import 'package:wm_rapor/ui/common/app_constants.dart';
import 'package:wm_rapor/ui/common/util/utils.dart';

class ReportDetailCubitState {
  final RequestState? fetchRequest;
  final ReportData? reportData;
  final ReportModel? reportModel;

  // 1. Raporfiltreler listesini state'e ekledik (FilterCubit'ten taşındı)
  final List<Raporfiltreler> currentFilters;

  ReportDetailCubitState({
    this.fetchRequest,
    this.reportData,
    this.reportModel,
    this.currentFilters = const [],
  });

  // 2. copyWith metodu currentFilters'ı içerecek şekilde güncellendi
  ReportDetailCubitState copyWith({
    RequestState? fetchRequest,
    ReportData? reportData,
    ReportModel? reportModel,
    List<Raporfiltreler>? currentFilters,
  }) {
    return ReportDetailCubitState(
      fetchRequest: fetchRequest ?? this.fetchRequest,
      reportData: reportData ?? this.reportData,
      reportModel: reportModel ?? this.reportModel,
      currentFilters: currentFilters ?? this.currentFilters,
    );
  }
}

class ReportDetailCubit extends Cubit<ReportDetailCubitState> {
  ReportDetailCubit() : super(ReportDetailCubitState());

  // ===============================================
  // ✨ Filtre Yönetimi Metodları (FilterCubit'ten Taşındı)
  // ===============================================

  // Filtre Değerini Güncelle (Text, Date vs.)
  void updateFilterValue(int index, String value) {
    // Liste kopyalanıp üzerinde işlem yapılır (Immutable State Pattern)
    final updatedFilters = List<Raporfiltreler>.from(state.currentFilters);
    updatedFilters[index].degerilk = value;

    // YENİ STATE YAYINLA
    emit(state.copyWith(currentFilters: updatedFilters));
  }

  // Karşılaştırma Tipini Güncelle (Eşittir, Büyüktür vs.)
  void updateFilterCondition(int index, int conditionValue) {
    final updatedFilters = List<Raporfiltreler>.from(state.currentFilters);
    updatedFilters[index].kosul = conditionValue;

    // YENİ STATE YAYINLA
    emit(state.copyWith(currentFilters: updatedFilters));
  }

  // Tüm filtreleri temizle
  void clearFilters() {
    final updatedFilters = List<Raporfiltreler>.from(state.currentFilters);
    for (var filter in updatedFilters) {
      filter.degerilk = ""; // degerilk alanını temizle
    }

    // YENİ STATE YAYINLA
    emit(state.copyWith(currentFilters: updatedFilters));
  }

  // ===============================================
  // 🔄 Rapor Çekme Metodu (Güncellenmiş)
  // ===============================================

  Future<void> fetchReport(int id, {List<Raporfiltreler>? newFilters}) async {
    emit(state.copyWith(fetchRequest: RequestState.loading));

    try {
      // 1. Rapor Tanımını (Modelini) Çek
      final veriResponse = await ReportRepository().item(id);

      if (veriResponse.durum == true) {
        final raporModel = ReportModel.fromJson(veriResponse.nesneler);

        // Kullanılacak filtre listesi
        List<Raporfiltreler> filtersToApply = [];

        if (newFilters != null) {
          // Filtreler dışarıdan (Filtre Ekranından) geldiyse bunları kullan
          filtersToApply = newFilters;
        } else if (state.currentFilters.isNotEmpty) {
          // İlk yükleme değilse ve state'te filtre varsa onu kullan
          filtersToApply = state.currentFilters;
        } else {
          // İlk yüklemede, modelden gelen varsayılan filtreleri deep copy yap
          filtersToApply = (raporModel.raporfiltreler ?? [])
              .map((e) => Raporfiltreler.fromJson(e.toJson()))
              .toList();
        }

        // 2. Rapor Verisini Çek
        final data = Utils().fetchReportMap(
          reportId: raporModel.id,
          refId: raporModel.refid,
          // Uygulanacak filtre listesi API'ye gönderilir
          filtre: filtersToApply,
        );

        final veriGetirResponse = await ReportRepository().fetchReport(data);

        if (veriGetirResponse.columns != null &&
            veriGetirResponse.data != null) {
          final reportData = ReportData.fromJson(veriGetirResponse.toJson());

          emit(
            state.copyWith(
              fetchRequest: RequestState.success,
              reportData: reportData,
              reportModel: raporModel,
              currentFilters:
                  filtersToApply, // Filtrelerin son halini state'e kaydet
            ),
          );
        } else {
          emit(state.copyWith(fetchRequest: RequestState.error));
        }
      } else {
        emit(state.copyWith(fetchRequest: RequestState.error));
      }
    } catch (e) {
      // Hata durumunda, filtreleri koru
      emit(state.copyWith(fetchRequest: RequestState.error));
    }
  }
}
