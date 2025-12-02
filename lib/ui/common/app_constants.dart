enum ScreenType { insert, edit, browse }

enum ToastType { success, error, info, none }

enum RequestState { initial, loading, success, error }

extension RequestStateExtension on RequestState {
  bool get isLoading => this == RequestState.loading;
  bool get isSuccess => this == RequestState.success;
  bool get isError => this == RequestState.error;
  bool get isInitial => this == RequestState.initial;
}

enum EnumYetkiTurleri { tam, listele, ekle, degistir, incele, cikar }

enum EnumRaporModulleri {
  malzemeHizmet(2),
  satinAlma(3),
  satis(4),
  cari(5),
  kasa(6),
  cekSenet(7),
  muhasebe(8),
  uretim(9),
  ozelRapor1(10),
  banka(11),
  ozelRapor2(12),
  patron1(13),
  patron2(14),
  patron3(15),
  mobilTesis(100),
  mobilMagaza(200);

  final int value;

  const EnumRaporModulleri(this.value);
}

enum enumRaporModulleri {
  Malzeme_Hizmet(2),
  Satinalma(3),
  Satis(4),
  Cari(5),
  Kasa(6),
  Cek_Senet(7),
  Muhasebe(8),
  uretim(9),
  Ozel_Rapor1(10),
  Banka(11),
  Ozel_Rapor2(12),
  Patron1(13),
  Patron2(14),
  Patron3(15),
  Mobil_Tesis(100),
  Mobil_Magaza(200);

  const enumRaporModulleri(this.value);
  final int value;
}

enum enumRaporTurleri {
  View(1),
  Prepared_FuncSP(2),
  Scalar_Function(3),
  Stored_Procedure(4);

  const enumRaporTurleri(this.value);
  final int value;
}

enum enumRaporSekli {
  Line(1),
  Pie(2),
  Bar(3),
  Pivot(4),
  List(5);

  const enumRaporSekli(this.value);
  final int value;
}

enum enumKarsilastirmaTipi {
  Esittir(100),
  Esit_Degildir(101),
  //Arasinda(102),
  Buyuktur(103),
  KuCuktur(104),
  Buyuk_Esittir(105),
  KuCuk_Esittir(106),
  ICerir(107),
  ICermez(108),
  ICinde(109),
  Disinda(110),
  Baslar(111),
  Baslamaz(112);

  const enumKarsilastirmaTipi(this.value);
  final int value;
}

extension enumKarsilastirmaTipiExtension on enumKarsilastirmaTipi {
  String? get name {
    switch (this) {
      case enumKarsilastirmaTipi.Esittir:
        return "Eşittir";
      case enumKarsilastirmaTipi.Esit_Degildir:
        return "Eşit Değildir";
      case enumKarsilastirmaTipi.Buyuktur:
        return "Büyüktür";
      case enumKarsilastirmaTipi.KuCuktur:
        return "Küçüktür";
      case enumKarsilastirmaTipi.Buyuk_Esittir:
        return "Büyük Eşittir";
      case enumKarsilastirmaTipi.KuCuk_Esittir:
        return "Küçük Eşittir";
      case enumKarsilastirmaTipi.ICerir:
        return "İçerir";
      case enumKarsilastirmaTipi.ICermez:
        return "İçermez";
      case enumKarsilastirmaTipi.ICinde:
        return "İçinde";
      case enumKarsilastirmaTipi.Disinda:
        return "Dışında";
      case enumKarsilastirmaTipi.Baslar:
        return "Başlar";
      case enumKarsilastirmaTipi.Baslamaz:
        return "Başlamaz";
    }
  }
}

enum enumNesneTipi {
  Combobox(1),
  ButtonEdit(3),
  LookupEdit(4),
  DateEdit(5),
  SpinEdit(6),
  TextEdit(8),
  GridLookUpEdit(9),
  CheckedCombobox(10);

  const enumNesneTipi(this.value);
  final int value;
}

enum enumVeriTipi {
  String(1),
  Integer(2),
  Float(3),
  DateTime(4);

  const enumVeriTipi(this.value);
  final int value;
}

enum enumKullanimYeri {
  Sabit(1),
  Sorgu_ICi(2),
  Sorgu_Disi(3),
  Siralama(4),
  DinamikAlan(5);

  const enumKullanimYeri(this.value);
  final int value;
}

enum enumKaynakTipi {
  Serbest_Veri(1),
  Fabrika_Listesi(10),
  Isyeri_Listesi(11),
  BOlum_Listesi(12),
  Ambar_Listesi(13),
  Kullanici_Grup_Listesi(14),
  Kullanici_Listesi(15),
  Yetki_Kodlari(16),
  Malzeme_Kart_Kodu(100),
  Malzeme_Ozel_Kodlari(101),
  Malzeme_Grup_Kodu(102),
  Hizmet_Kart_Kodu(110),
  Hizmet_Ozel_Kodu(111),
  Cari_Kart_Kodu(200),
  Cari_Ozel_Kodlari(201),
  Satis_Eleman_Kodu(202),
  Banka_Kodu(203),
  Banka_Hesap_Kodu(204),
  Kasa_Kodu(205),
  Muhasebe_Hesap_Kodu(300),
  Proje_Kart_Kodu(301),
  Stored_Procedure(4);

  const enumKaynakTipi(this.value);
  final int value;
}

enum ListTypes { SELECTION, VIEW }
