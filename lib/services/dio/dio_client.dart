import 'package:dio/dio.dart';
import 'package:wm_rapor/services/constants/http_constants.dart';
import 'package:wm_rapor/services/dio/api_response.dart';
import 'package:wm_rapor/services/dio/fetch_report_response.dart';

class DioClient {
  static String userName = '';
  static String baseUrl = '';
  static String jwtToken = '';
  static int userRef = 0;
  static int appRef = 0;
  static String b2bUrl = '';

  //static UserInfo userInfo = UserInfo();

  //Singleton yapısı kullanılarak class'ın tek bir örneği oluşturuluyor..
  DioClient._internal();
  factory DioClient() => DioClient._internal();

  // Dio oluşturuyoruz ve yapılandırıyoruz.
  final Dio _dio = Dio();

  set setBaseUrl(String url) {
    baseUrl = url;
  }

  set setJwtToken(String token) {
    jwtToken = token;
  }

  setDioOptions() {
    _dio.options.baseUrl =
        baseUrl; //base URL, tüm isteklerde kullanılacak kök URL.
    _dio.options.connectTimeout = HttpConstants
        .connectionTimeOut; // Bağlantı zaman aşımı süresi (ms cinsinden)
    _dio.options.receiveTimeout = HttpConstants
        .receiveTimeOut; //Veri alma zaman aşımı süresi (ms cinsinden)

    // _dio.options.interceptors
    //   .add(LogInterceptor(responseBody: true, request: true));
  }
  //Request ve response için middleware eklemek için kullanılır.
  //Burada LogInterceptor request ve responseleri konsola loglar.

  // post isteği attığımız fonksiyon.
  // 'path', URL'nin sonuna eklenen endpoint'i temsil eder.
  // 'try-cache' bloğu ise istek gönderirlirken oluşabilecek hataları handle eder.
  // Başarılı yanıt alındığında, _handleResponse fonksiyonu ile yanıtı işler ve ResponseEntity nesnesine dönüştürür.
  // Hata oluşursa _handleTimeout fonksiyonu timeout durumları için özel bir ResponseEntity nesnesi döndürür.
  Future<ApiResponse> get(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      //   String token = await getToken();
      _dio.options.baseUrl = baseUrl;
      _dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
        'app-token': HttpConstants.appToken,
        'app-version': HttpConstants.appVersion,
      };

      final response = await _dio.get(
        path,
        data: data,
        queryParameters: queryParams,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        return _handleResponse(e.response!);
      } else {
        return _handleTimeout(e);
      }
    } catch (e) {
      return _handleTimeout(e);
    }
  }

  // post isteği attığımız fonksiyon.
  // 'path', URL'nin sonuna eklenen endpoint'i temsil eder.
  // 'try-cache' bloğu ise istek gönderirlirken oluşabilecek hataları handle eder.
  // Başarılı yanıt alındığında, _handleResponse fonksiyonu ile yanıtı işler ve ResponseEntity nesnesine dönüştürür.
  // Hata oluşursa _handleTimeout fonksiyonu timeout durumları için özel bir ResponseEntity nesnesi döndürür.
  Future<ApiResponse> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
    String? deviceId,
  }) async {
    try {
      // String token = await getToken();

      _dio.options.baseUrl = baseUrl;
      _dio.options.headers = {
        // 'Content-Type': 'application/json',
        // 'Content-Type': 'application/json; profile=report; charset=utf-8',
        'Authorization': 'Bearer $jwtToken',
        'app-token': HttpConstants.appToken,
        'app-version': HttpConstants.appVersion,
        // 'app-deviceid': HttpConstants.deviceId,
      };

      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParams,
        options: options ?? Options(contentType: 'application/json'),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        return _handleResponse(e.response!);
      } else {
        return _handleTimeout(e);
      }
    } catch (e) {
      return _handleTimeout(e);
    }
  }

  Future<FetchReportResponse> postFetchReport(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
    String? deviceId,
  }) async {
    try {
      // String token = await getToken();

      _dio.options.baseUrl = baseUrl;
      _dio.options.headers = {
        // 'Content-Type': 'application/json',
        // 'Content-Type': 'application/json; profile=report; charset=utf-8',
        'Authorization': 'Bearer $jwtToken',
        'app-token': HttpConstants.appToken,
        'app-version': HttpConstants.appVersion,
        // 'app-deviceid': HttpConstants.deviceId,
      };

      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParams,
        options: options ?? Options(contentType: 'application/json'),
      );
      return FetchReportResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        return FetchReportResponse.fromJson(
          e.response?.data as Map<String, dynamic>,
        );
      } else {
        return FetchReportResponse.timeout();
      }
    } catch (e) {
      return FetchReportResponse.timeout();
    }
  }

  Future<ApiResponse> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      //   String token = await getToken();
      _dio.options.baseUrl = baseUrl;
      _dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
        'app-token': HttpConstants.appToken,
        'app-version': HttpConstants.appVersion,
      };

      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParams,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        return _handleResponse(e.response!);
      } else {
        return _handleTimeout(e);
      }
    } catch (e) {
      return _handleTimeout(e);
    }
  }

  Future<ApiResponse> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      //   String token = await getToken();
      _dio.options.baseUrl = baseUrl;
      _dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
        'app-token': HttpConstants.appToken,
        'app-version': HttpConstants.appVersion,
      };

      final response = await _dio.delete(path, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        return _handleResponse(e.response!);
      } else {
        return _handleTimeout(e);
      }
    } catch (e) {
      return _handleTimeout(e);
    }
  }

  //Dio'dan gelen response'ı değerlendiriyoruz.
  //_handleResponse fonksiyonu, Dio cevabını değerlendirir ve başarılı bir HTTP yanıtı alındıysa ResponseEntity tipine dönüştürür.
  // Başarısız bir yanıt alındığında, hatalı yanıtı temsil eden bir ResponseEntity döndürür.
  ApiResponse _handleResponse<T>(Response<T> response) {
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(response.data as Map<String, dynamic>);
    } else {
      return ApiResponse.fromJson(response.data as Map<String, dynamic>);
    }
  }

  //_handleTimeout fonksiyonu, zaman aşımı hatalarını ele alır ve ResponseEntity.timeOut() metoduyla bir zaman aşımı yanıtı döndürür.
  Future<ApiResponse> _handleTimeout<T>(dynamic e) async {
    return ApiResponse.timeout();
  }

  Future<String> getToken() async {
    try {
      var tokenInfo = {
        'grant_type': 'password',
        'username': 'eofApiUser-PlantObjects',
        //'username': 'eofApiUser-MobileObjects',
        'password': 'eofApiUser-321_!*',
      };
      // post("/token", data: tokenInfo);
      final response = await _dio.post(
        "$baseUrl/token",
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        data: tokenInfo,
      );
      if (response.statusCode == 200) {
        return response.data["access_token"];
      } else {
        throw Exception(response.data);
      }
    } on DioException {
      rethrow;
    }
  }
}
