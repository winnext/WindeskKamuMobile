import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win_kamu/api/static_variables.dart';
import 'package:win_kamu/utils/api_urls.dart';
import '../models/detail_response.model.dart';
import '../models/http_response.model.dart';

class APIRepository {
  // Platform messages may fail, so we use a try/catch PlatformException.

  Dio dio = new Dio();

  // ReloadApiBase(String tokenValue) async {
  //   dio = Dio(BaseOptions(baseUrl: _baseUrl, headers: {
  //     "Accept": "application/json",
  //     "content-type": "application/json; charset=utf-8",
  //     "X-Requested-With": "XMLHttpRequest",
  //   }));
  //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
  //       (HttpClient dioClient) {
  //     dioClient.badCertificateCallback =
  //         ((X509Certificate cert, String host, int port) => true);

  //     return dioClient;
  //   };
  //   initializeInterceptors(tokenValue);
  // }

  initializeInterceptors(String tokenValue) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, requestInterceptorHandler) {
        String token = tokenValue;
        if (token != "") {
          print("Token:$token");
          options.headers["Authorization"] =
              "Bearer $token"; //Sending token with every request accept login
          options.followRedirects = false;
          return requestInterceptorHandler.next(options);
        } else {
          // ignore: void_checks
          return requestInterceptorHandler.next(options);
        }
      },
      onResponse: (response, responseInterceptorHandler) {
        var map = Map<String, dynamic>.from(response.data);
        if (response.statusCode == 401) {
/*           _dio!.interceptors.requestLock.lock();
          _dio!.interceptors.responseLock.lock(); */
          print(response.statusCode);
        }
        print('onResponse:${response.statusCode}');
        // ${response.statusCode} ${response.data}');
        return responseInterceptorHandler.next(response);
      },
      onError: (error, errorInterceptorHandler) {
        if (error.response != null) {
          print("StatusCode:${error.response!.statusCode}");
        }
        print("Dio onError:${error.message}");
        return errorInterceptorHandler.next(error);
      },
    ));
  }

  Future login(String kadi, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();
    String deviceType = prefs.getString('deviceType').toString();

    String loginUrl = base_url_v1 +
        'wdaehtest!_' +
        deviceToken +
        '' +
        '&action=loginCheck&username=' +
        kadi +
        '&password=' +
        password +
        '&platform=' +
        deviceType +
        '&version=' +
        '3' +
        '&mobileV2=true';
    print(loginUrl);
    var result = '';

    Future.delayed(const Duration(seconds: 2)).whenComplete(() {});

    try {
      Dio dio = Dio();
      final response = await dio.get(loginUrl,
          options: Options(
            responseType: ResponseType.json,
          ));

      if (response.data['result'] == 'success') {
        //print(response.data);
        prefs.setString('prefsUserName', kadi);

        print('Giri?? ????lemi Ba??ar??l??');
      } else {
        print(response.data['result']);
      }
      return response.data['result'];
    } on DioError catch (e) {
      return 'Ba??lant?? Zaman A????m??na U??rad?? L??tfen A????n??z?? Kontrol Ediniz';
    }
  }

  //sayfalama get metodu
//Verilen Sayfalama ??eklinde ??ekilmesini sa??layan servis ba??lant??s??
//sayfalama get metodu
//Verilen Sayfalama ??eklinde ??ekilmesini sa??layan servis ba??lant??s??
  Future<httpSonucModel> getListForPaging(
      {@required String? controller,
      @required Map<String, dynamic>? queryParameters,
      bool redirectLogin = false}) async {
    print('url ' + controller!);

    try {
      //ReloadApiBase(StaticVariables.token);
      final response = await dio.get(controller,
          queryParameters: queryParameters,
          options: Options(
            headers: {"xusercode": "k203736", "xtoken": "aehtest!"},
          ));

      final data = jsonDecode(response.toString());

      print(data['records'] as List);

      if (response != null) {
        return httpSonucModel(
          records: data,
          success: true,
          message: 'Ba??ar??l??',
        );
      }
      return httpSonucModel(
        records: data,
        success: false,
        message: 'Hata',
      );
    } on DioError catch (e) {
      if (DioErrorType.other == e.type) {
        return httpSonucModel(
          records: {},
          success: false,
          message: "Ba??lant?? Hatas??",
        );
      }
      if (DioErrorType.response == e.type) {
        if (e.response!.statusCode == 401) {
          return httpSonucModel(
            success: false,
            message: "Yetkisiz Eri??im",
            records: {},
          );
        }
        return httpSonucModel(
          records: {},
          success: false,
          message: "??stek hatas??",
        );
      }
      if (DioErrorType.connectTimeout == e.type) {
        return httpSonucModel(
          records: {},
          success: false,
          message: "Sistem zaman a????m??na u??rad??",
        );
      }
      if (DioErrorType.sendTimeout == e.type) {
        return httpSonucModel(
          records: {},
          success: false,
          message: "Sistem zaman a????m??na u??rad??",
        );
      }
      if (e.response != null) {
        return httpSonucModel(
          records: {},
          success: false,
          message: 'Hata',
        );
      } else {
        //Hata d??n??????
        return httpSonucModel(
          records: {},
          success: false,
          message: e.message,
        );
      }
    }
  }

  Future<detailSonucModel> getRequestDetail(
      {@required String? controller,
      @required String? issueCode,
      @required String? xuserCode,
      bool redirectLogin = false}) async {
    print('url ' + controller! );

    try {
      //ReloadApiBase(StaticVariables.token);
      final response = await dio.get(controller,
          options: Options(
            headers: {"xusercode": xuserCode, "xtoken": "aehtest!"},
          ));

      final data = jsonDecode(response.toString());

      print(data['detail']);

      if (response != null) {
        return detailSonucModel(
          detail: data,
          success: true,
          message: 'Ba??ar??l??',
        );
      }
      return detailSonucModel(
        detail: data,
        success: false,
        message: 'Hata',
      );
    } on DioError catch (e) {
      if (DioErrorType.other == e.type) {
        return detailSonucModel(
          detail: {},
          success: false,
          message: "Ba??lant?? Hatas??",
        );
      }
      if (DioErrorType.response == e.type) {
        if (e.response!.statusCode == 401) {
          return detailSonucModel(
            success: false,
            message: "Yetkisiz Eri??im",
            detail: {},
          );
        }
        return detailSonucModel(
          detail: {},
          success: false,
          message: "??stek hatas??",
        );
      }
      if (DioErrorType.connectTimeout == e.type) {
        return detailSonucModel(
          detail: {},
          success: false,
          message: "Sistem zaman a????m??na u??rad??",
        );
      }
      if (DioErrorType.sendTimeout == e.type) {
        return detailSonucModel(
          detail: {},
          success: false,
          message: "Sistem zaman a????m??na u??rad??",
        );
      }
      if (e.response != null) {
        return detailSonucModel(
          detail: {},
          success: false,
          message: 'Hata',
        );
      } else {
        //Hata d??n??????
        return detailSonucModel(
          detail: {},
          success: false,
          message: e.message,
        );
      }
    }
  }

  // Future<httpSonucModel> post(
  //     {@required String? controller,
  //     @required dynamic data,
  //     bool redirectLogin = false}) async {
  //   try {
  //     ReloadApiBase(StaticVariables.token);
  //     final response = await dio.post(controller!, data: data);
  //     httpSonucModel result = httpSonucModel.fromJsonData(response.data);

  //     return result;
  //   } on DioError catch (e) {
  //     if (DioErrorType.other == e.type) {
  //       return httpSonucModel(
  //         success: false,
  //         message: "Ba??lant?? Hatas??",
  //       );
  //     }
  //     if (DioErrorType.response == e.type) {
  //       if (e.response!.statusCode == 401) {
  //         return httpSonucModel(
  //           success: false,
  //           message: "Yetkisiz Eri??im",
  //         );
  //       }
  //       return httpSonucModel(
  //         success: false,
  //         message: "??stek hatas??",
  //       );
  //     }
  //     if (DioErrorType.connectTimeout == e.type) {
  //       return httpSonucModel(
  //         success: false,
  //         message: "Sistem zaman a????m??na u??rad??",
  //       );
  //     }
  //     if (DioErrorType.sendTimeout == e.type) {
  //       return httpSonucModel(
  //         success: false,
  //         message: "Sistem zaman a????m??na u??rad??",
  //       );
  //     }
  //     if (e.response != null) {
  //       print('Dio error!');
  //       print('STATUS: ${e.response?.statusCode}');
  //       print('DATA: ${e.response?.data}');
  //       print('HEADERS: ${e.response?.headers}');
  //     } else {
  //       // Error due to setting up or sending the request
  //       print('Error sending request!');
  //       print(e.message);
  //       return httpSonucModel(
  //         success: false,
  //         message: e.message,
  //       );
  //     }
  //     return httpSonucModel(
  //       success: false,
  //       message: e.message,
  //     );
  //   }
  // }
}
