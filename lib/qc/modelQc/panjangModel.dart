// ignore_for_file: file_names

class PanjangModel {
  int? idPanjang;
  String? panjang;
  String? resultPanjang;

  PanjangModel({this.idPanjang, this.panjang, this.resultPanjang});

  PanjangModel.fromJson(Map<String, dynamic> json) {
    idPanjang = json['idPanjang'];
    panjang = json['panjang'].toString();
    resultPanjang = json['resultPanjang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idPanjang'] = idPanjang;
    data['panjang'] = panjang;
    data['resultPanjang'] = resultPanjang;
    return data;
  }
}
