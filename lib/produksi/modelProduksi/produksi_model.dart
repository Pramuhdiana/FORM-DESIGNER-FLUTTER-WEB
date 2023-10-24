class ProduksiModel {
  int? id;
  String? bulan;
  String? nama;
  String? divisi;
  String? tanggalIn;
  String? tanggalOut;
  String? kodeProduksi;
  double? debet;
  double? kredit;
  double? point;
  double? jatahSusut;
  double? susutBarang;
  String? keterangan;
  double? kadar;

  ProduksiModel(
      {this.id,
      this.bulan,
      this.nama,
      this.divisi,
      this.tanggalIn,
      this.tanggalOut,
      this.kodeProduksi,
      this.debet,
      this.kredit,
      this.point,
      this.jatahSusut,
      this.susutBarang,
      this.keterangan,
      this.kadar});

  ProduksiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bulan = json['bulan'];
    nama = json['nama'];
    divisi = json['divisi'];
    tanggalIn = json['tanggal_in'];
    tanggalOut = json['tanggal_out'];
    kodeProduksi = json['kode_produksi'] ?? ' ';
    debet = json['debet'];
    kredit = json['kredit'];
    point = json['point'];
    jatahSusut = json['jatah_susut'];
    susutBarang = json['susut_barang'];
    keterangan = json['keterangan'] ?? ' ';
    kadar = json['kadar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bulan'] = bulan;
    data['nama'] = nama;
    data['divisi'] = divisi;
    data['tanggal_in'] = tanggalIn;
    data['tanggal_out'] = tanggalOut;
    data['kode_produksi'] = kodeProduksi;
    data['debet'] = debet;
    data['kredit'] = kredit;
    data['point'] = point;
    data['jatah_susut'] = jatahSusut;
    data['susut_barang'] = susutBarang;
    data['keterangan'] = keterangan;
    data['kadar'] = kadar;
    return data;
  }
}
