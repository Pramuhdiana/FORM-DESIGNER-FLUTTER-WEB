// ignore_for_file: non_constant_identifier_names, unnecessary_this

class BatuModel {
  final int id;
  final String size;
  final int? qty;
  final String? lot;
  final String? parcel;
  final String? caratPcs;
  final String? ukuran;
  final String? keterangan;
  final String? updated_at;
  final int? idStone;
  final String keyWord;

  BatuModel({
    required this.id,
    required this.size,
    this.qty,
    this.lot,
    this.parcel,
    this.caratPcs,
    this.ukuran,
    this.keterangan,
    this.updated_at,
    this.idStone,
    required this.keyWord,
  });

  factory BatuModel.fromJson(Map<String, dynamic> json) {
    return BatuModel(
      id: json["id"],
      size: json["size"] ?? 'null',
      qty: json["qty"] ?? 0,
      lot: json["lot"] ?? 'null',
      parcel: json["parcel"] ?? 'null',
      caratPcs: json["caratPcs"].toString(),
      ukuran: json["ukuran"].toString(),
      keterangan: json["keterangan"] ?? '',
      updated_at: json["updated_at"] ?? '',
      idStone: json["idStone"] ?? 0,
      keyWord: json["keyWord"] ?? 'null',
    );
  }

  static List<BatuModel> fromJsonList(List list) {
    return list.map((item) => BatuModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.keyWord}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(BatuModel model) {
    return this.id == model.id;
  }

  @override
  String toString() => keyWord;
  // String toString() => size;
  String toId() => id.toString();
}
