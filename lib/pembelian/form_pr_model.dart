// ignore_for_file: non_constant_identifier_user_ids, non_constant_identifier_names

import 'dart:convert';

List<FormPrModel> allcrm(String str) => List<FormPrModel>.from(
    json.decode(str).map((x) => FormPrModel.fromJson(x)));

String allcrmToJson(List<FormPrModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
initState() {}

class FormPrModel {
  int? id;
  String? noPR;
  String? vendor;
  String? notes;
  String? created_at;
  String? totalItem;
  String? totalQty;
  String? totalBerat;

  FormPrModel({
    this.id,
    this.noPR,
    this.vendor,
    this.notes,
    this.created_at,
    this.totalItem,
    this.totalQty,
    this.totalBerat,
  });

  // ignore: avoid_types_as_parameter_names
  factory FormPrModel.fromJson(Map<String, dynamic> json) => FormPrModel(
        id: json["id"],
        noPR: json["noPr"] ?? '',
        vendor: json["vendor"] ?? '',
        notes: json["notes"] ?? '',
        created_at: json["created_at"],
        totalItem: json["total_item"].toString(),
        totalQty: json["total_qty"].toString(),
        totalBerat: json["total_berat"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "noPR": noPR,
        "vendor": vendor,
        "notes": notes,
        "created_at": created_at,
        "total_item": totalItem,
        "total_qty": totalQty,
        "total_berat": totalBerat,
      };
}
