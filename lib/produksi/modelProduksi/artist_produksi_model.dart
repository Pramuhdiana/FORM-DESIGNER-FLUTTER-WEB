// ignore_for_file: non_constant_identifier_names, unnecessary_this

class ArtistProduksiModel {
  final int id;
  final String nama;
  final String? divisi;

  ArtistProduksiModel({
    required this.id,
    required this.nama,
    this.divisi,
  });

  factory ArtistProduksiModel.fromJson(Map<String, dynamic> json) {
    return ArtistProduksiModel(
      id: json["id"],
      nama: json["nama"] ?? 'null',
      divisi: json["divisi"] ?? 'null',
    );
  }

  static List<ArtistProduksiModel> fromJsonList(List list) {
    return list.map((item) => ArtistProduksiModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.nama}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(ArtistProduksiModel model) {
    return this.id == model.id;
  }

  @override
  String toString() => nama;
  String toId() => id.toString();
}
