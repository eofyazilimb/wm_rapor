class ReportData {
  final List<Map<String, dynamic>> data;
  final List<String> columns;
  final int totalCount;
  final int pageIndex;
  final int pageSize;
  final bool hasMoreData;

  const ReportData({
    required this.data,
    required this.columns,
    required this.totalCount,
    required this.pageIndex,
    required this.pageSize,
    required this.hasMoreData,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) {
    return ReportData(
      data: (json['data'] as List)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList(),
      columns: (json['columns'] as List).map((e) => e.toString()).toList(),
      totalCount: json['totalCount'] ?? 0,
      pageIndex: json['pageIndex'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      hasMoreData: json['hasMoreData'] ?? false,
    );
  }
}
