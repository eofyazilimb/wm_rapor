import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wm_rapor/model/permission_model.dart';
import 'package:wm_rapor/model/user_model.dart';
import 'package:wm_rapor/services/constants/http_constants.dart';
import 'package:wm_rapor/services/dio/dio_client.dart';
import 'package:wm_rapor/singleton/report_singleton.dart';
import 'package:wm_rapor/ui/common/app_colors.dart';
import 'package:wm_rapor/ui/common/ui_helpers.dart';
import 'package:wm_rapor/ui/views/report_menu.dart';
import 'package:wm_rapor/viewmodel/data_table_cubit.dart';
import 'package:wm_rapor/viewmodel/report_detail_cubit.dart';
import 'package:wm_rapor/viewmodel/report_paging_cubit.dart';
import 'package:wm_rapor/viewmodel/report_menu_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ReportMenuCubit()),
        BlocProvider(create: (context) => ReportPagingCubit()),
        BlocProvider(create: (context) => DataTableCubit()),
        BlocProvider(create: (context) => ReportDetailCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          dividerTheme: DividerThemeData(color: Colors.transparent),
          textTheme: GoogleFonts.montserratTextTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.kcPrimaryColor,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.kcWhite,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.kcPrimaryColor,
            shadowColor: AppColors.kcPrimaryColor,
            elevation: 4,
            iconTheme: IconThemeData(color: AppColors.kcWhite),
          ),
          datePickerTheme: DatePickerThemeData(
            backgroundColor: AppColors.kcVeryLightGray,
            headerBackgroundColor: AppColors.kcPrimaryColor,
            headerForegroundColor: AppColors.kcWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(UiHelpers.borderRadius),
            ),
            // (sürümünüz destekliyorsa) aralık dolgusu/overlay
            // rangeSelectionBackgroundColor: AppColors.primary.withOpacity(0.18),
            // rangeSelectionOverlayColor: MaterialStatePropertyAll(Colors.transparent),
          ),
        ),

        home: WmRapor(
          jwtToken: jwtToken,
          appVersion: '2001081',
          appToken: '0bdae46e-3300-4c33-8692-8fe8833c6edb',
          baseUrl: 'https://bcdefghjkb.webdemuhasebe.com/',
          deviceId: 'DEVICE-1234567890',
          user: User.fromJson(user),
          permissionList: permList.map((e) => Permission.fromJson(e)).toList(),
        ),
      ),
    );
  }

  final jwtToken =
      'eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTUxMiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImI5NzQxYmRkLTllYTAtNDllNS1hYzg3LTdjMzIxNjA0YWZjZiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJNZWhtZXQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJZw7ZuZXRpbSIsImV4cCI6MTc2NDcxMTQ2N30.18XZdb3Zzbbw7lRG_LcXC7_3xaYbwESBsqeabEO576jMcDasTqPlRYPALbfWjrykGVNzoOf_pBxeFcZKebCcmA';

  final user = {
    "kullaniciadi": "Mehmet",
    "kullanicisoyadi": "Karalar",
    "kullanicigrupid": 1,
    "kullanicisifre": "m1",
    "ceptelefon": "05321110363",
    "aktif": true,
    "kullanicieposta": "mehmetkaralar@eofyazilim.com",
    "epostaonayli": true,
    "telefononayli": true,
    "ikilidogrulama": true,
    "rol": "Yönetim",
    "kurumid": 1,
    "firmanr": 10,
    "departmannr": 10,
    "deponr": 10,
    "raporkod1": "r1",
    "yetkikodu": "y1",
    "subenr": 10,
    "kurumlar": [],
    "id": 4,
    "refid": "b9741bdd-9ea0-49e5-ac87-7c321604afcf",
    "eklemetarihi": "2025-03-10T07:05:35.534",
    "ekleyen": 1,
    "degistiren": 0,
    "cikarildi": false,
    "cikaran": 0,
    "evrakkayitdurumu": 2,
  };

  final permList = [
    {
      "kullaniciid": 4,
      "modul": "mdlRaporlarim",
      "anagrup": "accGrpRaporlarim",
      "altgrup": "KasaRaporları",
      "sube": "10, 20",
      "depo": "10, 11, 20, 21, 22",
      "yetkikodu": "*",
      "ylistele": true,
      "yekle": true,
      "yguncelle": true,
      "ycikar": true,
      "ytam": true,
      "nesne": "",
      "etiket": "mdlRaporlarim.accGrpRaporlarim.KasaRaporları.KasaRaporları",
      "mobilkullanim": true,
      "aciklama": "Kasa Raporları",
      "mobilurl": "",
      "resimurl": "",
      "iconurl": "assets/kasa_raporlari_menu.svg",
      "kurumid": 1,
      "firmanr": 10,
      "favori": false,
      "id": 1753,
      "refid": "2b12c33f-91e7-4e92-b63b-f6012393fec2",
      "eklemetarihi": "2025-09-23T07:57:07.280",
      "ekleyen": 1,
      "degistiren": 0,
      "cikarildi": false,
      "cikaran": 0,
      "evrakkayitdurumu": 2,
    },
    {
      "kullaniciid": 4,
      "modul": "mdlRaporlarim",
      "anagrup": "accGrpRaporlarim",
      "altgrup": "StokRaporları",
      "sube": "10, 20",
      "depo": "10, 11, 20, 21, 22",
      "yetkikodu": "*",
      "ylistele": true,
      "yekle": true,
      "yguncelle": true,
      "ycikar": true,
      "ytam": true,
      "nesne": "",
      "etiket": "mdlRaporlarim.accGrpRaporlarim.StokRaporları.StokRaporları",
      "mobilkullanim": true,
      "aciklama": "Stok Raporlarım",
      "mobilurl": "",
      "resimurl": "",
      "iconurl": "assets/stok_raporlari_menu.svg",
      "kurumid": 1,
      "firmanr": 10,
      "favori": false,
      "id": 1749,
      "refid": "4dec3fb7-2d23-4467-b2c1-aaa470d08831",
      "eklemetarihi": "2025-09-23T07:57:06.240",
      "ekleyen": 1,
      "degistiren": 0,
      "cikarildi": false,
      "cikaran": 0,
      "evrakkayitdurumu": 2,
    },
    {
      "kullaniciid": 4,
      "modul": "mdlRaporlarim",
      "anagrup": "accGrpRaporlarim",
      "altgrup": "SatınalmaRaporları",
      "sube": "10, 20",
      "depo": "10, 11, 20, 21, 22",
      "yetkikodu": "*",
      "ylistele": true,
      "yekle": true,
      "yguncelle": true,
      "ycikar": true,
      "ytam": true,
      "nesne": "",
      "etiket":
          "mdlRaporlarim.accGrpRaporlarim.SatınalmaRaporları.SatınalmaRaporları",
      "mobilkullanim": true,
      "aciklama": "Satınalma Raporları",
      "mobilurl": "",
      "resimurl": "",
      "iconurl": "assets/satinalma_menu.svg",
      "kurumid": 1,
      "firmanr": 10,
      "favori": false,
      "id": 1750,
      "refid": "0632f53c-05da-4be3-883b-6be2d20b8220",
      "eklemetarihi": "2025-09-23T07:57:06.491",
      "ekleyen": 1,
      "degistiren": 0,
      "cikarildi": false,
      "cikaran": 0,
      "evrakkayitdurumu": 2,
    },
    {
      "kullaniciid": 4,
      "modul": "mdlRaporlarim",
      "anagrup": "accGrpRaporlarim",
      "altgrup": "SatışRaporları",
      "sube": "10, 20",
      "depo": "10, 11, 20, 21, 22",
      "yetkikodu": "*",
      "ylistele": true,
      "yekle": true,
      "yguncelle": true,
      "ycikar": true,
      "ytam": true,
      "nesne": "",
      "etiket": "mdlRaporlarim.accGrpRaporlarim.SatışRaporları.SatışRaporları",
      "mobilkullanim": true,
      "aciklama": "Satış Raporları",
      "mobilurl": "",
      "resimurl": "",
      "iconurl": "assets/satis_raporlari_menu.svg",
      "kurumid": 1,
      "firmanr": 10,
      "favori": false,
      "id": 1751,
      "refid": "b4c4d905-0af9-43db-824f-ecf1194e83b3",
      "eklemetarihi": "2025-09-23T07:57:06.752",
      "ekleyen": 1,
      "degistiren": 0,
      "cikarildi": false,
      "cikaran": 0,
      "evrakkayitdurumu": 2,
    },
    {
      "kullaniciid": 4,
      "modul": "mdlRaporlarim",
      "anagrup": "accGrpRaporlarim",
      "altgrup": "CariRaporları",
      "sube": "10, 20",
      "depo": "10, 11, 20, 21, 22",
      "yetkikodu": "*",
      "ylistele": true,
      "yekle": true,
      "yguncelle": true,
      "ycikar": true,
      "ytam": true,
      "nesne": "",
      "etiket": "mdlRaporlarim.accGrpRaporlarim.CariRaporları.CariRaporları",
      "mobilkullanim": true,
      "aciklama": "Cari Raporları",
      "mobilurl": "",
      "resimurl": "",
      "iconurl": "assets/cari_raporlari_menu.svg",
      "kurumid": 1,
      "firmanr": 10,
      "favori": false,
      "id": 1752,
      "refid": "d1d0ede8-14f7-437a-9c67-bbc21a0f4ea9",
      "eklemetarihi": "2025-09-23T07:57:07.004",
      "ekleyen": 1,
      "degistiren": 0,
      "cikarildi": false,
      "cikaran": 0,
      "evrakkayitdurumu": 2,
    },
    {
      "kullaniciid": 4,
      "modul": "mdlRaporlarim",
      "anagrup": "accGrpRaporlarim",
      "altgrup": "BankaRaporları",
      "sube": "10, 20",
      "depo": "10, 11, 20, 21, 22",
      "yetkikodu": "*",
      "ylistele": true,
      "yekle": true,
      "yguncelle": true,
      "ycikar": true,
      "ytam": true,
      "nesne": "",
      "etiket": "mdlRaporlarim.accGrpRaporlarim.BankaRaporları.BankaRaporları",
      "mobilkullanim": true,
      "aciklama": "Banka Raporları",
      "mobilurl": "",
      "resimurl": "",
      "iconurl": "assets/banka_raporlari_menu.svg",
      "kurumid": 1,
      "firmanr": 10,
      "favori": false,
      "id": 1754,
      "refid": "0ac5725c-b432-432f-95ed-13c310cfd5f2",
      "eklemetarihi": "2025-09-23T07:57:07.758",
      "ekleyen": 1,
      "degistiren": 0,
      "cikarildi": false,
      "cikaran": 0,
      "evrakkayitdurumu": 2,
    },
    {
      "kullaniciid": 4,
      "modul": "mdlRaporlarim",
      "anagrup": "accGrpRaporlarim",
      "altgrup": "KıymetliEvrakRaporları",
      "sube": "10, 20",
      "depo": "10, 11, 20, 21, 22",
      "yetkikodu": "*",
      "ylistele": true,
      "yekle": true,
      "yguncelle": true,
      "ycikar": true,
      "ytam": true,
      "nesne": "",
      "etiket":
          "mdlRaporlarim.accGrpRaporlarim.KıymetliEvrakRaporları.KıymetliEvrakRaporları",
      "mobilkullanim": true,
      "aciklama": "Kıymetli Evrak Raporları",
      "mobilurl": "",
      "resimurl": "",
      "iconurl": "assets/kiymetli_evrak_menu.svg",
      "kurumid": 1,
      "firmanr": 10,
      "favori": false,
      "id": 1755,
      "refid": "e5dea073-a1cf-46e2-87e6-6469a7a1c244",
      "eklemetarihi": "2025-09-23T07:57:08.652",
      "ekleyen": 1,
      "degistiren": 0,
      "cikarildi": false,
      "cikaran": 0,
      "evrakkayitdurumu": 2,
    },
    {
      "kullaniciid": 4,
      "modul": "mdlRaporlarim",
      "anagrup": "accGrpRaporlarim",
      "altgrup": "ÖzelRaporlar",
      "sube": "10, 20",
      "depo": "10, 11, 20, 21, 22",
      "yetkikodu": "*",
      "ylistele": true,
      "yekle": true,
      "yguncelle": true,
      "ycikar": true,
      "ytam": true,
      "nesne": "",
      "etiket": "mdlRaporlarim.accGrpRaporlarim.ÖzelRaporlar.ÖzelRaporlar",
      "mobilkullanim": true,
      "aciklama": "Özel Raporlar",
      "mobilurl": "",
      "resimurl": "",
      "iconurl": "assets/ozel_raporlar_menu.svg",
      "kurumid": 1,
      "firmanr": 10,
      "favori": false,
      "id": 1756,
      "refid": "80f580d3-f694-4e6f-9611-05c48f3adcaf",
      "eklemetarihi": "2025-09-23T07:57:09.668",
      "ekleyen": 1,
      "degistiren": 0,
      "cikarildi": false,
      "cikaran": 0,
      "evrakkayitdurumu": 2,
    },
  ];
}

class WmRapor extends StatelessWidget {
  final String jwtToken;
  final String appVersion;
  final String baseUrl;
  final String appToken;
  final String deviceId;
  final User user;
  final List<Permission> permissionList;

  WmRapor({
    super.key,
    required this.jwtToken,
    required this.user,
    required this.permissionList,
    required this.appVersion,
    required this.baseUrl,
    required this.appToken,
    required this.deviceId,
  }) {
    ReportSingleton reportSingleton = ReportSingleton();
    DioClient dioClient = DioClient();
    reportSingleton.setUser = user;
    reportSingleton.setPermissionList = permissionList;
    dioClient.setJwtToken = jwtToken;
    dioClient.setBaseUrl = baseUrl;
    HttpConstants.setAppToken = appToken;
    HttpConstants.setAppVersion = appVersion;
    HttpConstants.setDeviceId = deviceId;
  }

  @override
  Widget build(BuildContext context) {
    return const ReportMenu();
  }
}
