// ignore_for_file: non_constant_identifier_names, unnecessary_this

class ListKurir {
  final int id;
  final String nama;
  final String ttd;

  ListKurir({
    required this.id,
    required this.nama,
    required this.ttd,
  });

  factory ListKurir.fromJson(Map<String, dynamic> json) {
    return ListKurir(
      id: json["id"],
      nama: json["nama"] ?? '',
      ttd: json["ttd"] ?? '',
    );
  }

  static List<ListKurir> fromJsonList(List list) {
    return list.map((nama) => ListKurir.fromJson(nama)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.nama}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(ListKurir model) {
    return this.id == model.id;
  }

  @override
  String toString() => nama;
  String toId() => id.toString();
}
