class NrNameEnum {
  NrNameEnum({this.nr, this.name});

  int? nr;
  String? name;

  factory NrNameEnum.fromJson(Map<String, dynamic> json) {
    return NrNameEnum(nr: json["nr"], name: json["name"]);
  }
  Map<String, dynamic> toJson() {
    return {"nr": nr, "name": name};
  }
}
