class ReportModel {
  String? aciklama;
  String? tanim;
  String? ondegerdizayn;
  String? nesneadi;
  String? raporsorgusu;
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
  List<Raporfiltreler>? raporfiltreler;
  List<Raporicerikler>? raporicerikler;
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

  ReportModel({
    this.aciklama,
    this.tanim,
    this.ondegerdizayn,
    this.nesneadi,
    this.raporsorgusu,
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
    this.raporfiltreler,
    this.raporicerikler,
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

  ReportModel.fromJson(Map<String, dynamic> json) {
    aciklama = json['aciklama'];
    tanim = json['tanim'];
    ondegerdizayn = json['ondegerdizayn'];
    nesneadi = json['nesneadi'];
    raporsorgusu = json['raporsorgusu'];
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
    if (json['raporfiltreler'] != null) {
      raporfiltreler = <Raporfiltreler>[];
      json['raporfiltreler'].forEach((v) {
        raporfiltreler!.add(Raporfiltreler.fromJson(v));
      });
    }
    if (json['raporicerikler'] != null) {
      raporicerikler = <Raporicerikler>[];
      json['raporicerikler'].forEach((v) {
        raporicerikler!.add(Raporicerikler.fromJson(v));
      });
    }
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
    data['raporsorgusu'] = raporsorgusu;
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
    if (raporfiltreler != null) {
      data['raporfiltreler'] = raporfiltreler!.map((v) => v.toJson()).toList();
    }
    if (raporicerikler != null) {
      data['raporicerikler'] = raporicerikler!.map((v) => v.toJson()).toList();
    }
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

class Raporfiltreler {
  int? raporid;
  String? alanadi;
  int? verituru;
  int? kosul;
  String? degerilk;
  int? sirano;
  int? nesnetipi;
  int? kullanimsekli;
  int? kaynaktipi;
  String? filtreadi;
  String? degerson;
  String? enumtipi;
  int? id;
  String? refid;
  int? ekleyen;
  int? degistiren;
  bool? cikarildi;
  int? cikaran;
  int? evrakkayitdurumu;

  Raporfiltreler({
    this.raporid,
    this.alanadi,
    this.verituru,
    this.kosul,
    this.degerilk,
    this.sirano,
    this.nesnetipi,
    this.kullanimsekli,
    this.kaynaktipi,
    this.filtreadi,
    this.degerson,
    this.enumtipi,
    this.id,
    this.refid,
    this.ekleyen,
    this.degistiren,
    this.cikarildi,
    this.cikaran,
    this.evrakkayitdurumu,
  });

  Raporfiltreler.fromJson(Map<String, dynamic> json) {
    raporid = json['raporid'];
    alanadi = json['alanadi'];
    verituru = json['verituru'];
    kosul = json['kosul'];
    degerilk = json['degerilk'];
    sirano = json['sirano'];
    nesnetipi = json['nesnetipi'];
    kullanimsekli = json['kullanimsekli'];
    kaynaktipi = json['kaynaktipi'];
    filtreadi = json['filtreadi'];
    degerson = json['degerson'];
    enumtipi = json['enumtipi'];
    id = json['id'];
    refid = json['refid'];
    ekleyen = json['ekleyen'];
    degistiren = json['degistiren'];
    cikarildi = json['cikarildi'];
    cikaran = json['cikaran'];
    evrakkayitdurumu = json['evrakkayitdurumu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['raporid'] = raporid;
    data['alanadi'] = alanadi;
    data['verituru'] = verituru;
    data['kosul'] = kosul;
    data['degerilk'] = degerilk;
    data['sirano'] = sirano;
    data['nesnetipi'] = nesnetipi;
    data['kullanimsekli'] = kullanimsekli;
    data['kaynaktipi'] = kaynaktipi;
    data['filtreadi'] = filtreadi;
    data['degerson'] = degerson;
    data['enumtipi'] = enumtipi;
    data['id'] = id;
    data['refid'] = refid;
    data['ekleyen'] = ekleyen;
    data['degistiren'] = degistiren;
    data['cikarildi'] = cikarildi;
    data['cikaran'] = cikaran;
    data['evrakkayitdurumu'] = evrakkayitdurumu;
    return data;
  }
}

class Raporicerikler {
  int? raporid;
  int? sirano;
  int? raporsekli;
  String? kolonadi;
  String? kolondeger;
  String? icerikadi;
  int? linename;
  int? linevalue;
  int? id;
  String? refid;
  int? ekleyen;
  int? degistiren;
  bool? cikarildi;
  int? cikaran;
  int? evrakkayitdurumu;

  Raporicerikler({
    this.raporid,
    this.sirano,
    this.raporsekli,
    this.kolonadi,
    this.kolondeger,
    this.icerikadi,
    this.linename,
    this.linevalue,
    this.id,
    this.refid,
    this.ekleyen,
    this.degistiren,
    this.cikarildi,
    this.cikaran,
    this.evrakkayitdurumu,
  });

  Raporicerikler.fromJson(Map<String, dynamic> json) {
    raporid = json['raporid'];
    sirano = json['sirano'];
    raporsekli = json['raporsekli'];
    kolonadi = json['kolonadi'];
    kolondeger = json['kolondeger'];
    icerikadi = json['icerikadi'];
    linename = json['linename'];
    linevalue = json['linevalue'];
    id = json['id'];
    refid = json['refid'];
    ekleyen = json['ekleyen'];
    degistiren = json['degistiren'];
    cikarildi = json['cikarildi'];
    cikaran = json['cikaran'];
    evrakkayitdurumu = json['evrakkayitdurumu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['raporid'] = raporid;
    data['sirano'] = sirano;
    data['raporsekli'] = raporsekli;
    data['kolonadi'] = kolonadi;
    data['kolondeger'] = kolondeger;
    data['icerikadi'] = icerikadi;
    data['linename'] = linename;
    data['linevalue'] = linevalue;
    data['id'] = id;
    data['refid'] = refid;
    data['ekleyen'] = ekleyen;
    data['degistiren'] = degistiren;
    data['cikarildi'] = cikarildi;
    data['cikaran'] = cikaran;
    data['evrakkayitdurumu'] = evrakkayitdurumu;
    return data;
  }
}
