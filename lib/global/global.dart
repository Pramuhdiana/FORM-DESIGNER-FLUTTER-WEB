import 'package:flutter/material.dart';
import 'package:form_designer/SCM/mainScreen/kebutuhan_batu_by_siklus.dart';
import 'package:form_designer/SCM/mainScreen/list_scm.dart';
import 'package:form_designer/admin/list_user.dart';
import 'package:form_designer/calculatePricing/list_calculate_pricing_screen.dart';
import 'package:form_designer/mainScreen/home_screen.dart';
import 'package:form_designer/mainScreen/list_batu_screen.dart';
import 'package:form_designer/mainScreen/list_data_modeller.dart';
import 'package:form_designer/mainScreen/list_designer_screen.dart';
import 'package:form_designer/mainScreen/list_mps.dart';
import 'package:form_designer/mainScreen/list_status_approval.dart';
import 'package:form_designer/pembelian/home_pembelian.dart';
import 'package:form_designer/pembelian/list_form_pr.dart';
import 'package:form_designer/produksi/mainScreen/dashboard_control.dart';
import 'package:form_designer/produksi/mainScreen/monthly_meeting_scm.dart';
import 'package:form_designer/produksi/mainScreen/produksi_new_screen.dart';
import 'package:form_designer/produksi/mainScreen/report_untuk_manufaktur.dart';
import 'package:form_designer/produksi/mainScreen/summary_pasang_batu.dart';
import 'package:form_designer/produksi/mainScreen/summary_produktivitas.dart';
import 'package:form_designer/produksi/mainScreen/summary_susut.dart';
import 'package:form_designer/qc/mainScreen/list_form_pr_qc.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
int revisiBesar =
    1; //UI baru, banyak fitur baru, perubahan konsep, dll  (MAJOR)
int revisiKecil =
    39; //perubahan kecil                                    (MINOR)
int rilisPerbaikanbug =
    12; //perbaikan bug                                      (PATCH)
//? komen
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
  const HomeScreenPembelian(),
  const ListUser(),
  const ListDataModellerScreen(),
  const ListBatuScreen(), //* produksi
  const ListDesignerScreen(),
  const ListKebutuhanBatuScreen(),
  const ListScmScreen(),
  const ListMpsScreen(),
  const MonthlyMeetingScm(),
  const DashboardControl(),
  const ProduksiNewScreen(),
  const SummarySusutScreen(),
  const SummaryPasangBatuScreen(),
  const SummaryProduktivitasScreen(),
  const ListStatusApprovalScreen(),
  const ListCalculatePricingScreen(),
  const ListFormPrQc(),
  const ListFormPr(),
  const ReportUntukManufaktur(),
];
