// ignore_for_file: file_names

class ItemQcModel {
  final int id;
  String? noPr;
  String? noQc;
  final String? item;
  final String? kodeMdbc;
  final String? qty;
  final String? berat;
  final String? panjang;
  final String? lebar;
  final String? jenisBatu;
  final String? kualitasBatu;
  final String? ukuranBatu;
  final String? caratPcs;

  ItemQcModel({
    required this.id,
    required this.item,
    this.kodeMdbc,
    this.noPr,
    this.noQc,
    this.qty,
    this.berat,
    this.panjang,
    this.lebar,
    this.jenisBatu,
    this.kualitasBatu,
    this.ukuranBatu,
    this.caratPcs,
  });

  factory ItemQcModel.fromJson(Map<String, dynamic> json) {
    return ItemQcModel(
      id: json["id"],
      item: json["item"] ?? '',
      kodeMdbc: json["kodeMdbc"] ?? '',
      noPr: json["noPr"] ?? '',
      noQc: json["noQc"] ?? '',
      qty: json["qty"].toString(),
      berat: json["berat"].toString(),
      panjang: json["panjang"].toString(),
      lebar: json["lebar"].toString(),
      jenisBatu: json["jenisBatu"].toString(),
      kualitasBatu: (json["kualitasBatu"] ?? '').toString(),
      ukuranBatu: (json["ukuranBatu"] ?? '').toString(),
      caratPcs: json["caratPcs"].toString(),
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item'] = item;
    data['kodeMdbc'] = kodeMdbc;
    data['noPr'] = noPr;
    data['noQc'] = noQc;
    data['qty'] = qty;
    data['berat'] = berat;
    data['panjang'] = panjang;
    data['lebar'] = lebar;
    data['jenisBatu'] = jenisBatu;
    data['kualitasBatu'] = kualitasBatu;
    data['ukuranBatu'] = ukuranBatu;
    data['caratPcs'] = caratPcs;
    return data;
  }
}
