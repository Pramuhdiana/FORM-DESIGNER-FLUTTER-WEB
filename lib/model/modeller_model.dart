class ModellerModel {
  int? id;
  String? kodeDesign;
  String? jenisBatu;
  String? bulan;
  String? kodeBulan;
  int? noUrutBulan;
  String? kodeMarketing;
  String? status;
  String? tema;
  String? marketing;
  String? brand;
  String? designer;
  String? modeller;
  String? keterangan;
  String? createdAt;

  ModellerModel(
      {this.id,
      this.kodeDesign,
      this.jenisBatu,
      this.bulan,
      this.kodeBulan,
      this.noUrutBulan,
      this.kodeMarketing,
      this.status,
      this.tema,
      this.marketing,
      this.brand,
      this.designer,
      this.modeller,
      this.keterangan,
      this.createdAt});

  ModellerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodeDesign = json['kodeDesign'] ?? '';
    jenisBatu = json['jenisBatu'] ?? '';
    bulan = json['bulan'] ?? '';
    kodeBulan = json['kodeBulan'] ?? '';
    noUrutBulan = json['noUrutBulan'] ?? 0;
    kodeMarketing = json['kodeMarketing'] ?? '';
    status = json['status'] ?? '';
    tema = json['tema'] ?? '';
    marketing = json['marketing'] ?? '';
    brand = json['brand'] ?? '';
    designer = json['designer'] ?? '';
    modeller = json['modeller'] ?? '';
    keterangan = json['keterangan'] ?? '';
    createdAt = json['createdAt'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['kodeDesign'] = kodeDesign;
    data['jenisBatu'] = jenisBatu;
    data['bulan'] = bulan;
    data['kodeBulan'] = kodeBulan;
    data['noUrutBulan'] = noUrutBulan;
    data['kodeMarketing'] = kodeMarketing;
    data['status'] = status;
    data['tema'] = tema;
    data['marketing'] = marketing;
    data['brand'] = brand;
    data['designer'] = designer;
    data['modeller'] = modeller;
    data['keterangan'] = keterangan;
    data['createdAt'] = createdAt;
    return data;
  }
}
