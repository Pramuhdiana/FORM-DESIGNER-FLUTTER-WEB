// ignore_for_file: non_constant_identifier_names, unnecessary_this

class EarnutModel {
  final int id;
  final String nama;
  final int? qty;

  EarnutModel({
    required this.id,
    required this.nama,
    this.qty,
  });

  factory EarnutModel.fromJson(Map<String, dynamic> json) {
    return EarnutModel(
      id: json["id"],
      nama: json["nama"] ?? 'null',
      qty: json["qty"] ?? 0,
    );
  }

  static List<EarnutModel> fromJsonList(List list) {
    return list.map((item) => EarnutModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.nama}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(EarnutModel model) {
    return this.id == model.id;
  }

  @override
  String toString() => nama;
  String toId() => id.toString();
}
