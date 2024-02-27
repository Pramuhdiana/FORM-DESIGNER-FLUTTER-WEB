// ignore_for_file: non_constant_identifier_names, unnecessary_this

class ListItemPRModel {
  final int id;
  String? noPr;
  final String? item;
  final String? qty;
  final String? berat;
  final String? kadar;
  final String? color;
  final String? created_at;
  final String? fixQty;
  final String? fixBerat;
  final String? receiveBerat;
  final String? noQc;
  final String? updateAt;
  final String? notesReject;

  ListItemPRModel({
    required this.id,
    required this.item,
    this.noPr,
    this.qty,
    this.berat,
    this.kadar,
    this.color,
    this.created_at,
    this.fixQty,
    this.fixBerat,
    this.receiveBerat,
    this.noQc,
    this.updateAt,
    this.notesReject,
  });

  factory ListItemPRModel.fromJson(Map<String, dynamic> json) {
    return ListItemPRModel(
      id: json["id"],
      item: json["item"] ?? '',
      noPr: json["noPr"] ?? '',
      qty: json["qty"].toString(),
      berat: json["berat"].toString(),
      kadar: json["kadar"].toString(),
      color: json["color"].toString(),
      created_at: json["created_at"].toString(),
      fixQty: (json["fixQty"] ?? '0').toString(),
      fixBerat: (json["fixBerat"] ?? '0').toString(),
      receiveBerat: (json["receiveBerat"] ?? '0').toString(),
      noQc: json["noQc"] ?? '',
      updateAt: json["updated_at"] ?? '',
      notesReject: json["notesReject"] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item'] = item;
    data['noPr'] = noPr;
    data['qty'] = qty;
    data['berat'] = berat;
    data['kadar'] = kadar;
    data['color'] = color;
    data['created_at'] = created_at;
    data['fixQty'] = fixQty;
    data['fixBerat'] = fixBerat;
    data['receiveBerat'] = receiveBerat;
    data['noQc'] = noQc;
    data['updated_at'] = updateAt;
    data['notesReject'] = notesReject;
    return data;
  }
}
