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

  set setUser(User usr) {
    user = usr;
  }

  set setPermissionList(List<Permission> permList) {
    permissionList = permList;
  }

  set setReportEnums(ReportEnumModel rem) {
    reportEnumModel = rem;
  }

  get getUser => user;

  get getPermissionList => permissionList;
}
