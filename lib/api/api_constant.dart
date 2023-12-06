// ignore_for_file: non_constant_identifier_names

// http://110.5.102.154:1212/
// http://localhost:1212/
class ApiConstants {
  static String baseUrlImage =
      'http://110.5.102.154:1212/Api_Flutter/spk/upload/';
  static String baseUrl = 'http://110.5.102.154:1212/Api_Flutter/';
  // static String baseUrlImage =
  //     'http://110.5.102.154:1212/Api_Flutter/spk/upload/';
  // static String baseUrl = 'http://110.5.102.154:1212/Api_Flutter/';
  static String getNilaiProduksi = 'spk/get_nilai_produksi.php';
  static String getDataBatu = 'spk/batu.php';
  static String getDataBatuCalculator = 'spk/batu_calculator.php';
  static String getDataBatuByName = 'spk/get_batu_by_name.php';
  static String getDataBatuMdbc = 'spk/batu_mdbc.php';
  static String getNilaiData = 'spk/nilaidata.php';
  static String getListRantai = 'spk/list_rantai.php';
  static String getListEarnut = 'spk/list_earnut.php';
  static String getListJenisBarangById = 'spk/list_jenisbarang_by_id.php';
  static String getDataBatuId = 'spk/get_batu_by_name.php';
  static String getListLain2 = 'spk/list_lain2.php';
  static String getListJenisbarang = 'spk/list_jenisbarang.php';
  static String getListFormDesigner = 'spk/list_form_designer.php';
  static String getListFormDesignerByName =
      'spk/list_form_designer_by_name.php';
  static String getListFormDesignerBySiklus =
      'spk/list_form_designer_by_siklus.php';
  static String getBatuMdbcByKeyword = 'spk/get_batu_mdbc_by_keyword.php';
  static String getListEstimasiHarga = 'spk/get_estimasi_pricing.php';
  static String getSiklus = 'spk/get_siklus.php';
  static String getSumPenyesuaian = 'spk/get_sum_penyesuaian.php';
  static String getProduksi = 'spk/get_produksi.php';
  static String getProduksiSB = 'spk/get_produksi_SB.php';
  static String getProduksiByDivisi =
      'spk/get_produksi_by_divisi.php'; // bisa filter juga dengan bulan
  static String getListArtist = 'spk/list_artist_produksi.php';
  static String getListDivisi = 'spk/list_divisi.php';
  static String getDataModeller = 'spk/get_data_modeller.php';

  static String postDataBatu = 'spk/create_batu.php';
  static String postLogin = 'spk/login.php';
  static String postFormDesigner = 'spk/create_form_designer.php';
  static String postFormEstimasiPricing = 'spk/create_estimasi_pricing.php';
  static String postBatuPenyesuaian = 'spk/create_batu_penyesuaian.php';
  static String postDataProduksi = 'spk/create_produksi.php';
  static String postDataModeller = 'spk/create_data_modeller.php';

  static String postDeleteFormDesignerById =
      'spk/delete_form_designer_by_id.php';
  static String postDeleteBatuById = 'spk/delete_batu_by_id.php';
  static String postUpdateDataBatu = 'spk/update_qty_batu.php';
  static String postUpdateDataBatuBySize = 'spk/update_qty_batu_by_size.php';
  static String postUpdateListDataBatu = 'spk/update_batu.php';
  static String updateFormDesigner = 'spk/update_form_designer.php';
  static String updateSiklusdesigner = 'spk/update_siklus_designer.php';
  static String updatePosisi = 'spk/add_posisi.php';
  static String updateNilaiProduksi = 'spk/update_nilai_produksi.php';
  static String updateDataModeller = 'spk/update_form_data_modeller.php';

  static String addModeller = 'spk/add_modeller.php';
  static String addPointModeller = 'spk/add_point_modeller.php';
  static String addSiklus = 'spk/add_siklus.php';
  static String addTanggalProduksi = 'spk/add_tanggal_in_produksi.php';
  static String addTanggalModeller = 'spk/add_tanggal_out_modeller.php';
  static String addHistoryPosisi = 'spk/create_history.php';

  static String keyById = 'spk/key.php';
}
