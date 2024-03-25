class ProduksiModel2024 {
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
  

  ProduksiModel2024(
      {
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
     });

  ProduksiModel2024.fromJson(Map<String, dynamic> json) {
    nama = json['employee_Name'] ?? '';
    divisi = json['prod_Location'];
    tanggalIn = json['issued_Date'];
    tanggalOut = json['received_Date'];
    kodeProduksi = json['legacy_Item_No'] ?? ' ';
    debet = json['issued_Net_Wt'] ?? 0;
    kredit = json['returned_Wt'] ?? 0;
    point = 0;
    jatahSusut = 0;
    susutBarang = json['issued_Net_Wt'] - json['returned_Wt'];
    keterangan =  ' ';
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_Name'] = nama;
    data['prod_Location'] = divisi;
    data['issued_Date'] = tanggalIn;
    data['received_Date'] = tanggalOut;
    data['legacy_Item_No'] = kodeProduksi;
    data['issued_Net_Wt'] = debet;
    data['returned_Wt'] = kredit;
    return data;
  }
  // ProduksiModel2024.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   bulan = json['bulan'];
  //   nama = json['nama'] ?? '';
  //   divisi = json['divisi'];
  //   tanggalIn = json['tanggal_in'];
  //   tanggalOut = json['tanggal_out'];
  //   kodeProduksi = json['kode_produksi'] ?? ' ';
  //   debet = json['debet'] ?? 0;
  //   kredit = json['kredit'] ?? 0;
  //   point = json['point'] ?? 0;
  //   jatahSusut = json['jatah_susut'] ?? 0;
  //   susutBarang = json['susut_barang'] ?? 0;
  //   keterangan = json['keterangan'] ?? ' ';
  //   kadar = json['kadar'] ?? 0;
  //   beratEmas = json['berat_emas'] ?? 0;
  //   beratDiamond = json['berat_diamond'] ?? 0;
  //   butirDiamond = json['butir_diamond'] ?? 0;
  //   totalOngkosan = json['total_ongkosan'] ?? 0;
  //   parcel = json['parcel'] ?? '';
  //   dimensi = json['dimensi'] ?? '';
  //   pecahButir = json['pecah_butir'] ?? 0;
  //   pecahCarat = json['pecah_carat'] ?? 0;
  //   hilangButir = json['hilang_butir'] ?? 0;
  //   hilangCarat = json['hilang_carat'] ?? 0;
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['bulan'] = bulan;
  //   data['nama'] = nama;
  //   data['divisi'] = divisi;
  //   data['tanggal_in'] = tanggalIn;
  //   data['tanggal_out'] = tanggalOut;
  //   data['kode_produksi'] = kodeProduksi;
  //   data['debet'] = debet;
  //   data['kredit'] = kredit;
  //   data['point'] = point;
  //   data['jatah_susut'] = jatahSusut;
  //   data['susut_barang'] = susutBarang;
  //   data['keterangan'] = keterangan;
  //   data['kadar'] = kadar;
  //   data['berat_emas'] = beratEmas;
  //   data['berat_diamond'] = beratDiamond;
  //   data['butir_diamond'] = butirDiamond;
  //   data['total_ongkosan'] = totalOngkosan;
  //   data['parcel'] = parcel;
  //   data['dimensi'] = dimensi;
  //   data['pecah_butir'] = pecahButir;
  //   data['pecah_carat'] = pecahCarat;
  //   data['hilang_butir'] = hilangButir;
  //   data['hilang_carat'] = hilangCarat;
  //   return data;
  // }
}
