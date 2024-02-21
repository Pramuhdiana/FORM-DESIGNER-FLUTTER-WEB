// ignore_for_file: file_names

class JenisBatuModel {
  int? idJenisBatu;
  String? jenisBatu;
  String? kodeBatu;

  JenisBatuModel({this.idJenisBatu, this.jenisBatu, this.kodeBatu});

  JenisBatuModel.fromJson(Map<String, dynamic> json) {
    idJenisBatu = json['idJenisBatu'];
    jenisBatu = json['jenisBatu'];
    kodeBatu = json['kodeBatu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idJenisBatu'] = idJenisBatu;
    data['jenisBatu'] = jenisBatu;
    data['kodeBatu'] = kodeBatu;
    return data;
  }
}
