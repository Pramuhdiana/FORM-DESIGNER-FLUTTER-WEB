// ignore_for_file: file_names

class BeratKodeModel {
  int? idBeratKode;
  String? beratKode;
  String? resultBeratKode;

  BeratKodeModel({this.idBeratKode, this.beratKode, this.resultBeratKode});

  BeratKodeModel.fromJson(Map<String, dynamic> json) {
    idBeratKode = json['idBeratKode'];
    beratKode = json['beratKode'].toString();
    resultBeratKode = json['resultBeratKode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idBeratKode'] = idBeratKode;
    data['beratKode'] = beratKode;
    data['resultBeratKode'] = resultBeratKode;
    return data;
  }
}
