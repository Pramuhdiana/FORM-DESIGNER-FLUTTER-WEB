// ignore_for_file: non_constant_identifier_names, unnecessary_this

class JenisbarangModel {
  final int id;
  final String nama;
  final int? qty;
  final int? harga;
  final String? kodeBarang;

  JenisbarangModel({
    required this.id,
    required this.nama,
    this.qty,
    this.harga,
    this.kodeBarang,
  });

  factory JenisbarangModel.fromJson(Map<String, dynamic> json) {
    return JenisbarangModel(
      id: json["id"],
      nama: json["nama"] ?? 'null',
      qty: json["qty"] ?? 0,
      harga: json["harga"] ?? 0,
      kodeBarang: json["kode_barang"],
    );
  }

  static List<JenisbarangModel> fromJsonList(List list) {
    return list.map((item) => JenisbarangModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.nama}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(JenisbarangModel model) {
    return this.id == model.id;
  }

  @override
  String toString() => nama;
  String toId() => id.toString();
}
