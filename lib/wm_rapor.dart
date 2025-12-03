import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wm_rapor/model/permission_model.dart';
import 'package:wm_rapor/model/user_model.dart';
import 'package:wm_rapor/services/constants/http_constants.dart';
import 'package:wm_rapor/services/dio/dio_client.dart';
import 'package:wm_rapor/singleton/report_singleton.dart';
import 'package:wm_rapor/ui/views/report_menu.dart';

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
