// ignore_for_file: non_constant_identifier_user_ids, non_constant_identifier_names

import 'dart:convert';

List<FormPrModel> allcrm(String str) => List<FormPrModel>.from(
    json.decode(str).map((x) => FormPrModel.fromJson(x)));

String allcrmToJson(List<FormPrModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
initState() {}

class FormPrModel {
  int? id;
  String? noPr;
  String? vendor;
  String? notes;
  String? created_at;
  String? totalItem;
  String? totalQty;
  String? totalBerat;
  String? status;
  String? tanggalKirim;
  String? jenisForm;
  String? jenisItem;
  String? jenisBatu;
  String? fixTotalQty;
  String? fixTotalBerat;
  String? noQc;
  String? tanggalInQc;
  String? tanggalSelesai;
  String? totalBeratDiterima;
  String? totalQtyDiterima;
  String? lokasi;
  String? tanggalCetak;
  String? kurir;

  FormPrModel({
    this.id,
    this.noPr,
    this.vendor,
    this.notes,
    this.created_at,
    this.totalItem,
    this.totalQty,
    this.totalBerat,
    this.status,
    this.tanggalKirim,
    this.jenisForm,
    this.jenisItem,
    this.jenisBatu,
    this.fixTotalQty,
    this.fixTotalBerat,
    this.noQc,
    this.tanggalInQc,
    this.tanggalSelesai,
    this.totalBeratDiterima,
    this.totalQtyDiterima,
    this.lokasi,
    this.tanggalCetak,
    this.kurir,
  });

  // ignore: avoid_types_as_parameter_names
  factory FormPrModel.fromJson(Map<String, dynamic> json) => FormPrModel(
        id: json["id"],
        noPr: json["noPr"] ?? '',
        vendor: json["vendor"] ?? '',
        notes: json["notes"] ?? '',
        created_at: json["created_at"].toString(),
        totalItem: json["total_item"].toString(),
        totalQty: json["total_qty"].toString(),
        totalBerat: json["total_berat"].toString(),
        status: json["status"].toString(),
        tanggalKirim: json["tanggal_kirim"].toString(),
        jenisForm: json["jenis_form"].toString(),
        jenisItem: json["jenis_item"].toString(),
        jenisBatu: json["jenis_batu"].toString(),
        fixTotalQty: json["fix_total_qty"].toString(),
        fixTotalBerat: json["fix_total_berat"].toString(),
        noQc: json["noQc"].toString(),
        tanggalInQc: json["tanggal_in_qc"].toString(),
        tanggalSelesai: json["tanggal_selesai"].toString(),
        totalBeratDiterima: json["total_berat_diterima"].toString(),
        totalQtyDiterima: json["total_qty_diterima"].toString(),
        lokasi: json["lokasi"] ?? '',
        tanggalCetak: json["tanggal_cetak"] ?? '',
        kurir: json["kurir"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "noPr": noPr,
        "vendor": vendor,
        "notes": notes,
        "created_at": created_at,
        "total_item": totalItem,
        "total_qty": totalQty,
        "total_berat": totalBerat,
        "total_berstatusat": status,
        "tanggal_kirim": tanggalKirim,
        "jenis_form": jenisForm,
        "jenis_item": jenisItem,
        "jenis_batu": jenisBatu,
        "fix_total_qty": fixTotalQty,
        "fix_total_berat": fixTotalBerat,
        "noQc": noQc,
        "tanggal_in_qc": tanggalInQc,
        "tanggal_selesai": tanggalSelesai,
        "total_berat_diterima": totalBeratDiterima,
        "lokasi": lokasi,
        "kurir": kurir,
      };
}
