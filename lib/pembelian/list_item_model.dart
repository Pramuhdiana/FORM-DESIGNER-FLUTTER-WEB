// ignore_for_file: non_constant_identifier_names, unnecessary_this

class ListItemModel {
  final int id;
  String? noPr;
  final String nama;
  final String? qty;
  final String? berat;
  final String? kadar;
  final String? color;
  final String? created_at;

  ListItemModel({
    required this.id,
    required this.nama,
    this.noPr,
    this.qty,
    this.berat,
    this.kadar,
    this.color,
    this.created_at,
  });

  factory ListItemModel.fromJson(Map<String, dynamic> json) {
    return ListItemModel(
      id: json["id"],
      nama: json["nama"] ?? '',
      noPr: json["noPr"] ?? '',
      qty: json["qty"].toString(),
      berat: json["berat"].toString(),
      kadar: json["kadar"].toString(),
      color: json["color"].toString(),
      created_at: json["created_at"].toString(),
    );
  }

  static List<ListItemModel> fromJsonList(List list) {
    return list.map((item) => ListItemModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.nama}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(ListItemModel model) {
    return this.id == model.id;
  }

  @override
  String toString() => nama;
  String toId() => id.toString();
}
