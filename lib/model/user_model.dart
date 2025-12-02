class User {
  String? kullaniciadi;
  String? kullanicisoyadi;
  int? kullanicigrupid;
  String? kullanicisifre;
  String? ceptelefon;
  bool? aktif;
  String? kullanicieposta;
  bool? epostaonayli;
  bool? telefononayli;
  bool? ikilidogrulama;
  String? rol;
  String? adisoyadi;
  String? sifre;
  int? kurumid;
  int? firmanr;
  int? subenr;
  int? departmannr;
  int? deponr;
  String? raporkod1;
  String? yetkikodu;
  List? getKurums;
  int? id;
  String? refid;
  String? eklemetarihi;
  int? ekleyenid;
  String? degisimtarihi;
  int? degistirenid;
  bool? cikarildi;
  String? cikarilmatarihi;
  int? cikaranid;

  User({
    this.kullaniciadi,
    this.kullanicisoyadi,
    this.kullanicigrupid,
    this.kullanicisifre,
    this.ceptelefon,
    this.aktif,
    this.kullanicieposta,
    this.epostaonayli,
    this.telefononayli,
    this.ikilidogrulama,
    this.rol,
    this.adisoyadi,
    this.sifre,
    this.kurumid,
    this.firmanr,
    this.subenr,
    this.departmannr,
    this.deponr,
    this.raporkod1,
    this.yetkikodu,
    this.getKurums,
    this.id,
    this.refid,
    this.eklemetarihi,
    this.ekleyenid,
    this.degisimtarihi,
    this.degistirenid,
    this.cikarildi,
    this.cikarilmatarihi,
    this.cikaranid,
  });

  User.fromJson(Map<String, dynamic> json) {
    kullaniciadi = json['kullaniciadi'];
    kullanicisoyadi = json['kullanicisoyadi'];
    kullanicigrupid = json['kullanicigrupid'];
    kullanicisifre = json['kullanicisifre'];
    ceptelefon = json['ceptelefon'];
    aktif = json['aktif'];
    kullanicieposta = json['kullanicieposta'];
    epostaonayli = json['epostaonayli'];
    telefononayli = json['telefononayli'];
    ikilidogrulama = json['ikilidogrulama'];
    rol = json['rol'];
    adisoyadi = json['adisoyadi'];
    sifre = json['sifre'];
    kurumid = json['kurumid'];
    firmanr = json['firmanr'];
    subenr = json['subenr'];
    departmannr = json['departmannr'];
    deponr = json['deponr'];
    raporkod1 = json['raporkod1'];
    yetkikodu = json['yetkikodu'];
    getKurums = json['getKurums'];
    id = json['id'];
    refid = json['refid'];
    eklemetarihi = json['eklemetarihi'];
    ekleyenid = json['ekleyenid'];
    degisimtarihi = json['degisimtarihi'];
    degistirenid = json['degistirenid'];
    cikarildi = json['cikarildi'];
    cikarilmatarihi = json['cikarilmatarihi'];
    cikaranid = json['cikaranid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kullaniciadi'] = kullaniciadi;
    data['kullanicisoyadi'] = kullanicisoyadi;
    data['kullanicigrupid'] = kullanicigrupid;
    data['kullanicisifre'] = kullanicisifre;
    data['ceptelefon'] = ceptelefon;
    data['aktif'] = aktif;
    data['kullanicieposta'] = kullanicieposta;
    data['epostaonayli'] = epostaonayli;
    data['telefononayli'] = telefononayli;
    data['ikilidogrulama'] = ikilidogrulama;
    data['rol'] = rol;
    data['adisoyadi'] = adisoyadi;
    data['sifre'] = sifre;
    data['kurumid'] = kurumid;
    data['firmanr'] = firmanr;
    data['subenr'] = subenr;
    data['departmannr'] = departmannr;
    data['deponr'] = deponr;
    data['raporkod1'] = raporkod1;
    data['yetkikodu'] = yetkikodu;
    data['getKurums'] = getKurums;
    data['id'] = id;
    data['refid'] = refid;
    data['eklemetarihi'] = eklemetarihi;
    data['ekleyenid'] = ekleyenid;
    data['degisimtarihi'] = degisimtarihi;
    data['degistirenid'] = degistirenid;
    data['cikarildi'] = cikarildi;
    data['cikarilmatarihi'] = cikarilmatarihi;
    data['cikaranid'] = cikaranid;
    return data;
  }
}
