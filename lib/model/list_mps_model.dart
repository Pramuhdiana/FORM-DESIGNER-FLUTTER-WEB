// ignore_for_file: non_constant_identifier_user_ids, non_constant_identifier_names

import 'dart:convert';

List<ListMpsModel> allcrm(String str) => List<ListMpsModel>.from(
    json.decode(str).map((x) => ListMpsModel.fromJson(x)));

String allcrmToJson(List<ListMpsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
initState() {}

class ListMpsModel {
  int? id;
  String? kodeDesignMdbc;
  String? kodeMarketing;
  String? posisi;
  String? tema;
  String? jenisBarang;
  String? brand;
  String? color;
  double? beratEmas;
  int? estimasiHarga;
  String? ringSize;
  String? statusForm;
  String? keteranganMinggu;
  String? keteranganBatu;
  String? keteranganStatusBatu;
  String? imageUrl;
  String? artist;
  String? keteranganStatusAcc;
  String? rantai;
  String? qtyRantai;
  String? lain2;
  String? qtyLain2;
  String? earnut;
  String? qtyEarnut;
  String? panjangRantai;
  String? customKomponen;
  String? qtyCustomKomponen;
  String? siklus;
  String? bulan;
  String? tanggalInProduksi;
  String? keteranganBackPosisi;
  String? statusBackPosisi;

  ListMpsModel({
    this.id,
    this.kodeDesignMdbc,
    this.kodeMarketing,
    this.posisi,
    this.tema,
    this.jenisBarang,
    this.brand,
    this.color,
    this.beratEmas,
    this.estimasiHarga,
    this.ringSize,
    this.statusForm,
    this.keteranganMinggu,
    this.keteranganBatu,
    this.keteranganStatusBatu,
    this.imageUrl,
    this.artist,
    this.keteranganStatusAcc,
    this.rantai,
    this.qtyRantai,
    this.lain2,
    this.qtyLain2,
    this.earnut,
    this.qtyEarnut,
    this.panjangRantai,
    this.customKomponen,
    this.qtyCustomKomponen,
    this.siklus,
    this.bulan,
    this.tanggalInProduksi,
    this.keteranganBackPosisi,
    this.statusBackPosisi,
  });

  ListMpsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodeDesignMdbc = json['kodeDesignMdbc'] ?? '';
    kodeMarketing = json['kodeMarketing'] ?? '';
    posisi = json['posisi'] ?? '';
    tema = json['tema'] ?? '';
    jenisBarang = json['jenisBarang'] ?? '';
    brand = json['brand'] ?? '';
    color = json['color'] ?? '';
    beratEmas = json['beratEmas'] ?? 0;
    estimasiHarga = json['estimasiHarga'] ?? 0;
    ringSize = json['ringSize'] ?? '';
    statusForm = json['statusForm'] ?? '';
    keteranganMinggu = json['keteranganMinggu'] ?? '';
    keteranganBatu = json['keteranganBatu'] ?? '';
    keteranganStatusBatu = json['keteranganStatusBatu'] ?? '';
    imageUrl = json['imageUrl'] ?? 'default.jpg';
    artist = json['artist'] ?? '';
    keteranganStatusAcc = json['keteranganStatusAcc'] ?? '';
    rantai = json['rantai'] ?? '';
    qtyRantai = json['qtyRantai'] ?? '';
    lain2 = json['lain2'] ?? '';
    qtyLain2 = json['qtyLain2'] ?? '';
    earnut = json['earnut'] ?? '';
    qtyEarnut = json['qtyEarnut'] ?? '';
    panjangRantai = json['panjangRantai'] ?? '';
    customKomponen = json['customKomponen'] ?? '';
    qtyCustomKomponen = json['qtyCustomKomponen'] ?? '';
    siklus = json['siklus'] ?? '';
    bulan = json['bulan'] ?? '';
    tanggalInProduksi = json['tanggalInProduksi'] ?? '';
    keteranganBackPosisi = json['keteranganBackPosisi'] ?? '';
    statusBackPosisi = json['statusBackPosisi'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['kodeDesignMdbc'] = kodeDesignMdbc;
    data['kodeMarketing'] = kodeMarketing;
    data['posisi'] = posisi;
    data['tema'] = tema;
    data['jenisBarang'] = jenisBarang;
    data['brand'] = brand;
    data['color'] = color;
    data['beratEmas'] = beratEmas;
    data['estimasiHarga'] = estimasiHarga;
    data['ringSize'] = ringSize;
    data['statusForm'] = statusForm;
    data['keteranganMinggu'] = keteranganMinggu;
    data['keteranganBatu'] = keteranganBatu;
    data['keteranganStatusBatu'] = keteranganStatusBatu;
    data['imageUrl'] = imageUrl;
    data['artist'] = artist;
    data['keteranganStatusAcc'] = keteranganStatusAcc;
    data['rantai'] = rantai;
    data['qtyRantai'] = qtyRantai;
    data['lain2'] = lain2;
    data['qtyLain2'] = qtyLain2;
    data['earnut'] = earnut;
    data['qtyEarnut'] = qtyEarnut;
    data['panjangRantai'] = panjangRantai;
    data['customKomponen'] = customKomponen;
    data['qtyCustomKomponen'] = qtyCustomKomponen;
    data['siklus'] = siklus;
    data['bulan'] = bulan;
    data['tanggalInProduksi'] = tanggalInProduksi;
    data['keteranganBackPosisi'] = keteranganBackPosisi;
    data['statusBackPosisi'] = statusBackPosisi;
    return data;
  }
}
