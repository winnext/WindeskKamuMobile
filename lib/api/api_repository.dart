import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win_kamu/api/static_variables.dart';
import 'package:win_kamu/utils/api_urls.dart';
import '../models/detail_response.model.dart';
import '../models/http_response.model.dart';
import '../models/tracingList_response.model.dart';

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

        print('Giriş İşlemi Başarılı');
      } else {
        print(response.data['result']);
      }
      return response.data['result'];
    } on DioError catch (e) {
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  //sayfalama get metodu
//Verilen Sayfalama şeklinde çekilmesini sağlayan servis bağlantısı
//sayfalama get metodu
//Verilen Sayfalama şeklinde çekilmesini sağlayan servis bağlantısı

  Future<tracingListModal> getTracingListWithCount(
      {@required String? controller,
      @required String? xusercode,
      @required String? module,
      bool redirectLogin = false}) async {
    print('url ' + controller!);

    try {
      //ReloadApiBase(StaticVariables.token);
      final response = await dio.get(controller,
          options: Options(
            headers: {"xusercode": xusercode, "xtoken": "ishprod!"},
          ));

      final data = jsonDecode(response.toString());

      print('data + ' + data.toString());

      print(data['lists'] as List);

      if (response != null) {
        return tracingListModal(
          lists: data,
          success: true,
          message: 'Başarılı',
        );
      }
      return tracingListModal(
        lists: data,
        success: false,
        message: 'Hata',
      );
    } on DioError catch (e) {
      if (DioErrorType.other == e.type) {
        return tracingListModal(
          lists: {},
          success: false,
          message: "Bağlantı Hatası",
        );
      }
      if (DioErrorType.response == e.type) {
        if (e.response!.statusCode == 401) {
          return tracingListModal(
            success: false,
            message: "Yetkisiz Erişim",
            lists: {},
          );
        }
        return tracingListModal(
          lists: {},
          success: false,
          message: "İstek hatası",
        );
      }
      if (DioErrorType.connectTimeout == e.type) {
        return tracingListModal(
          lists: {},
          success: false,
          message: "Sistem zaman aşımına uğradı",
        );
      }
      if (DioErrorType.sendTimeout == e.type) {
        return tracingListModal(
          lists: {},
          success: false,
          message: "Sistem zaman aşımına uğradı",
        );
      }
      if (e.response != null) {
        return tracingListModal(
          lists: {},
          success: false,
          message: 'Hata',
        );
      } else {
        //Hata dönüşü
        return tracingListModal(
          lists: {},
          success: false,
          message: e.message,
        );
      }
    }
  }

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
            headers: {"xusercode": "sgnm1027", "xtoken": "ishprod!"},
          ));

      final data = jsonDecode(response.toString());

      print(data['records'] as List);

      if (response != null) {
        return httpSonucModel(
          records: data,
          success: true,
          message: 'Başarılı',
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
          message: "Bağlantı Hatası",
        );
      }
      if (DioErrorType.response == e.type) {
        if (e.response!.statusCode == 401) {
          return httpSonucModel(
            success: false,
            message: "Yetkisiz Erişim",
            records: {},
          );
        }
        return httpSonucModel(
          records: {},
          success: false,
          message: "İstek hatası",
        );
      }
      if (DioErrorType.connectTimeout == e.type) {
        return httpSonucModel(
          records: {},
          success: false,
          message: "Sistem zaman aşımına uğradı",
        );
      }
      if (DioErrorType.sendTimeout == e.type) {
        return httpSonucModel(
          records: {},
          success: false,
          message: "Sistem zaman aşımına uğradı",
        );
      }
      if (e.response != null) {
        return httpSonucModel(
          records: {},
          success: false,
          message: 'Hata',
        );
      } else {
        //Hata dönüşü
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
    print('url DDDDE' + controller!);

    try {
      //ReloadApiBase(StaticVariables.token);
      final response = await dio.get(controller,
          options: Options(
            headers: {"xusercode": 'sgnm1027', "xtoken": "ishprod!"},
          ));

      final data = jsonDecode(response.toString());

      print(data['detail']);

      if (response != null) {
        return detailSonucModel(
          detail: data,
          success: true,
          message: 'Başarılı',
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
          message: "Bağlantı Hatası",
        );
      }
      if (DioErrorType.response == e.type) {
        if (e.response!.statusCode == 401) {
          return detailSonucModel(
            success: false,
            message: "Yetkisiz Erişim",
            detail: {},
          );
        }
        return detailSonucModel(
          detail: {},
          success: false,
          message: "İstek hatası",
        );
      }
      if (DioErrorType.connectTimeout == e.type) {
        return detailSonucModel(
          detail: {},
          success: false,
          message: "Sistem zaman aşımına uğradı",
        );
      }
      if (DioErrorType.sendTimeout == e.type) {
        return detailSonucModel(
          detail: {},
          success: false,
          message: "Sistem zaman aşımına uğradı",
        );
      }
      if (e.response != null) {
        return detailSonucModel(
          detail: {},
          success: false,
          message: 'Hata',
        );
      } else {
        //Hata dönüşü
        return detailSonucModel(
          detail: {},
          success: false,
          message: e.message,
        );
      }
    }
  }

  Future<detailSonucModel> getIssueSummary(
      {@required String? controller,
      @required String? issueCode,
      @required String? xuserCode,
      bool redirectLogin = false}) async {
    print('url DDDDE' + controller!);

    try {
      //ReloadApiBase(StaticVariables.token);
      final response = await dio.get(controller,
          options: Options(
            headers: {"xusercode": 'sgnm1027', "xtoken": "ishprod!"},
          ));

      final data = jsonDecode(response.toString());

      print(data['detail']);

      if (response != null) {
        return detailSonucModel(
          detail: data,
          success: true,
          message: 'Başarılı',
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
          message: "Bağlantı Hatası",
        );
      }
      if (DioErrorType.response == e.type) {
        if (e.response!.statusCode == 401) {
          return detailSonucModel(
            success: false,
            message: "Yetkisiz Erişim",
            detail: {},
          );
        }
        return detailSonucModel(
          detail: {},
          success: false,
          message: "İstek hatası",
        );
      }
      if (DioErrorType.connectTimeout == e.type) {
        return detailSonucModel(
          detail: {},
          success: false,
          message: "Sistem zaman aşımına uğradı",
        );
      }
      if (DioErrorType.sendTimeout == e.type) {
        return detailSonucModel(
          detail: {},
          success: false,
          message: "Sistem zaman aşımına uğradı",
        );
      }
      if (e.response != null) {
        return detailSonucModel(
          detail: {},
          success: false,
          message: 'Hata',
        );
      } else {
        //Hata dönüşü
        return detailSonucModel(
          detail: {},
          success: false,
          message: e.message,
        );
      }
    }
  }

  //   Future<httpSonucModel> getActivitiesDetail(
  //     {@required String? issueCode,
  //     bool redirectLogin = false}) async {

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String deviceToken = prefs.getString('deviceId').toString();

  //   String urlActivities = '${base_url_v1}wdaehtest!_$deviceToken&action=getAvailableActivities&issueCode=${issueCode!}&module=issue';

  //   print('urlActivities ' + urlActivities! );

  //   try {
  //     //ReloadApiBase(StaticVariables.token);
  //     final response = await dio.get(urlActivities);

  //     final data = jsonDecode(response.toString());

  //     print('dataActivities' + data['records'].toString());

  //     if (response != null) {
  //       return httpSonucModel(
  //         records: data,
  //         success: true,
  //         message: 'Başarılı',
  //       );
  //     }
  //     return httpSonucModel(
  //       records: data,
  //       success: false,
  //       message: 'Hata',
  //     );
  //   } on DioError catch (e) {
  //     if (DioErrorType.other == e.type) {
  //       return httpSonucModel(
  //         records: {},
  //         success: false,
  //         message: "Bağlantı Hatası",
  //       );
  //     }
  //     if (DioErrorType.response == e.type) {
  //       if (e.response!.statusCode == 401) {
  //         return httpSonucModel(
  //           success: false,
  //           message: "Yetkisiz Erişim",
  //           records: {},
  //         );
  //       }
  //       return httpSonucModel(
  //         records: {},
  //         success: false,
  //         message: "İstek hatası",
  //       );
  //     }
  //     if (DioErrorType.connectTimeout == e.type) {
  //       return httpSonucModel(
  //         records: {},
  //         success: false,
  //         message: "Sistem zaman aşımına uğradı",
  //       );
  //     }
  //     if (DioErrorType.sendTimeout == e.type) {
  //       return httpSonucModel(
  //         records: {},
  //         success: false,
  //         message: "Sistem zaman aşımına uğradı",
  //       );
  //     }
  //     if (e.response != null) {
  //       return httpSonucModel(
  //         records: {},
  //         success: false,
  //         message: 'Hata',
  //       );
  //     } else {
  //       //Hata dönüşü
  //       return httpSonucModel(
  //         records: {},
  //         success: false,
  //         message: e.message,
  //       );
  //     }
  //   }
  // }

  Future<dynamic> addIssueActivity(
      {@required String? issueCode,
      @required String? userName,
      @required String? activityCode,
      @required String? description}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String url =
        '${base_url_v1}wdaehtest!_${deviceToken}&action=addActivity&issueCode=${issueCode}&username=${userName}&activityCode=${activityCode}&locationCode=&asgGroupCode=&asgUserCode=&additionalTime=&module=issue&from_mobile=1&cardNo=&patientNo=&sampleNo=&description=${description}';

    final response = await dio.post(url);

    print('activity url : ' + url.toString());
    print('activity response : ' + response.toString());

    return response;
  }
}
