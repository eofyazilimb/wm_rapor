import 'package:wm_rapor/services/constants/http_constants.dart';
import 'package:wm_rapor/services/dio/api_response.dart';
import 'package:wm_rapor/services/dio/dio_client.dart';
import 'package:wm_rapor/services/dio/fetch_report_response.dart';
import 'package:wm_rapor/services/repository/base_repository.dart';

class ReportRepository extends BaseRepository {
  @override
  // ignore: overridden_fields
  DioClient dioClient = DioClient();

  Future<ApiResponse> getEnumsReport() {
    String path = HttpConstants.getEnumReport;
    return dioClient.get(path);
  }

  Future<FetchReportResponse> fetchReport(Map<String, dynamic> data) {
    String path = HttpConstants.fetchReport;
    return dioClient.postFetchReport(path, data: data);
  }

  @override
  String get listPath => HttpConstants.listReport;

  @override
  String get pagingPath => HttpConstants.pagingReport;

  @override
  String get addingPath => HttpConstants.addingReport;

  @override
  String get editingPath => HttpConstants.editingReport;

  @override
  String get itemPath => HttpConstants.itemReport;

  @override
  String get deletingPath => HttpConstants.deletingReport;
}
