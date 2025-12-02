import 'package:wm_rapor/model/permission_model.dart';
import 'package:wm_rapor/ui/common/app_constants.dart';

class PermUtil {
  bool yetkiKontrol(Permission? ytk, EnumYetkiTurleri yetkiTuru) {
    if (ytk == null) return false;

    bool rv = false;
    switch (yetkiTuru) {
      case EnumYetkiTurleri.tam:
        rv = ytk.ytam!;
        break;
      case EnumYetkiTurleri.listele:
        rv = ytk.ytam! ? ytk.ytam! : ytk.ylistele!;
        break;
      case EnumYetkiTurleri.ekle:
        rv = ytk.ytam! ? ytk.ytam! : ytk.yekle!;
        break;
      case EnumYetkiTurleri.degistir:
        rv = ytk.ytam! ? ytk.ytam! : ytk.yguncelle!;
        break;
      case EnumYetkiTurleri.incele:
        rv = (ytk.ytam! || ytk.ylistele!) ? true : ytk.yguncelle!;
        break;
      case EnumYetkiTurleri.cikar:
        rv = ytk.ytam! ? ytk.ytam! : ytk.ycikar!;
        break;
    }
    return rv;
  }
}
