// ignore_for_file: non_constant_identifier_names, unnecessary_this

class ListItemModel {
  final int id;
  String? noPr;
  final String item;
  final String? qty;
  final String? berat;
  final String? kadar;
  final String? color;
  final String? created_at;

  ListItemModel({
    required this.id,
    required this.item,
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
      item: json["item"] ?? 'null',
      noPr: json["noPr"] ?? '',
      qty: json["qty"] ?? 0,
      berat: json["berat"].toString(),
      kadar: json["kadar"] ?? 0,
      color: json["color"] ?? 0,
      created_at: json["created_at"] ?? 0,
    );
  }

  static List<ListItemModel> fromJsonList(List list) {
    return list.map((item) => ListItemModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.item}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(ListItemModel model) {
    return this.id == model.id;
  }

  @override
  String toString() => item;
  String toId() => id.toString();
}
