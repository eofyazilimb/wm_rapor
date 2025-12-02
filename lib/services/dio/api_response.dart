class ApiResponse {
  bool? durum;
  int? durumkodu;
  String? mesaj; // uyarı /hata mesajı
  dynamic nesneler; // gelen veri
  int? count;
  dynamic hata;
  ApiResponse.fromJson(Map json) {
    durum = json["durum"];
    durumkodu = json["durumkodu"];
    mesaj = json["mesaj"];
    nesneler = json["nesneler"];
    count = json["count"];
    hata = json["hata"];
  }

  Map toJson() {
    return {
      "durum": durum,
      "durumkodu": durumkodu,
      "mesaj": mesaj,
      "nesneler": nesneler,
      "count": count,
      "hata": hata,
    };
  }

  ApiResponse.timeout();
}
