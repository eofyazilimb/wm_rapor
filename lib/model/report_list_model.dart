class ReportListModel {
  String? aciklama;
  String? tanim;
  String? ondegerdizayn;
  String? nesneadi;
  bool? mobil;
  bool? aktif;
  bool? servis;
  int? rapormodulu;
  bool? hazirsorgukullan;
  String? sorgurefid;
  int? raporturu;
  int? raporyerid;
  bool? ondeger;
  bool? webrapor;
  String? musterikodu;
  String? yoneticikodu;
  String? yetkikodu;
  String? raporkodu1;
  int? id;
  String? refid;
  String? eklemetarihi;
  int? ekleyen;
  String? degisimtarihi;
  int? degistiren;
  bool? cikarildi;
  int? cikaran;
  int? evrakkayitdurumu;

  ReportListModel({
    this.aciklama,
    this.tanim,
    this.ondegerdizayn,
    this.nesneadi,
    this.mobil,
    this.aktif,
    this.servis,
    this.rapormodulu,
    this.hazirsorgukullan,
    this.sorgurefid,
    this.raporturu,
    this.raporyerid,
    this.ondeger,
    this.webrapor,
    this.musterikodu,
    this.yoneticikodu,
    this.yetkikodu,
    this.raporkodu1,
    this.id,
    this.refid,
    this.eklemetarihi,
    this.ekleyen,
    this.degisimtarihi,
    this.degistiren,
    this.cikarildi,
    this.cikaran,
    this.evrakkayitdurumu,
  });

  ReportListModel.fromJson(Map<String, dynamic> json) {
    aciklama = json['aciklama'];
    tanim = json['tanim'];
    ondegerdizayn = json['ondegerdizayn'];
    nesneadi = json['nesneadi'];
    mobil = json['mobil'];
    aktif = json['aktif'];
    servis = json['servis'];
    rapormodulu = json['rapormodulu'];
    hazirsorgukullan = json['hazirsorgukullan'];
    sorgurefid = json['sorgurefid'];
    raporturu = json['raporturu'];
    raporyerid = json['raporyerid'];
    ondeger = json['ondeger'];
    webrapor = json['webrapor'];
    musterikodu = json['musterikodu'];
    yoneticikodu = json['yoneticikodu'];
    yetkikodu = json['yetkikodu'];
    raporkodu1 = json['raporkodu1'];
    id = json['id'];
    refid = json['refid'];
    eklemetarihi = json['eklemetarihi'];
    ekleyen = json['ekleyen'];
    degisimtarihi = json['degisimtarihi'];
    degistiren = json['degistiren'];
    cikarildi = json['cikarildi'];
    cikaran = json['cikaran'];
    evrakkayitdurumu = json['evrakkayitdurumu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aciklama'] = aciklama;
    data['tanim'] = tanim;
    data['ondegerdizayn'] = ondegerdizayn;
    data['nesneadi'] = nesneadi;
    data['mobil'] = mobil;
    data['aktif'] = aktif;
    data['servis'] = servis;
    data['rapormodulu'] = rapormodulu;
    data['hazirsorgukullan'] = hazirsorgukullan;
    data['sorgurefid'] = sorgurefid;
    data['raporturu'] = raporturu;
    data['raporyerid'] = raporyerid;
    data['ondeger'] = ondeger;
    data['webrapor'] = webrapor;
    data['musterikodu'] = musterikodu;
    data['yoneticikodu'] = yoneticikodu;
    data['yetkikodu'] = yetkikodu;
    data['raporkodu1'] = raporkodu1;
    data['id'] = id;
    data['refid'] = refid;
    data['eklemetarihi'] = eklemetarihi;
    data['ekleyen'] = ekleyen;
    data['degisimtarihi'] = degisimtarihi;
    data['degistiren'] = degistiren;
    data['cikarildi'] = cikarildi;
    data['cikaran'] = cikaran;
    data['evrakkayitdurumu'] = evrakkayitdurumu;
    return data;
  }
}
