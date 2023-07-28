// ignore_for_file: non_constant_identifier_names, unnecessary_this

class RantaiModel {
  final int id;
  final String nama;
  final int? qty;

  RantaiModel({
    required this.id,
    required this.nama,
    this.qty,
  });

  factory RantaiModel.fromJson(Map<String, dynamic> json) {
    return RantaiModel(
      id: json["id"],
      nama: json["nama"] ?? 'null',
      qty: json["qty"] ?? 0,
    );
  }

  static List<RantaiModel> fromJsonList(List list) {
    return list.map((item) => RantaiModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.nama}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(RantaiModel model) {
    return this.id == model.id;
  }

  @override
  String toString() => nama;
  String toId() => id.toString();
}
