class ProduksiSBModel {
  int? id;
  String? bulan;
  String? nama;
  String? divisi;
  double? debetKawat;
  double? kreditKawat;
  double? sb;
  double? sprue;
  double? reject;

  ProduksiSBModel(
      {this.id,
      this.bulan,
      this.nama,
      this.divisi,
      this.debetKawat,
      this.kreditKawat,
      this.sb,
      this.sprue,
      this.reject});

  ProduksiSBModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bulan = json['bulan'];
    nama = json['nama'];
    divisi = json['divisi'];
    debetKawat = json['debet_kawat'];
    kreditKawat = json['kredit_kawat'];
    sb = json['sb'];
    sprue = json['sprue'];
    reject = json['reject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bulan'] = bulan;
    data['nama'] = nama;
    data['divisi'] = divisi;
    data['debet_kawat'] = debetKawat;
    data['kredit_kawat'] = kreditKawat;
    data['sb'] = sb;
    data['sprue'] = sprue;
    data['reject'] = reject;

    return data;
  }
}
