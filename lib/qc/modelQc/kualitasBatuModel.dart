// ignore_for_file: file_names

class KualitasBatuModel {
  int? idKualitasBatu;
  String? kualitasBatu;

  KualitasBatuModel({this.idKualitasBatu, this.kualitasBatu});

  KualitasBatuModel.fromJson(Map<String, dynamic> json) {
    idKualitasBatu = json['idKualitasBatu'];
    kualitasBatu = json['kualitasBatu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idKualitasBatu'] = idKualitasBatu;
    data['kualitasBatu'] = kualitasBatu;
    return data;
  }
}
