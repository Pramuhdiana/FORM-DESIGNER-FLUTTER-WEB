// ignore_for_file: file_names

class LebarModel {
  int? idLebar;
  String? lebar;
  String? resultLebar;

  LebarModel({this.idLebar, this.lebar, this.resultLebar});

  LebarModel.fromJson(Map<String, dynamic> json) {
    idLebar = json['idLebar'];
    lebar = json['lebar'].toString();
    resultLebar = json['resultLebar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idLebar'] = idLebar;
    data['lebar'] = lebar;
    data['resultLebar'] = resultLebar;
    return data;
  }
}
