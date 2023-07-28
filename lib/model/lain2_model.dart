// ignore_for_file: non_constant_identifier_names, unnecessary_this

class Lain2Model {
  final int id;
  final String nama;
  final int? qty;

  Lain2Model({
    required this.id,
    required this.nama,
    this.qty,
  });

  factory Lain2Model.fromJson(Map<String, dynamic> json) {
    return Lain2Model(
      id: json["id"],
      nama: json["nama"] ?? 'null',
      qty: json["qty"] ?? 0,
    );
  }

  static List<Lain2Model> fromJsonList(List list) {
    return list.map((item) => Lain2Model.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.nama}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(Lain2Model model) {
    return this.id == model.id;
  }

  @override
  String toString() => nama;
  String toId() => id.toString();
}
