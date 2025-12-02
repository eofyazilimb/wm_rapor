import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wm_rapor/model/report_model.dart';
// Model dosyanızın yolu

class FilterState {
  final List<Raporfiltreler> filters;

  FilterState(this.filters);
}

class FilterCubit extends Cubit<FilterState> {
  FilterCubit(List<Raporfiltreler> initialFilters) : super(FilterState([])) {
    _initialize(initialFilters);
  }

  void _initialize(List<Raporfiltreler> initialFilters) {
    // Listeyi deep copy (kopya) olarak alıyoruz ki ana veriyi bozmayalım
    // JSON dönüşümü basit bir deep copy yöntemidir.
    List<Raporfiltreler> copiedList = initialFilters
        .map((e) => Raporfiltreler.fromJson(e.toJson()))
        .toList();
    emit(FilterState(copiedList));
  }

  // Filtre Değerini Güncelle (Text, Date vs.)
  void updateFilterValue(int index, String value) {
    final updatedFilters = List<Raporfiltreler>.from(state.filters);
    updatedFilters[index].degerilk = value;
    emit(FilterState(updatedFilters));
  }

  // Karşılaştırma Tipini Güncelle (Eşittir, Büyüktür vs.)
  void updateFilterCondition(int index, int conditionValue) {
    final updatedFilters = List<Raporfiltreler>.from(state.filters);
    updatedFilters[index].kosul = conditionValue;
    emit(FilterState(updatedFilters));
  }

  // Tüm filtreleri temizle
  void clearFilters() {
    final updatedFilters = List<Raporfiltreler>.from(state.filters);
    for (var filter in updatedFilters) {
      filter.degerilk = "";
    }
    emit(FilterState(updatedFilters));
  }
}
