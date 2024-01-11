// ignore_for_file: non_constant_identifier_names, unnecessary_this

class BatuModel2024 {
  final int id;
  final String size;
  final int? qty;
  final String? lot;
  final String? parcel;
  final String? caratPcs;
  final String? hargaCaratPcsParva;
  final String? hargaCaratPcsMetier;
  final String? created_at;
  final int? idStone;
  final String keyWord;
  final String? muParva;
  final String? muMetier;


  BatuModel2024({
    required this.id,
    required this.size,
    this.qty,
    this.lot,
    this.parcel,
    this.caratPcs,
    this.hargaCaratPcsParva,
    this.hargaCaratPcsMetier,
    this.idStone,
    this.created_at,
    required this.keyWord,
    this.muParva,
    this.muMetier,
  });

  factory BatuModel2024.fromJson(Map<String, dynamic> json) {
    return BatuModel2024(
      id: json["idStone"],
      size: json["size"] ?? 'null',
      qty: json["qty"] ?? 0,
      lot: json["lot"] ?? 'null',
      parcel: json["parcel"] ?? 'null',
      caratPcs: json["caratPcs"].toString(),
      hargaCaratPcsParva: json["hargaCaratPcsParva"].toString(),
      hargaCaratPcsMetier: json["hargaCaratPcsMetier"].toString(),
      idStone: json["idStone"],
      created_at: json["created_at"] ?? '',
      keyWord: json["keyWord"] ?? 'null',
      muParva: json["muParva"].toString(),
      muMetier: json["muMetier"].toString(),

    );
  }

  static List<BatuModel2024> fromJsonList(List list) {
    return list.map((item) => BatuModel2024.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.keyWord}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(BatuModel2024 model) {
    return this.id == model.id;
  }

  @override
  String toString() => keyWord;
  // String toString() => size;
  String toId() => id.toString();
}
