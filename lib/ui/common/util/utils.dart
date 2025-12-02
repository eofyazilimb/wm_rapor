import 'package:wm_rapor/model/report_model.dart';

class Utils {
  Map<String, dynamic> filterMap({
    String? propertyName,
    dynamic beginValue,
    String? endValue,
    int? comparison,
    int? connector,
  }) {
    return {
      "propertyName": propertyName ?? '',
      "beginValue": beginValue ?? '',
      "endValue": endValue ?? '',
      "comparison": comparison ?? 0,
      "connector": connector ?? 0,
    };
  }

  Map<String, dynamic> fetchReportMap({
    int? reportId,
    String? refId,
    List<Raporfiltreler>? filtre,
  }) {
    return {
      "raporId": reportId ?? 0,
      "refid": refId ?? "",
      "filtreler": filtre ?? [],
      "pageSize": 50,
      "pageIndex": 0,
      "usePagination": true,
    };
  }
}
