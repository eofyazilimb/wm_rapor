class ReportMenuItemModel {
  final int id;
  final String aciklama;
  final String etiket;
  final String iconUrl;
  final String route;
  final bool enabled;

  ReportMenuItemModel({
    required this.id,
    required this.aciklama,
    required this.etiket,
    required this.iconUrl,
    required this.route,
    required this.enabled,
  });

  factory ReportMenuItemModel.fromJson(Map<String, dynamic> json) {
    return ReportMenuItemModel(
      id: json['id'] as int,
      aciklama: json['aciklama'] ?? '',
      etiket: json['etiket'] ?? '',
      iconUrl: json['iconurl'] ?? '',
      route: json['mobilurl'] ?? '',
      enabled: !(json['cikarildi'] as bool),
    );
  }
}
