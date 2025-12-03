// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wm_rapor/model/permission_model.dart';

import 'package:wm_rapor/model/report_list_model.dart';
import 'package:wm_rapor/services/dio/api_response.dart';
import 'package:wm_rapor/services/repository/report_repository.dart';
import 'package:wm_rapor/ui/common/app_constants.dart';
import 'package:wm_rapor/ui/common/util/utils.dart';

class ReportPagingCubit extends Cubit<ReportPagingCubitState> {
  late List<Map<String, dynamic>> data;
  late Permission? perm;
  int rapormodulu = 0;
  ReportPagingCubit() : super(ReportPagingCubitState());

  void searchControllerChanged(String? value) {
    emit(state.copyWith(searchccText: value));
  }

  clearSearchingList() {
    if (state.searchccText != null) {
      emit(state.copyWith(searchccText: ''));
    }
  }

  void initPagingPage(Permission? perm) {
    this.perm = perm;
    setValues();
    data = [];
    emit(state.copyWith(searchccText: '', listCount: "0"));
  }

  setValues() {
    switch (perm?.altgrup) {
      case 'KasaRaporları':
        rapormodulu = EnumRaporModulleri.kasa.value;
        break;
      case 'StokRaporları':
        rapormodulu = EnumRaporModulleri.malzemeHizmet.value;
        break;
      case 'SatınalmaRaporları':
        rapormodulu = EnumRaporModulleri.satinAlma.value;
        break;
      case 'SatışRaporları':
        rapormodulu = EnumRaporModulleri.satis.value;
        break;
      case 'CariRaporları':
        rapormodulu = EnumRaporModulleri.cari.value;
        break;
      case 'BankaRaporları':
        rapormodulu = EnumRaporModulleri.banka.value;
        break;
      case 'KıymetliEvrakRaporları':
        rapormodulu = EnumRaporModulleri.cekSenet.value;
        break;
      case 'ÖzelRaporlar':
        rapormodulu = EnumRaporModulleri.ozelRapor1.value;
        break;
      default:
    }
  }

  Future<List<dynamic>> pagingReport(int pageKey) async {
    final List<Map<String, dynamic>> filters = [];

    filters.add(
      Utils().filterMap(
        propertyName: "rapormodulu",
        beginValue: rapormodulu,
        connector: 0,
      ),
    );

    filters.add(
      Utils().filterMap(
        propertyName: "aktif",
        beginValue: "true",
        connector: 0,
      ),
    );

    filters.add(
      Utils().filterMap(
        propertyName: "mobil",
        beginValue: "true",
        connector: 0,
      ),
    );

    final bool hasSearch =
        (state.searchccText != null && state.searchccText!.trim().isNotEmpty);

    if (hasSearch) {
      Utils().addOrSearchGroupWithComparisons(
        filters: filters,
        properties: ["aciklama"],
        query: state.searchccText ?? '',
      );
    }

    data = filters;

    ApiResponse? listResponse;

    listResponse = await ReportRepository().paging(
      pageKey,
      data,
      sortBy: "id",
      sortOrder: "desc",
    );

    if (listResponse.durum ?? false) {
      List<dynamic> invList = [];
      invList = listResponse.nesneler
          .map<ReportListModel>((e) => ReportListModel.fromJson(e))
          .toList();

      emit(state.copyWith(listCount: listResponse.count.toString()));

      return invList;
    } else {
      return [];
    }
  }
}

class ReportPagingCubitState {
  final String? searchccText;
  final String? listCount;
  ReportPagingCubitState({this.searchccText, this.listCount});

  ReportPagingCubitState copyWith({String? searchccText, String? listCount}) {
    return ReportPagingCubitState(
      searchccText: searchccText ?? this.searchccText,
      listCount: listCount ?? this.listCount,
    );
  }
}
