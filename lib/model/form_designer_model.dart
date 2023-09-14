// ignore_for_file: non_constant_identifier_user_ids, non_constant_identifier_names

import 'dart:convert';

List<FormDesignerModel> allcrm(String str) => List<FormDesignerModel>.from(
    json.decode(str).map((x) => FormDesignerModel.fromJson(x)));

String allcrmToJson(List<FormDesignerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
initState() {}

class FormDesignerModel {
  int? id;
  String? kodeDesignMdbc;
  String? kodeMarketing;
  String? kodeProduksi;
  String? namaDesigner;
  String? namaModeller;
  String? kodeDesign;
  String? siklus;
  String? tema;
  String? rantai;
  int? qtyRantai;
  String? lain2;
  int? qtyLain2;
  String? earnut;
  int? qtyEarnut;
  String? panjangRantai;
  String? customKomponen;
  int? qtyCustomKomponen;
  String? jenisBarang;
  String? kategoriBarang;
  String? brand;
  String? photoShoot;
  String? color;
  double? beratEmas;
  int? estimasiHarga;
  String? ringSize;
  String? created_at;
  String? batu1;
  int? qtyBatu1;
  String? batu2;
  int? qtyBatu2;
  String? batu3;
  int? qtyBatu3;
  String? batu4;
  int? qtyBatu4;
  String? batu5;
  int? qtyBatu5;
  String? batu6;
  int? qtyBatu6;
  String? batu7;
  int? qtyBatu7;
  String? batu8;
  int? qtyBatu8;
  String? batu9;
  int? qtyBatu9;
  String? batu10;
  int? qtyBatu10;
  String? batu11;
  int? qtyBatu11;
  String? batu12;
  int? qtyBatu12;
  String? batu13;
  int? qtyBatu13;
  String? batu14;
  int? qtyBatu14;
  String? batu15;
  int? qtyBatu15;
  String? batu16;
  int? qtyBatu16;
  String? batu17;
  int? qtyBatu17;
  String? batu18;
  int? qtyBatu18;
  String? batu19;
  int? qtyBatu19;
  String? batu20;
  int? qtyBatu20;
  String? batu21;
  int? qtyBatu21;
  String? batu22;
  int? qtyBatu22;
  String? batu23;
  int? qtyBatu23;
  String? batu24;
  int? qtyBatu24;
  String? batu25;
  int? qtyBatu25;
  String? batu26;
  int? qtyBatu26;
  String? batu27;
  int? qtyBatu27;
  String? batu28;
  int? qtyBatu28;
  String? batu29;
  int? qtyBatu29;
  String? batu30;
  int? qtyBatu30;
  String? batu31;
  int? qtyBatu31;
  String? batu32;
  int? qtyBatu32;
  String? batu33;
  int? qtyBatu33;
  String? batu34;
  int? qtyBatu34;
  String? batu35;
  int? qtyBatu35;
  String? imageUrl;
  int? edit;
  String? keteranganStatusBatu;
  String? pointModeller;

  FormDesignerModel({
    this.id,
    this.kodeDesignMdbc,
    this.kodeMarketing,
    this.kodeProduksi,
    this.namaDesigner,
    this.namaModeller,
    this.kodeDesign,
    this.siklus,
    this.tema,
    this.rantai,
    this.qtyRantai,
    this.lain2,
    this.qtyLain2,
    this.earnut,
    this.qtyEarnut,
    this.panjangRantai,
    this.customKomponen,
    this.qtyCustomKomponen,
    this.jenisBarang,
    this.kategoriBarang,
    this.brand,
    this.photoShoot,
    this.color,
    this.beratEmas,
    this.estimasiHarga,
    this.ringSize,
    this.created_at,
    this.batu1,
    this.qtyBatu1,
    this.batu2,
    this.qtyBatu2,
    this.batu3,
    this.qtyBatu3,
    this.batu4,
    this.qtyBatu4,
    this.batu5,
    this.qtyBatu5,
    this.batu6,
    this.qtyBatu6,
    this.batu7,
    this.qtyBatu7,
    this.batu8,
    this.qtyBatu8,
    this.batu9,
    this.qtyBatu9,
    this.batu10,
    this.qtyBatu10,
    this.batu11,
    this.qtyBatu11,
    this.batu12,
    this.qtyBatu12,
    this.batu13,
    this.qtyBatu13,
    this.batu14,
    this.qtyBatu14,
    this.batu15,
    this.qtyBatu15,
    this.batu16,
    this.qtyBatu16,
    this.batu17,
    this.qtyBatu17,
    this.batu18,
    this.qtyBatu18,
    this.batu19,
    this.qtyBatu19,
    this.batu20,
    this.qtyBatu20,
    this.batu21,
    this.qtyBatu21,
    this.batu22,
    this.qtyBatu22,
    this.batu23,
    this.qtyBatu23,
    this.batu24,
    this.qtyBatu24,
    this.batu25,
    this.qtyBatu25,
    this.batu26,
    this.qtyBatu26,
    this.batu27,
    this.qtyBatu27,
    this.batu28,
    this.qtyBatu28,
    this.batu29,
    this.qtyBatu29,
    this.batu30,
    this.qtyBatu30,
    this.batu31,
    this.qtyBatu31,
    this.batu32,
    this.qtyBatu32,
    this.batu33,
    this.qtyBatu33,
    this.batu34,
    this.qtyBatu34,
    this.batu35,
    this.qtyBatu35,
    this.imageUrl,
    this.edit,
    this.keteranganStatusBatu,
    this.pointModeller,
  });

  // ignore: avoid_types_as_parameter_names
  factory FormDesignerModel.fromJson(Map<String, dynamic> json) =>
      FormDesignerModel(
        id: json["id"] ?? 0,
        kodeDesignMdbc: json["kodeDesignMdbc"],
        kodeMarketing: json["kodeMarketing"],
        kodeProduksi: json["kodeProduksi"],
        namaDesigner: json["namaDesigner"],
        namaModeller: json["namaModeller"],
        kodeDesign: json["kodeDesign"],
        siklus: json["siklus"],
        tema: json["tema"],
        rantai: json["rantai"],
        qtyRantai: json["qtyRantai"],
        lain2: json["lain2"],
        qtyLain2: json["qtyLain2"],
        earnut: json["earnut"],
        qtyEarnut: json["qtyEarnut"],
        panjangRantai: json["panjangRantai"],
        customKomponen: json["customKomponen"],
        qtyCustomKomponen: json["qtyCustomKomponen"],
        jenisBarang: json["jenisBarang"],
        kategoriBarang: json["kategoriBarang"],
        brand: json["brand"],
        photoShoot: json["photoShoot"],
        color: json["color"],
        beratEmas: json["beratEmas"],
        estimasiHarga: json["estimasiHarga"],
        ringSize: json["ringSize"],
        created_at: json["created_at"],
        batu1: json["batu1"],
        qtyBatu1: json["qtyBatu1"],
        batu2: json["batu2"],
        qtyBatu2: json["qtyBatu2"],
        batu3: json["batu3"],
        qtyBatu3: json["qtyBatu3"],
        batu4: json["batu4"],
        qtyBatu4: json["qtyBatu4"],
        batu5: json["batu5"],
        qtyBatu5: json["qtyBatu5"],
        batu6: json["batu6"],
        qtyBatu6: json["qtyBatu6"],
        batu7: json["batu7"],
        qtyBatu7: json["qtyBatu7"],
        batu8: json["batu8"],
        qtyBatu8: json["qtyBatu8"],
        batu9: json["batu9"],
        qtyBatu9: json["qtyBatu9"],
        batu10: json["batu10"],
        qtyBatu10: json["qtyBatu10"],
        batu11: json["batu11"],
        qtyBatu11: json["qtyBatu11"],
        batu12: json["batu12"],
        qtyBatu12: json["qtyBatu12"],
        batu13: json["batu13"],
        qtyBatu13: json["qtyBatu13"],
        batu14: json["batu14"],
        qtyBatu14: json["qtyBatu14"],
        batu15: json["batu15"],
        qtyBatu15: json["qtyBatu15"],
        batu16: json["batu16"],
        qtyBatu16: json["qtyBatu16"],
        batu17: json["batu17"],
        qtyBatu17: json["qtyBatu17"],
        batu18: json["batu18"],
        qtyBatu18: json["qtyBatu18"],
        batu19: json["batu19"],
        qtyBatu19: json["qtyBatu19"],
        batu20: json["batu20"],
        qtyBatu20: json["qtyBatu20"],
        batu21: json["batu21"],
        qtyBatu21: json["qtyBatu21"],
        batu22: json["batu22"],
        qtyBatu22: json["qtyBatu22"],
        batu23: json["batu23"],
        qtyBatu23: json["qtyBatu23"],
        batu24: json["batu24"],
        qtyBatu24: json["qtyBatu24"],
        batu25: json["batu25"],
        qtyBatu25: json["qtyBatu25"],
        batu26: json["batu26"],
        qtyBatu26: json["qtyBatu26"],
        batu27: json["batu27"],
        qtyBatu27: json["qtyBatu27"],
        batu28: json["batu28"],
        qtyBatu28: json["qtyBatu28"],
        batu29: json["batu29"],
        qtyBatu29: json["qtyBatu29"],
        batu30: json["batu30"],
        qtyBatu30: json["qtyBatu30"],
        batu31: json["batu31"],
        qtyBatu31: json["qtyBatu31"],
        batu32: json["batu32"],
        qtyBatu32: json["qtyBatu32"],
        batu33: json["batu33"],
        qtyBatu33: json["qtyBatu33"],
        batu34: json["batu34"],
        qtyBatu34: json["qtyBatu34"],
        batu35: json["batu35"],
        qtyBatu35: json["qtyBatu35"],
        imageUrl: json["imageUrl"],
        edit: json["edit"],
        keteranganStatusBatu: json["keteranganStatusBatu"] ?? '',
        pointModeller: json["pointModeller"] ?? '0',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kodeDesignMdbc": kodeDesignMdbc,
        "kodeMarketing": kodeMarketing,
        "kodeProduksi": kodeProduksi,
        "namaDesigner": namaDesigner,
        "namaModeller": namaModeller,
        "kodeDesign": kodeDesign,
        "siklus": siklus,
        "tema": tema,
        "rantai": rantai,
        "qtyRantai": qtyRantai,
        "lain2": lain2,
        "qtyLain2": qtyLain2,
        "earnut": earnut,
        "qtyEarnut": qtyEarnut,
        "panjangRantai": panjangRantai,
        "customKomponen": customKomponen,
        "qtyCustomKomponen": qtyCustomKomponen,
        "jenisBarang": jenisBarang,
        "kategoriBarang": kategoriBarang,
        "brand": brand,
        "photoShoot": photoShoot,
        "color": color,
        "beratEmas": beratEmas,
        "estimasiHarga": estimasiHarga,
        "ringSize": ringSize,
        "created_at": created_at,
        "batu1": batu1,
        "qtyBatu1": qtyBatu1,
        "batu2": batu2,
        "qtyBatu2": qtyBatu2,
        "batu3": batu3,
        "qtyBatu3": qtyBatu3,
        "batu4": batu4,
        "qtyBatu4": qtyBatu4,
        "batu5": batu5,
        "qtyBatu5": qtyBatu5,
        "batu6": batu6,
        "qtyBatu6": qtyBatu6,
        "batu7": batu7,
        "qtyBatu7": qtyBatu7,
        "batu8": batu8,
        "qtyBatu8": qtyBatu8,
        "batu9": batu9,
        "qtyBatu9": qtyBatu9,
        "batu10": batu10,
        "qtyBatu10": qtyBatu10,
        "batu11": batu11,
        "qtyBatu11": qtyBatu11,
        "batu12": batu12,
        "qtyBatu12": qtyBatu12,
        "batu13": batu13,
        "qtyBatu13": qtyBatu13,
        "batu14": batu14,
        "qtyBatu14": qtyBatu14,
        "batu15": batu15,
        "qtyBatu15": qtyBatu15,
        "batu16": batu16,
        "qtyBatu16": qtyBatu16,
        "batu17": batu17,
        "qtyBatu17": qtyBatu17,
        "batu18": batu18,
        "qtyBatu18": qtyBatu18,
        "batu19": batu19,
        "qtyBatu19": qtyBatu19,
        "batu20": batu20,
        "qtyBatu20": qtyBatu20,
        "batu21": batu21,
        "qtyBatu21": qtyBatu21,
        "batu22": batu22,
        "qtyBatu22": qtyBatu22,
        "batu23": batu23,
        "qtyBatu23": qtyBatu23,
        "batu24": batu24,
        "qtyBatu24": qtyBatu24,
        "batu25": batu25,
        "qtyBatu25": qtyBatu25,
        "batu26": batu26,
        "qtyBatu26": qtyBatu26,
        "batu27": batu27,
        "qtyBatu27": qtyBatu27,
        "batu28": batu28,
        "qtyBatu28": qtyBatu28,
        "batu29": batu29,
        "qtyBatu29": qtyBatu29,
        "batu30": batu30,
        "qtyBatu30": qtyBatu30,
        "batu31": batu31,
        "qtyBatu31": qtyBatu31,
        "batu32": batu32,
        "qtyBatu32": qtyBatu32,
        "batu33": batu33,
        "qtyBatu33": qtyBatu33,
        "batu34": batu34,
        "qtyBatu34": qtyBatu34,
        "batu35": batu35,
        "qtyBatu35": qtyBatu35,
        "imageUrl": imageUrl,
        "edit": edit,
        "keteranganStatusBatu": keteranganStatusBatu,
        "pointModeller": pointModeller,
      };
}
