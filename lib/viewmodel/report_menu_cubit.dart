import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wm_rapor/model/report_enum_model.dart';
import 'package:wm_rapor/services/repository/report_repository.dart';
import 'package:wm_rapor/singleton/report_singleton.dart';
import 'package:wm_rapor/ui/common/app_constants.dart';

class ReportMenuCubit extends Cubit<ReportMenuCubitState> {
  ReportMenuCubit() : super(ReportMenuCubitState());

  initPage() async {
    emit(state.copyWith(initPageRequest: RequestState.loading));
    final responseReportEnum = await ReportRepository().getEnumsReport();
    if (responseReportEnum.durum ?? false) {
      final reportEnums = ReportEnumModel.fromJson(
        Map<String, dynamic>.from(responseReportEnum.nesneler),
      );
      ReportSingleton().setReportEnums = reportEnums;

      emit(state.copyWith(initPageRequest: RequestState.success));
      emit(state.copyWith(initPageRequest: RequestState.initial));
    } else {
      emit(state.copyWith(initPageRequest: RequestState.error));
      emit(state.copyWith(initPageRequest: RequestState.initial));
    }
  }
}

class ReportMenuCubitState {
  final RequestState? initPageRequest;
  ReportMenuCubitState({this.initPageRequest});

  ReportMenuCubitState copyWith({RequestState? initPageRequest}) {
    return ReportMenuCubitState(
      initPageRequest: initPageRequest ?? this.initPageRequest,
    );
  }
}
