import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:form_designer/SCM/mainScreen/kebutuhan_batu_by_siklus.dart';
import 'package:form_designer/SCM/mainScreen/list_scm.dart';
import 'package:form_designer/admin/list_user.dart';
import 'package:form_designer/admin/send_notif.dart';
import 'package:form_designer/calculatePricing/list_calculate_pricing_screen.dart';
import 'package:form_designer/ga/home_screen_ga.dart';
import 'package:form_designer/mainScreen/home_admin.dart';
import 'package:form_designer/mainScreen/home_screen.dart';
import 'package:form_designer/mainScreen/list_batu_screen.dart';
import 'package:form_designer/mainScreen/list_data_modeller.dart';
import 'package:form_designer/mainScreen/list_designer_screen.dart';
import 'package:form_designer/mainScreen/list_mps.dart';
import 'package:form_designer/mainScreen/list_status_approval.dart';
import 'package:form_designer/pembelian/home_pembelian.dart';
import 'package:form_designer/pembelian/list_form_pr.dart';
import 'package:form_designer/pembelian/list_invoice.dart';
import 'package:form_designer/produksi/mainScreen/dashboard_control.dart';
import 'package:form_designer/produksi/mainScreen/dashboard_orul_reparasi.dart';
import 'package:form_designer/produksi/mainScreen/monthly_meeting_scm.dart';
import 'package:form_designer/produksi/mainScreen/produksi_new_screen.dart';
import 'package:form_designer/produksi/mainScreen/report_untuk_manufaktur.dart';
import 'package:form_designer/produksi/mainScreen/summary_pasang_batu.dart';
import 'package:form_designer/produksi/mainScreen/summary_produktivitas.dart';
import 'package:form_designer/produksi/mainScreen/summary_susut.dart';
import 'package:form_designer/qc/mainScreen/home_qc.dart';
import 'package:form_designer/qc/mainScreen/list_form_pr_qc.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
int revisiBesar =
    1; //UI baru, banyak fitur baru, perubahan konsep, dll  (MAJOR)
int revisiKecil =
    49; //perubahan kecil                                    (MINOR)
int rilisPerbaikanbug =
    12; //perbaikan bug                                      (PATCH)
//? komen
SendNotif notif = SendNotif();
String fcmServerToken =
    "AAAAcuKVUe8:APA91bGu674MRJ9S3DUyAnRkHGOhRh_IARdfPYEckq5kB5LyHsL1zOEuqDtLFXtsRY1PDVDGBVhaV0ApkYGGAMFGV-bHav-jJcEYGaGaQRf1HcTbhNsM5nipDlLZP3H4C8t9fr8jo8lQ";

Color colorDasar = const Color.fromRGBO(38, 54, 72, 1);
Color colorBG = const Color.fromARGB(255, 157, 157, 165);
Color colorGrey = const Color.fromARGB(243, 243, 243, 187);
Color colorCard1 = const Color.fromRGBO(90, 174, 170, 1);
Color colorCard2 = const Color.fromRGBO(194, 203, 201, 1);

String version = 'v$revisiBesar.$revisiKecil.$rilisPerbaikanbug';
String aksesKode = "S@niv0kasi";
double tinggiTextfield = 75.0; // tinggi text field

var now = DateTime.now();
String siklusSaatIini = DateFormat('MMMM', 'id').format(now);

List<Widget> screenGlobal = [
  const SizedBox(),
  const HomeScreenAdmin(),
  const ListUser(),
  const HomeScreen(),
  const HomeScreenQc(),
  const MonthlyMeetingScm(),
  const HomeScreenPembelian(),
  const ReportUntukManufaktur(),
  const DashboardOrulReparasi(),
  const DashboardControl(),
  const ListDataModellerScreen(),
  const ListDesignerScreen(),
  const ListScmScreen(),
  const ListBatuScreen(),
  const ListFormPr(),
  const ListKebutuhanBatuScreen(),
  const ListFormPrQc(),
  const ProduksiNewScreen(),
  const ListMpsScreen(),
  const SummarySusutScreen(),
  const SummaryPasangBatuScreen(),
  const SummaryProduktivitasScreen(),
  const ListStatusApprovalScreen(),
  const ListCalculatePricingScreen(),
  const HomeScreenGa(),
  const ListInvoice(),
];
Map<String, IconData> iconMapGlobal = {
  'Dashboard Admin': Icons.home,
  'Dashboard Ga': Icons.home,
  'Dashboard Procurement': Icons.home,
  'Dashboard Qc': Icons.home,
  'Dashboard': Icons.home,
  'List Data User': Icons.list,
  'List Invoice': Icons.list,
  'List Data Modeller': Icons.list_alt,
  'List Data Batu': Icons.list,
  'List Data Designer': Icons.list_alt,
  'List Data Kebutuhan Batu': Icons.list,
  'List Data SCM': Icons.list_alt,
  'MPS': Icons.list,
  'Monthly Meeting SCM': Icons.list_alt,
  'Dashboard Control': Icons.list,
  'Daily Produksi': Icons.list_alt,
  'SUM Susut': Icons.list,
  'SUM Pasang Batu': Icons.list_alt,
  'SUM Produktivitas': Icons.list,
  'List Data Status Approval': Icons.list_alt,
  'Calculate Pricing': Icons.list,
  'List Form Qc': Icons.list_alt,
  'List Form Pr': Icons.list,
  'Report Manufaktur': Icons.list_alt,
  'Dashboard Orul & Reparasi': Icons.list,
  // Tambahkan mapping untuk ikon lainnya sesuai kebutuhan Anda
};

//*HINTS global fungsi showCustomDialog

void showCustomDialog({
  required BuildContext context,
  required DialogType dialogType,
  required String title,
  required String description,
  bool dissmiss = true,
}) {
  AwesomeDialog(
    context: context,
    dialogType: dialogType,
    borderSide: const BorderSide(
      color: Colors.green,
      width: 2,
    ),
    buttonsBorderRadius: const BorderRadius.all(
      Radius.circular(2),
    ),
    width: 450,
    dismissOnTouchOutside: dissmiss,
    dismissOnBackKeyPress: dissmiss,
    headerAnimationLoop: true,
    animType: AnimType.bottomSlide,
    title: title,
    desc: description,
    btnOkOnPress: () {},
  ).show();
}

void showDialogError({
  required BuildContext context,
  required DialogType dialogType,
  required String title,
  required String description,
  bool dissmiss = false,
}) {
  AwesomeDialog(
    context: context,
    dialogType: dialogType,
    borderSide: const BorderSide(
      color: Colors.green,
      width: 2,
    ),
    buttonsBorderRadius: const BorderRadius.all(
      Radius.circular(2),
    ),
    width: 450,
    dismissOnTouchOutside: dissmiss,
    dismissOnBackKeyPress: dissmiss,
    headerAnimationLoop: true,
    animType: AnimType.bottomSlide,
    title: title,
    desc: description,
  ).show();
}

List<String> namaBulan = [
  "JANUARI",
  "FEBRUARI",
  "MARET",
  "APRIL",
  "MEI",
  "JUNI",
  "JULI",
  "AGUSTUS",
  "SEPTEMBER",
  "OKTOBER",
  "NOVEMBER",
  "DESEMBER"
];
