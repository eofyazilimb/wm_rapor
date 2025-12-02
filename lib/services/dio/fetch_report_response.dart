class FetchReportResponse {
  List? data;
  List? columns;
  int? totalCount; // uyarı /hata mesajı
  int? pageIndex; // gelen veri
  int? pageSize;
  bool? hasMoreData;
  FetchReportResponse.fromJson(Map json) {
    data = json["data"];
    columns = json["columns"];
    totalCount = json["totalCount"];
    pageIndex = json["pageIndex"];
    pageSize = json["pageSize"];
    hasMoreData = json["hasMoreData"];
  }

  Map<String, dynamic> toJson() {
    return {
      "data": data,
      "columns": columns,
      "totalCount": totalCount,
      "pageIndex": pageIndex,
      "pageSize": pageSize,
      "hasMoreData": hasMoreData,
    };
  }

  FetchReportResponse.timeout();
}
