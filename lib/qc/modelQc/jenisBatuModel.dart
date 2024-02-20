// ignore_for_file: file_names

class JenisBatuModel {
  int? idJenisBatu;
  String? jenisBatu;

  JenisBatuModel({this.idJenisBatu, this.jenisBatu});

  JenisBatuModel.fromJson(Map<String, dynamic> json) {
    idJenisBatu = json['idJenisBatu'];
    jenisBatu = json['jenisBatu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idJenisBatu'] = idJenisBatu;
    data['jenisBatu'] = jenisBatu;
    return data;
  }
}
