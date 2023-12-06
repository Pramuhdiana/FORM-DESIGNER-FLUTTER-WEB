// ignore_for_file: non_constant_identifier_names, unnecessary_this

class DivisiProduksiModel {
  final int id;
  final String? divisi;

  DivisiProduksiModel({
    required this.id,
    this.divisi,
  });

  factory DivisiProduksiModel.fromJson(Map<String, dynamic> json) {
    return DivisiProduksiModel(
      id: json["id"],
      divisi: json["divisi"] ?? '',
    );
  }

  static List<DivisiProduksiModel> fromJsonList(List list) {
    return list.map((item) => DivisiProduksiModel.fromJson(item)).toList();
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(DivisiProduksiModel model) {
    return this.id == model.id;
  }

}
