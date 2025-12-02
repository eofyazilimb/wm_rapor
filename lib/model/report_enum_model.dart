import 'package:wm_rapor/model/nrname_model.dart';

class ReportEnumModel {
  List<NrNameEnum>? yetkiRaporlar;

  ReportEnumModel({this.yetkiRaporlar});

  ReportEnumModel.fromJson(Map<String, dynamic> json) {
    if (json['yetkiRaporlar'] != null) {
      yetkiRaporlar = <NrNameEnum>[];
      json['yetkiRaporlar'].forEach((v) {
        yetkiRaporlar!.add(NrNameEnum.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (yetkiRaporlar != null) {
      data['yetkiRaporlar'] = yetkiRaporlar!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
