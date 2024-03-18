// ignore_for_file: non_constant_identifier_names

// http://110.5.102.154:1212/
// http://localhost:1212/
var ipPublic = '203.174.11.254'; //? before 110.5.102.154

class ApiConstants {
  static String baseUrlImage = 'http://$ipPublic:1212/Api_Flutter/spk/upload/';
  static String baseUrl = 'http://$ipPublic:1212/Api_Flutter/';

  //* HINTS API YANG SUDAH RESTFULL
  static String getListItem = 'spk/rest_api.php?type=listItem';
  static String getListPanjang = 'spk/rest_api.php?type=panjang';
  static String getListLebar = 'spk/rest_api.php?type=lebar';
  static String getListBeratKode = 'spk/rest_api.php?type=beratKode';
  static String getListJenisBatu = 'spk/rest_api.php?type=jenisBatu';
  static String getListKualitasBatu = 'spk/rest_api.php?type=kualitasBatu';
  static String getListUkuranRound = 'spk/rest_api.php?type=ukuranRound';
  static String getListKurir = 'spk/rest_api.php?type=kurir';
  static String getListPieCut = 'spk/rest_api.php?type=pieCut';
  static String getCountQc = 'spk/rest_api.php?type=qc';
  static String getItemQc = 'spk/rest_api.php?type=itemQc';
  static String updateItemPr = 'spk/rest_api.php';
  static String restFullApi = 'spk/rest_api.php';
  //* END RESTFULL

  static String getNilaiProduksi = 'spk/get_nilai_produksi.php';
  static String getDataBatu = 'spk/batu.php';
  static String getDataBatuCalculator = 'spk/batu_calculator.php';
  static String getDataBatuByName = 'spk/get_batu_by_name.php';
  static String getDataBatuMdbc = 'spk/batu_mdbc.php';
  static String getDataBatuMdbc2024 = 'spk/batu_mdbc2024.php';
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
  static String getDataModellerBykodeDesign =
      'spk/get_data_modeller_by_kodeDesign.php';
  static String getDataListItem = 'spk/list_item.php';
  static String getFormPR = 'spk/get_form_pr.php';
  static String getListFormPR = 'spk/get_list_form_pr.php';
  static String getListMps = 'spk/get_list_mps.php';
  static String getListMpsBySiklus = 'spk/get_list_mps_by_siklus.php';
  static String getListUsers = 'spk/get_users.php';
  static String getListMenu = 'spk/get_list_menu.php';

  static String postDataBatu = 'spk/create_batu.php';
  static String postLogin = 'spk/login.php';
  static String postFormDesigner = 'spk/create_form_designer.php';
  static String postFormEstimasiPricing = 'spk/create_estimasi_pricing.php';
  static String postBatuPenyesuaian = 'spk/create_batu_penyesuaian.php';
  static String postDataProduksi = 'spk/create_produksi.php';
  static String postDataModeller = 'spk/create_data_modeller.php';
  static String postDataMps = 'spk/create_mps.php';
  static String postDataMpsIsSend = 'spk/add_status_mps.php';
  static String postDeleteFormDesignerById =
      'spk/delete_form_designer_by_id.php';
  static String postDeleteBatuById = 'spk/delete_batu_by_id.php';
  static String postUpdateDataBatu = 'spk/update_qty_batu.php';
  static String postUpdateDataBatuBySize = 'spk/update_qty_batu_by_size.php';
  static String postUpdateListDataBatu = 'spk/update_batu.php';
  static String postDataListItem = 'spk/create_list_item.php';
  static String postListFormPR = 'spk/create_list_form_pr.php';
  static String postListFormQc = 'spk/create_list_form_qc.php';
  static String postFormPR = 'spk/create_form_pr.php';
  static String updateFormDesigner = 'spk/update_form_designer.php';
  static String updateSiklusdesigner = 'spk/update_siklus_designer.php';
  static String updatePosisi = 'spk/add_posisi.php';
  static String updatePosisidanWeek = 'spk/add_posisi_mps.php';
  static String updateNilaiProduksi = 'spk/update_nilai_produksi.php';
  static String updateDataModeller = 'spk/update_form_data_modeller.php';

  static String updateStatusPR = 'spk/update_form_pr.php';
  static String updateListFormPR = 'spk/update_list_form_pr.php';

  static String addModeller = 'spk/add_modeller.php';
  static String addPointModeller = 'spk/add_point_modeller.php';
  static String addSiklus = 'spk/add_siklus.php';
  static String addTanggalProduksi = 'spk/add_tanggal_in_produksi.php';
  static String addTanggalModeller = 'spk/add_tanggal_out_modeller.php';
  static String addHistoryPosisi = 'spk/create_history.php';

  static String createUsers = 'spk/create_users.php';

  static String keyById = 'spk/key.php';
}
