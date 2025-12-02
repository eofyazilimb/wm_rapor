class Permission {
  int? id;
  String? refid;
  String? eklemetarihi;
  int? ekleyenid;
  String? degisimtarihi;
  int? degistirenid;
  bool? cikarildi;
  String? cikarilmatarihi;
  int? cikaranid;
  int? kullaniciid;
  String? modul;
  String? anagrup;
  String? altgrup;
  String? sube;
  String? depo;
  String? yetkikodu;
  bool? ylistele;
  bool? yekle;
  bool? yguncelle;
  bool? ycikar;
  bool? ytam;
  String? nesne;
  String? etiket;
  bool? mobilkullanim;
  String? aciklama;
  String? mobilurl;
  String? resimurl;
  String? iconurl;
  int? kurumid;
  int? firmanr;
  int? evrakkayitdurumu;
  bool? favori;

  Permission({
    this.id,
    this.refid,
    this.eklemetarihi,
    this.ekleyenid,
    this.degisimtarihi,
    this.degistirenid,
    this.cikarildi,
    this.cikarilmatarihi,
    this.cikaranid,
    this.kullaniciid,
    this.modul,
    this.anagrup,
    this.altgrup,
    this.sube,
    this.depo,
    this.yetkikodu,
    this.ylistele,
    this.yekle,
    this.yguncelle,
    this.ycikar,
    this.ytam,
    this.nesne,
    this.etiket,
    this.mobilkullanim,
    this.aciklama,
    this.mobilurl,
    this.resimurl,
    this.iconurl,
    this.kurumid,
    this.firmanr,
    this.evrakkayitdurumu,
    this.favori,
  });

  Permission.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refid = json['refid'];
    eklemetarihi = json['eklemetarihi'];
    ekleyenid = json['ekleyenid'];
    degisimtarihi = json['degisimtarihi'];
    degistirenid = json['degistirenid'];
    cikarildi = json['cikarildi'];
    cikarilmatarihi = json['cikarilmatarihi'];
    cikaranid = json['cikaranid'];
    kullaniciid = json['kullaniciid'];
    modul = json['modul'];
    anagrup = json['anagrup'];
    altgrup = json['altgrup'];
    sube = json['sube'];
    depo = json['depo'];
    yetkikodu = json['yetkikodu'];
    ylistele = json['ylistele'];
    yekle = json['yekle'];
    yguncelle = json['yguncelle'];
    ycikar = json['ycikar'];
    ytam = json['ytam'];
    nesne = json['nesne'];
    etiket = json['etiket'];
    mobilkullanim = json['mobilkullanim'];
    aciklama = json['aciklama'];
    mobilurl = json['mobilurl'];
    resimurl = json['resimurl'];
    iconurl = json['iconurl'];
    kurumid = json['kurumid'];
    firmanr = json['firmanr'];
    evrakkayitdurumu = json['evrakkayitdurumu'];
    favori = json['favori'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['refid'] = refid;
    data['eklemetarihi'] = eklemetarihi;
    data['ekleyenid'] = ekleyenid;
    data['degisimtarihi'] = degisimtarihi;
    data['degistirenid'] = degistirenid;
    data['cikarildi'] = cikarildi;
    data['cikarilmatarihi'] = cikarilmatarihi;
    data['cikaranid'] = cikaranid;
    data['kullaniciid'] = kullaniciid;
    data['modul'] = modul;
    data['anagrup'] = anagrup;
    data['altgrup'] = altgrup;
    data['sube'] = sube;
    data['depo'] = depo;
    data['yetkikodu'] = yetkikodu;
    data['ylistele'] = ylistele;
    data['yekle'] = yekle;
    data['yguncelle'] = yguncelle;
    data['ycikar'] = ycikar;
    data['ytam'] = ytam;
    data['nesne'] = nesne;
    data['etiket'] = etiket;
    data['mobilkullanim'] = mobilkullanim;
    data['aciklama'] = aciklama;
    data['mobilurl'] = mobilurl;
    data['resimurl'] = resimurl;
    data['iconurl'] = iconurl;
    data['kurumid'] = kurumid;
    data['firmanr'] = firmanr;
    data['evrakkayitdurumu'] = evrakkayitdurumu;
    data['favori'] = favori;
    return data;
  }

  Permission copyWith({
    int? id,
    String? refid,
    String? eklemetarihi,
    int? ekleyenid,
    String? degisimtarihi,
    int? degistirenid,
    bool? cikarildi,
    String? cikarilmatarihi,
    int? cikaranid,
    int? kullaniciid,
    String? modul,
    String? anagrup,
    String? altgrup,
    String? sube,
    String? depo,
    String? yetkikodu,
    bool? ylistele,
    bool? yekle,
    bool? yguncelle,
    bool? ycikar,
    bool? ytam,
    String? nesne,
    String? etiket,
    bool? mobilkullanim,
    String? aciklama,
    String? mobilurl,
    String? resimurl,
    String? iconurl,
    int? kurumid,
    int? firmanr,
    int? evrakkayitdurumu,
    bool? favori,
  }) {
    return Permission(
      id: id ?? this.id,
      refid: refid ?? this.refid,
      eklemetarihi: eklemetarihi ?? this.eklemetarihi,
      ekleyenid: ekleyenid ?? this.ekleyenid,
      degisimtarihi: degisimtarihi ?? this.degisimtarihi,
      degistirenid: degistirenid ?? this.degistirenid,
      cikarildi: cikarildi ?? this.cikarildi,
      cikarilmatarihi: cikarilmatarihi ?? this.cikarilmatarihi,
      cikaranid: cikaranid ?? this.cikaranid,
      kullaniciid: kullaniciid ?? this.kullaniciid,
      modul: modul ?? this.modul,
      anagrup: anagrup ?? this.anagrup,
      altgrup: altgrup ?? this.altgrup,
      sube: sube ?? this.sube,
      depo: depo ?? this.depo,
      yetkikodu: yetkikodu ?? this.yetkikodu,
      ylistele: ylistele ?? this.ylistele,
      yekle: yekle ?? this.yekle,
      yguncelle: yguncelle ?? this.yguncelle,
      ycikar: ycikar ?? this.ycikar,
      ytam: ytam ?? this.ytam,
      nesne: nesne ?? this.nesne,
      etiket: etiket ?? this.etiket,
      mobilkullanim: mobilkullanim ?? this.mobilkullanim,
      aciklama: aciklama ?? this.aciklama,
      mobilurl: mobilurl ?? this.mobilurl,
      resimurl: resimurl ?? this.resimurl,
      iconurl: iconurl ?? this.iconurl,
      kurumid: kurumid ?? this.kurumid,
      firmanr: firmanr ?? this.firmanr,
      evrakkayitdurumu: evrakkayitdurumu ?? this.evrakkayitdurumu,
      favori: favori ?? this.favori,
    );
  }
}
