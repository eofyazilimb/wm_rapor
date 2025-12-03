import 'package:wm_rapor/model/permission_model.dart';
import 'package:wm_rapor/model/report_enum_model.dart';
import 'package:wm_rapor/model/user_model.dart';

class ReportSingleton {
  static final ReportSingleton _sigleton = ReportSingleton._internal();

  factory ReportSingleton() {
    return _sigleton;
  }

  ReportSingleton._internal();

  User? user;
  List<Permission>? permissionList;
  ReportEnumModel? reportEnumModel;

  set setUser(Map<String, dynamic> usr) {
    user = User.fromJson(usr);
  }

  set setPermissionList(List<Map<String, dynamic>> permList) {
    permissionList = permList.map((e) => Permission.fromJson(e)).toList();
  }

  set setReportEnums(ReportEnumModel rem) {
    reportEnumModel = rem;
  }

  get getUser => user;

  get getPermissionList => permissionList;
}
