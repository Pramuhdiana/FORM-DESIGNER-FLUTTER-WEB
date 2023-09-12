// ignore_for_file: non_constant_identifier_user_ids, non_constant_identifier_names

import 'dart:convert';

List<SiklusModel> allcrm(String str) => List<SiklusModel>.from(
    json.decode(str).map((x) => SiklusModel.fromJson(x)));

String allcrmToJson(List<SiklusModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
initState() {}

class SiklusModel {
  int? id;
  String? siklus;

  SiklusModel({
    this.id,
    this.siklus,
  });

  // ignore: avoid_types_as_parameter_names
  factory SiklusModel.fromJson(Map<String, dynamic> json) => SiklusModel(
        id: json["id"],
        siklus: json["siklus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "siklus": siklus,
      };
}
