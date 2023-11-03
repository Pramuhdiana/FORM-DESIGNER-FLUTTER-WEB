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
  double? beratEmas;
  double? beratDiamond;
  int? butirDiamond;
  int? totalOngkosan;

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
      this.kadar,
      this.beratEmas,
      this.beratDiamond,
      this.butirDiamond,
      this.totalOngkosan});

  ProduksiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bulan = json['bulan'];
    nama = json['nama'];
    divisi = json['divisi'];
    tanggalIn = json['tanggal_in'];
    tanggalOut = json['tanggal_out'];
    kodeProduksi = json['kode_produksi'] ?? ' ';
    debet = json['debet'] ?? 0;
    kredit = json['kredit'] ?? 0;
    point = json['point'] ?? 0;
    jatahSusut = json['jatah_susut'] ?? 0;
    susutBarang = json['susut_barang'] ?? 0;
    keterangan = json['keterangan'] ?? ' ';
    kadar = json['kadar'] ?? 0;
    beratEmas = json['berat_emas'] ?? 0;
    beratDiamond = json['berat_diamond'] ?? 0;
    butirDiamond = json['butir_diamond'] ?? 0;
    totalOngkosan = json['total_ongkosan'] ?? 0;
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
    data['berat_emas'] = beratEmas;
    data['berat_diamond'] = beratDiamond;
    data['butir_diamond'] = butirDiamond;
    data['total_ongkosan'] = totalOngkosan;
    return data;
  }
}
