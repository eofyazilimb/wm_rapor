import 'package:wm_rapor/services/constants/http_constants.dart';
import 'package:wm_rapor/services/dio/api_response.dart';
import 'package:wm_rapor/services/dio/dio_client.dart';

abstract class BaseRepository {
  final DioClient dioClient = DioClient();

  String get listPath;
  String get pagingPath;
  String get addingPath;
  String get editingPath;
  String get itemPath;
  String get deletingPath;

  Future<ApiResponse> listing(List<Map<String, dynamic>> data) {
    return dioClient.post(listPath, data: data);
  }

  Future<ApiResponse> paging(
    int dataSize,
    List<Map<String, dynamic>> data, {
    String? sortBy,
    String? sortOrder,
    int? pageSize,
  }) {
    Map<String, dynamic> queryParams = HttpConstants.pagingParamMap(
      dataSize: dataSize,
      pageSize: pageSize ?? HttpConstants.pageSize,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );

    return dioClient.post(pagingPath, data: data, queryParams: queryParams);
  }

  Future<ApiResponse> adding(Map<String, dynamic> data) {
    return dioClient.post(addingPath, data: data);
  }

  Future<ApiResponse> editing(Map<String, dynamic> data) {
    return dioClient.put(editingPath, data: data);
  }

  Future<ApiResponse> item(int id) {
    String path = '$itemPath($id)';
    return dioClient.get(path);
  }

  Future<ApiResponse> deleting(Map<String, dynamic> data) {
    return dioClient.delete(deletingPath, data: data);
  }
}
