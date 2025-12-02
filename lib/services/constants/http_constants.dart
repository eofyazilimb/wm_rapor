mixin HttpConstants {
  //* Sabit token
  static String appToken = '';
  static String appVersion = '';
  static String deviceId = '';

  //* HTTP bağlantısı için maksimum süre aşımı değerleri.
  static const connectionTimeOut = Duration(milliseconds: 140000);
  static const receiveTimeOut = Duration(milliseconds: 140000);

  //* Paging Page Size

  static const int pageSize = 50;

  //* Paging Params
  static Map<String, dynamic> pagingParamMap({
    int? dataSize,
    int? pageSize,
    String? sortBy,
    String? sortOrder,
  }) {
    return {
      "dataSize": dataSize ?? 0,
      "pageSize": pageSize ?? 50,
      "sortBy": sortBy ?? 'id',
      "sortOrder": sortOrder ?? 'desc',
    };
  }

  static set setAppToken(String token) {
    appToken = token;
  }

  static set setAppVersion(String appVer) {
    appVersion = appVer;
  }

  static set setDeviceId(String devId) {
    deviceId = devId;
  }

  //* Constants
  static const getEnumsPath = '/api/sistem/Sabitler/getenumortak';
  static const getStockEnumsPath = '/api/sistem/Sabitler/getenumstok';
  static const getSystemNoPath = '/api/sistem/Sabitler/getsistemno';
  static const getEnumDoc = '/api/sistem/Sabitler/getenumebelge';
  static const getEnumReport = '/api/sistem/Sabitler/getenumyetkirapor';

  static const appParamPath = '/api/sistem/Sabitler/uygulamaparametre';
  static const currencyDaily = '/api/v1/tanimlar/DovizKurlari/gunlukkur';
  static const listBranch = '/api/sistem/Sube/listele';
  static const listWarehouse = '/api/sistem/Depo/listele';
  static const listDepartment = '/api/sistem/Departman/listele';
  static const listStaff = '/api/v1/tanimlar/Personel/listele';

  //* Report
  static const listReport = '/api/v1/Rapor/listele';
  static const pagingReport = '/api/v1/Rapor/sayfala';
  static const addingReport = '/api/v1/Rapor/ekle';
  static const editingReport = '/api/v1/Rapor/guncelle';
  static const itemReport = '/api/v1/Rapor/veri';
  static const deletingReport = '/api/v1/Rapor/cikar';
  static const viewingReport = '/api/v1/Rapor/raporgoruntule';
  static const fetchReport = '/api/v1/Rapor/raporverigetir';
}
