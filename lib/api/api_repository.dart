// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win_kamu/utils/api_urls.dart';
import '../models/detail_response.model.dart';
import '../models/http_response.model.dart';
import '../models/tracingList_response.model.dart';

class APIRepository {
  // Platform messages may fail, so we use a try/catch PlatformException.

  Dio dio = Dio();

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
          options.headers["Authorization"] = "Bearer $token"; //Sending token with every request accept login
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

  Future cikis(String kadi) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String cikis_url = '$base_url_v1$TOKEN_V1$deviceToken&action=logout&username=$kadi';

    try {
      BaseOptions options = BaseOptions(
          baseUrl: cikis_url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 1000, // 60 seconds
          receiveTimeout: 3 * 1000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(cikis_url);
      print(response);
      if (response.data['result'] == 'success') {
        prefs.remove('prefsUserName');
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  Future mahalAraMahalDetayAnlikIsEmri(spaceCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String url =
        '${base_url_v1 + TOKEN_V1 + deviceToken + '&action=getWorkorderFromCode&username=' + kadi.toString() + '&spaceCode=' + spaceCode}&status=~Closed%2C~Cancelled&module=&entityCode=&type=reactive';

    try {
      BaseOptions options = BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(url);
      print('anlik_is_emri');
      print(response);
      if (response.data['result'] == 'success') {
        return response.data['records'];
      } else {
        return false;
      }
    } on DioError catch (e) {
      print('girdi');

      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  Future mahalAraMahalDetayBakimIsEmri(spaceCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String url =
        '${base_url_v1 + TOKEN_V1 + deviceToken + '&action=getWorkorderFromCode&username=' + kadi.toString() + '&spaceCode=' + spaceCode}&status=~Closed%2C~Cancelled&module=submaintenance&entityCode=&type=';

    try {
      BaseOptions options = BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(url);
      print('bakim_is_emri');
      print(response);
      if (response.data['result'] == 'success') {
        return response.data['records'];
      } else {
        return false;
      }
    } on DioError catch (e) {
      print('girdi');

      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  Future mahalAramaMahalDetaySlaApi(spaceCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String url =
        '${base_url_v1 + TOKEN_V1 + deviceToken + '&action=getIssuesFromCode&username=' + kadi.toString() + '&spaceCode=' + spaceCode}&parentStatus=openParentStatus&cmdbCode=';
    try {
      BaseOptions options = BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(url);
      print('object');
      print(response);
      if (response.data['result'] == 'success') {
        return response.data['records'];
      } else {
        return false;
      }
    } on DioError catch (e) {
      print('girdi');
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  Future mahalAramaMahalDetaySummaryApi(spaceCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String url = '$base_url_v1$TOKEN_V1$deviceToken&action=getSpaceDetail&username=$kadi&spaceCode=' + spaceCode;
    try {
      BaseOptions options = BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(url);

      //print(response);
      if (response.data['result'] == 'success') {
        return response.data['detail'];
      } else {
        return false;
      }
    } on DioError catch (e) {
      print('girdi');
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

  Future mahalAraVarlikDetayAnlikIsEmri(entityCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String url =
        '${base_url_v1 + TOKEN_V1 + deviceToken + '&action=getWorkorderFromCode&username=' + kadi.toString() + '&entityCode=' + entityCode}&status=~Closed%2C~Cancelled&module=&spaceCode=&type=reactive';

    try {
      BaseOptions options = BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(url);
      print('Varlık anlik_is_emri');
      print(response);
      if (response.data['result'] == 'success') {
        return response.data['records'];
      } else {
        return false;
      }
    } on DioError catch (e) {
      print('girdi');

      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  Future mahalAraVarlikDetayBakimIsEmri(spaceCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String url =
        '${base_url_v1 + TOKEN_V1 + deviceToken + '&action=getWorkorderFromCode&username=' + kadi.toString() + '&entityCode=' + spaceCode}&status=~Closed%2C~Cancelled&module=submaintenance&spaceCode=&type=';

    try {
      BaseOptions options = BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(url);
      print(' Varlik bakim_is_emri');
      print(response);
      if (response.data['result'] == 'success') {
        return response.data['records'];
      } else {
        return false;
      }
    } on DioError catch (e) {
      print('girdi');

      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  //İŞ EMRİ BUTONLARI İŞLEMLERİ start veya end
  Future woActualDateActions(type, code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String url =
        '$base_url_v1$TOKEN_V1$deviceToken&action=workorderActualDateActions&workorderCode=$code&username=$kadi&type=$type&nfc=0&workorder_wait_reason=&workorder_wait_reasoncode=';

    try {
      BaseOptions options = BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(url);
      print(' İş Emri buton başlat bitir butonları');
      print(response);
      if (response.data['result'] == 'success') {
        return response.data['records'];
      } else {
        return false;
      }
    } on DioError catch (e) {
      print('girdi');

      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  //Add Effort

  Future addEffortApi(code, workPeriod) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String url = base_url_v1 +
        TOKEN_V1 +
        deviceToken +
        '&action=addWorkorderEffort&workordercode=' +
        code.toString() +
        '&username=' +
        kadi.toString() +
        '&module=workorder' +
        '&workperiod=' +
        workPeriod.toString() +
        '&startdate=1&type=PREDICTED&description=test';
    print(code);
    print(url);
    try {
      BaseOptions options = BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(url);
      print(' Efor Ekleme');
      print(response);
      if (response.data['result'] == 'success') {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      print('girdi');

      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  ///Delete Effort

  Future deleteEffortApi(woLogCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String url =
        base_url_v1 + TOKEN_V1 + deviceToken + '&action=deleteWorkorderWorklog&code=' + woLogCode.toString() + '&username=' + kadi.toString();
    print(url);
    try {
      BaseOptions options = new BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(url);
      print(' Efor silme');
      print(response);
      if (response.data['result'] == 'success') {
        return response.data['records'];
      } else {
        return false;
      }
    } on DioError catch (e) {
      print('girdi');

      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  //Eforlar

  Future getWorkOrderWorklogsApi(woCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String url = '$BASE_URL_V2/workorder/$woCode/workloads';

    print('Eforlar listesi url : $url');

    try {
      BaseOptions options = BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 1000, // 60 seconds
          receiveTimeout: 3 * 1000 // 60 seconds
          );
      Dio dio = Dio(options);
      final response = await dio.get(url,
          options: Options(
            headers: {'xusercode': kadi, 'xtoken': TOKEN_V2},
            responseType: ResponseType.json,
          ));
      //print('Eforlar listesi response  : ' + (response.data).toString());
      if (response.data['result'] == 'success') {
        print('girdi');
        return response.data['records'];
      }
    } on DioError catch (e) {
      print('notsuccess');
      print(e);
      return 'notsuccess';
    }
  }

  //Depolar

  Future getStoreApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String url = base_url_v1 + TOKEN_V1 + deviceToken + '&action=getStore&user=' + kadi.toString();
    ;
    print(url);
    try {
      BaseOptions options = new BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(url);
      print(' Depo Listesi');
      print(response);
      if (response.data['result'] == 'success') {
        return response.data['records'];
      } else {
        return false;
      }
    } on DioError catch (e) {
      print('girdi');

      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  //Depolar

  Future getProductsApi(storageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String url = base_url_v1 + TOKEN_V1 + deviceToken + '&action=getProduct&storagecode=' + storageCode.toString();
    print('getProducts url : ' + url);
    try {
      BaseOptions options = new BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(url);
      print(' Depo Listesi');
      print(response);
      if (response.data['result'] == 'success') {
        return response.data['records'];
      } else {
        return false;
      }
    } on DioError catch (e) {
      print('girdi');

      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  //Birim

  Future getPackageInfoByProduct(productDefCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String url = base_url_v1 + TOKEN_V1 + deviceToken + '&action=getPackageInfoByProduct&productDefCode=' + productDefCode.toString();
    ;
    print(url);
    try {
      BaseOptions options = new BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(url);
      print(' Depo Listesi');
      print(response);
      if (response.data['result'] == 'success') {
        return response.data['records'];
      } else {
        return false;
      }
    } on DioError catch (e) {
      print('girdi');

      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  Future mahalAramaVarlikDetaySlaApi(cmdbCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String url =
        '${base_url_v1 + TOKEN_V1 + deviceToken + '&action=getIssuesFromCode&username=' + kadi.toString() + '&cmdbCode=' + cmdbCode}&parentStatus=openParentStatus&spaceCode=';
    try {
      BaseOptions options = BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(url);
      print('varlik detay sla ');
      print(response);
      if (response.data['result'] == 'success') {
        return response.data['records'];
      } else {
        return false;
      }
    } on DioError catch (e) {
      print('girdi');
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  Future mahalAramaVarlikDetaySummaryApi(case_no) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String url = '$base_url_v1$TOKEN_V1$deviceToken&action=getEntityDetail&username=$kadi&case_no=' + case_no;
    try {
      BaseOptions options = BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(url);
      print('varlik detay summary ');
      print(response);
      if (response.data['result'] == 'success') {
        return response.data['detail'];
      } else {
        return false;
      }
    } on DioError catch (e) {
      print('girdi');
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  Future varlikAramaListesiApi(entity_code, locCode, seriNo, rfid, typeCode, brandCode, modelCode, data_sayisi, sayfa) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    int limitStart = data_sayisi * (sayfa - 1);
    int limitEnd = data_sayisi * sayfa;

    String varlikAramaListesiUrl =
        '$base_url_v1$TOKEN_V1$deviceToken&action=getEntity&username=$kadi&case_no=$entity_code&serino=$seriNo&rfid=$rfid&serviceCode=&typeCode=$typeCode&defnCode=&brand=$brandCode&model=$modelCode&mahalno=$locCode&limitStart=$limitStart&limitEnd=$limitEnd';

    print(varlikAramaListesiUrl);

    try {
      BaseOptions options = BaseOptions(
          baseUrl: varlikAramaListesiUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(varlikAramaListesiUrl);

      //print(response);
      if (response.data['result'] == 'success') {
        return response.data['records'];
      } else {
        return [];
      }
    } on DioError catch (e) {
      print('girdi');
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  Future mahalAramaListesiApi(
    mahalKodu,
    mahalAdi,
    binaKodu,
    katKodu,
    kanatKodu,
    sinifKodu,
    grupKodu,
    data_sayisi,
    sayfa,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    int limitStart = data_sayisi * (sayfa - 1);
    int limitEnd = data_sayisi * sayfa;

    String mahalAramaListesiUrl =
        '$base_url_v1$TOKEN_V1$deviceToken&action=getSpace&username=$kadi&spaceCode=$mahalKodu&spaceName=$mahalAdi&buildingCode=$binaKodu&floorCode=$katKodu&blockCode=$kanatKodu&spaceClass=$sinifKodu&groupNo=$grupKodu&limitStart=$limitStart&limitEnd=$limitEnd';

    try {
      BaseOptions options = BaseOptions(
          baseUrl: mahalAramaListesiUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(mahalAramaListesiUrl);

      //print(response);
      if (response.data['result'] == 'success') {
        return response.data['records'];
      } else {
        return [];
      }
      //print(response);
    } on DioError catch (e) {
      print('girdi');
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  Future mahalAramaKampus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String mahalAramaKampusUrl = '$base_url_v1$TOKEN_V1$deviceToken&action=getBuildings';

    try {
      BaseOptions options = BaseOptions(
          baseUrl: mahalAramaKampusUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 1000, // 60 seconds
          receiveTimeout: 3 * 1000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(mahalAramaKampusUrl);
      print(response.data['records']);
      if (response.data['result'] == 'success') {
        return response.data['records'];
      } else {
        return false;
      }
    } on DioError catch (e) {
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  Future mahalAramaBina(String buildingCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String mahalAramaBinaUrl = '$base_url_v1$TOKEN_V1$deviceToken&action=getFloors&buildingCode=$buildingCode';

    try {
      BaseOptions options = BaseOptions(
          baseUrl: mahalAramaBinaUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 1000, // 60 seconds
          receiveTimeout: 3 * 1000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(mahalAramaBinaUrl);
      //print(response.data['records'][0]);∂
      if (response.data['result'] == 'success') {
        return response.data['records'];
      } else {
        return false;
      }
    } on DioError catch (e) {
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  Future mahalAramaKat(String floorCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String mahalAramaBinaUrl = '$base_url_v1$TOKEN_V1$deviceToken&action=getBlocks&floorCode=$floorCode';

    try {
      BaseOptions options = BaseOptions(
          baseUrl: mahalAramaBinaUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 1000, // 60 seconds
          receiveTimeout: 3 * 1000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(mahalAramaBinaUrl);
      //print(response.data['records']);
      if (response.data['result'] == 'success') {
        return response.data['records'];
      } else {
        return false;
      }
    } on DioError catch (e) {
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  Future mahalAramaKanat(String blockCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String mahalAramaBinaUrl = '$base_url_v1$TOKEN_V1$deviceToken&action=getSpaces&blockCode=$blockCode';

    try {
      BaseOptions options = BaseOptions(
          baseUrl: mahalAramaBinaUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 1000, // 60 seconds
          receiveTimeout: 3 * 1000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(mahalAramaBinaUrl);
      if (response.data['result'] == 'success') {
        return response.data['records'];
      } else {
        return false;
      }
    } on DioError catch (e) {
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  Future mahalAramaGrup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String mahalAramaGrupUrl = '$base_url_v1$TOKEN_V1$deviceToken&action=getGroups';

    try {
      BaseOptions options = BaseOptions(
          baseUrl: mahalAramaGrupUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 1000, // 60 seconds
          receiveTimeout: 3 * 1000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(mahalAramaGrupUrl);

      if (response.data['result'] == 'success') {
        //print(response.data['records']);
        return response.data['records'];
      } else {
        return false;
      }
    } on DioError catch (e) {
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  Future woCreate(woSpace, woService, woName, woNameLabel, priority_type, workorder_cfg, woDesc, image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String woCreateUrl =
        '${base_url_v1 + TOKEN_V1 + deviceToken + '&action=saveWorkorderNfs&workorder_type=' + woName + '&workorder_name=' + woNameLabel + '&workorder_service=' + woService + '&workorder_space=' + woSpace + '&workorder_description=' + woDesc + '&workorder_priority_type=' + priority_type}&workorder_cfg=' +
            workorder_cfg;

    print(woCreateUrl);

    try {
      BaseOptions options = BaseOptions(
          baseUrl: woCreateUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(woCreateUrl);

      print(response);
      if (response.data['success'] == true) {
        if (image.length > 0) {
          woCreateFotoEkle(response.data['code'], image);
        }
        return [
          [1],
          response.data
        ];
      } else {
        return [
          [0],
          response.data['uyari']
        ];
      }
    } on DioError catch (e) {
      print('girdi');
      return [
        [0],
        'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz'
      ];
    }
  }

  Future woCreateFotoEkle(woCode, image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String url = '$base_url_v1$TOKEN_V1$deviceToken&action=addAttachment&username=$kadi&moduleName=workorder&issueCode=' + woCode;
    print('Foto ekle url : $url');
    FormData formData = FormData.fromMap({"base64string": image});
    try {
      BaseOptions options = BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 1000, // 60 seconds
          receiveTimeout: 3 * 1000 // 60 seconds
          );
      Dio dio = Dio(options);
      final response = await dio.post(
        url,
        data: formData,
      );
      print('Foto ekle response  : ${response.data}');

      return response.data;
    } on DioError catch (e) {
      print('notsuccess');
      print(e);
      return 'notsuccess';
    }
  }

  Future woCreateHizmetListesiApi(usercode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String woCreateHizmetListesiUrl = '$base_url_v1$TOKEN_V1$deviceToken&action=getServices&username=$kadi';

    print(woCreateHizmetListesiUrl);

    try {
      BaseOptions options = BaseOptions(
          baseUrl: woCreateHizmetListesiUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(woCreateHizmetListesiUrl);

      //print(response);
      if (response.data['result'] == 'success') {
        return response.data['records'];
      } else {
        return [];
      }
    } on DioError catch (e) {
      print('girdi');
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  Future checkWorkorderByAuthorizedServicesApi(String kadi, String woCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String? kadi = prefs.getString('prefsUserName');

    String checkSonucUrl = '$base_url_v1$TOKEN_V1$deviceToken&action=checkWorkorderByAuthorizedServices&workorderCode=$woCode&username=$kadi';

    print(checkSonucUrl);

    try {
      BaseOptions options = BaseOptions(
          baseUrl: checkSonucUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 2000, // 60 seconds
          receiveTimeout: 3 * 2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(checkSonucUrl);

      print(response);
      if (response.data['result'] == 'success') {
        return response.data['count'].toString();
      } else {
        print('else');
        if (response.data['result'] == "Invalid Device Id") {
          return "Invalid Device Id";
        } else {
          return response.data['count'].toString();
        }

        print(response);
        if (response.data['result'] == 'success') {
          return response.data['count'].toString();
        } else {
          return response.data['count'].toString();
        }
      }
    } on DioError catch (e) {
      print('girdi');
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  Future login(String kadi, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();
    String deviceType = prefs.getString('deviceType').toString();
    print(deviceType);
    String loginUrl =
        '$base_url_v1$TOKEN_V1$deviceToken&action=loginCheck&username=$kadi&password=$password&platform=$deviceType&version=3&mobileV2=true';
    print('loginUrl : ');
    print(loginUrl);
    var result = '';

    Future.delayed(const Duration(seconds: 2)).whenComplete(() {});

    try {
      BaseOptions options = BaseOptions(
          baseUrl: loginUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 5 * 1000, // 60 seconds
          receiveTimeout: 5 * 1000 // 60 seconds
          );
      Dio dio = Dio(options);
      final response = await dio.get(loginUrl,
          options: Options(
            responseType: ResponseType.json,
          ));

      if (response.data['result'] == 'success') {
        //print(response.data);
        prefs.setString('prefsUserName', kadi);

        print('Giriş İşlemi Başarılı');

        var platform = deviceType == 'iOS' ? 'ios' : 'android';
        var action = platform == 'ios' ? 'addIOSToken' : 'addFireBaseToken';
        String token = prefs.getString('fbtoken').toString();

        String sendTokenUrl = '$base_url_v1$TOKEN_V1$deviceToken&username=$kadi&platform=$platform&action=$action&firebasetoken=$token';
        print('Send Token Url : $sendTokenUrl');
        final responseTokenUrl = await dio.get(sendTokenUrl,
            options: Options(
              responseType: ResponseType.json,
            ));

        if (responseTokenUrl.data['result'] == 'success') {
          print('Firebase Token kaydedildi');
        } else {
          print('Firebase Token kaydedilmedi');
        }
      } else {
        print(response.data['result']);
      }
      return response.data['result'];
    } on DioError catch (e) {
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';
    }
  }

  Future getServerTime(xusercode, navigation) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String getServerTimeURL = '$base_url_v1$TOKEN_V1$deviceToken&action=getDateTime';
    print(getServerTimeURL);
    try {
      BaseOptions options = BaseOptions(
          baseUrl: getServerTimeURL,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 1000, // 60 seconds
          receiveTimeout: 3 * 1000 // 60 seconds
          );

      Dio dio = Dio(options);
      final getServerTimeResponse = await dio.get(getServerTimeURL, options: Options());

      print(getServerTimeResponse);
      if (getServerTimeResponse.statusCode == 200) {
        var tarih = getServerTimeResponse.data['records']; //20230418155418
        var donus = getServerTimeResponse.data['result'];
        print('donus : ');
        print(donus);
        print('Tarih : ');
        print(tarih);
        if (tarih != null) {
          var yil = tarih[0].toString() + tarih[1].toString() + tarih[2].toString() + tarih[3].toString();
          var ay = tarih[4].toString() + tarih[5].toString();
          var gun = tarih[6].toString() + tarih[7].toString();

          var saat = tarih[8].toString() + tarih[9].toString();
          var dakika = tarih[10].toString() + tarih[11].toString();
          var saniye = tarih[12].toString() + tarih[13].toString();

          var duzenlenmis_tarih = '$gun/$ay/$yil $saat:$dakika:$saniye';

          return duzenlenmis_tarih;
        } else {
          return donus;
        }
      } else {
        return '';
      }
    } on DioError catch (e) {
      print('DIO ERROR CATCH');
      print(e);
      return '';
    }
  }

  Future accessTest1() async {
    String url = ATTACHPATHLIVE + '?&timestamp=' + (DateTime.now().millisecondsSinceEpoch).toString();

    try {
      BaseOptions options = BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 1000, // 60 seconds
          receiveTimeout: 3 * 1000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(url, options: Options());
      print('Access Test v1  : ${response.statusCode}');
      if (response.statusCode == 200) {
        return 'success';
      } else {
        return 'notsuccess';
      }
    } on DioError catch (e) {
      print('notsuccess');
      return 'notsuccess';
    }
  }

  Future accessTest2(String kadi) async {
    String url = '$BASE_URL_V2/workorder/reactive';

    try {
      BaseOptions options = new BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3 * 100, // 60 seconds
          receiveTimeout: 3 * 100 // 60 seconds
          );
      Dio dio = Dio(options);
      final response = await dio.get(url,
          options: Options(
            headers: {'xusercode': kadi, 'xtoken': TOKEN_V2},
            responseType: ResponseType.json,
          ));
      print('Access Test v2  : ${response.data['result']}');

      return response.data['result'];
    } on DioError catch (e) {
      print('notsuccess');
      return 'notsuccess';
    }
  }

  //sayfalama get metodu
//Verilen Sayfalama şeklinde çekilmesini sağlayan servis bağlantısı
  //sayfalama get metodu
//Verilen Sayfalama şeklinde çekilmesini sağlayan servis bağlantısı

  Future<tracingListModal> getTracingListWithCount(
      {@required String? controller, @required String? xusercode, @required String? module, bool redirectLogin = false}) async {
    print('url ${controller!}');

    try {
      //ReloadApiBase(StaticVariables.token);
      final response = await dio.get(controller,
          options: Options(
            headers: {"xusercode": xusercode, "xtoken": TOKEN_V2},
          ));

      final data = jsonDecode(response.toString());

      print('data + $data');

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

  Future<httpSonucModel> getIssueActivities(
      {@required String? controller, @required String? xusercode, @required String? issuecode, bool redirectLogin = false}) async {
    print('dataActivitiesUrl ${controller!} ::: $issuecode');

    try {
      final response = await dio.get(controller,
          options: Options(
            headers: {"xusercode": xusercode, "xtoken": TOKEN_V2},
          ));

      final data = jsonDecode(response.toString());

      print('dataActivities + $data');

      //print(data['records'] as List);

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

  Future<httpSonucModel> getIssueNotes({@required String? controller, bool redirectLogin = false}) async {
    print(controller.toString());

    try {
      final response = await dio.get(controller.toString());

      final data = jsonDecode(response.toString());

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

  Future<httpSonucModel> getIssueOperations({@required String? controller, @required String? xusercode, bool redirectLogin = false}) async {
    try {
      final response = await dio.get(controller.toString(),
          options: Options(
            headers: {"xusercode": xusercode, "xtoken": TOKEN_V2},
          ));

      final data = jsonDecode(response.toString());

      print('dataActivities + $data');

      //print(data['records'] as List);

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

  Future<httpSonucModel> getIssueOpenStatusCodes({@required String? controller, bool redirectLogin = false}) async {
    try {
      final response = await dio.get(controller.toString());

      final data = jsonDecode(response.toString());

      //print(data['records'] as List);

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

  Future<httpSonucModel> getSpaceBfwByType({@required String? controller, bool redirectLogin = false}) async {
    try {
      final response = await dio.get(controller.toString());

      final data = jsonDecode(response.toString());

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

  Future<httpSonucModel> getIssueAttachments(
      {@required String? controller, @required String? xusercode, @required String? issuecode, bool redirectLogin = false}) async {
    print('dataActivitiesUrl ${controller!} ::: $issuecode');

    try {
      final response = await dio.get(controller,
          options: Options(
            headers: {"xusercode": xusercode, "xtoken": TOKEN_V2},
          ));

      final data = jsonDecode(response.toString());

      print('dataAtttachments + $data');

      //print(data['records'] as List);

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

  Future<httpSonucModel> getListForPaging(
      {@required String? controller, @required Map<String, dynamic>? queryParameters, bool redirectLogin = false}) async {
    print('url ' + controller! + ' :  :  ' + queryParameters.toString());

    try {
      //ReloadApiBase(StaticVariables.token);
      final response = await dio.get(controller,
          queryParameters: queryParameters,
          options: Options(
            headers: {"xusercode": "sgnm1040", "xtoken": TOKEN_V2},
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
      {@required String? controller, @required String? issueCode, @required String? xuserCode, bool redirectLogin = false}) async {
    print('url DDDDE${controller!}');

    try {
      //ReloadApiBase(StaticVariables.token);
      final response = await dio.get(controller,
          options: Options(
            headers: {"xusercode": 'sgnm1040', "xtoken": TOKEN_V2},
          ));

      final data = jsonDecode(response.toString());

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
      {@required String? controller, @required String? issueCode, @required String? xuserCode, bool redirectLogin = false}) async {
    print('url DDDDE${controller!}');

    try {
      //ReloadApiBase(StaticVariables.token);
      final response = await dio.get(controller,
          options: Options(
            headers: {"xusercode": 'sgnm1040', "xtoken": TOKEN_V2},
          ));

      final data = jsonDecode(response.toString());

      print('kkkkkkkk2  :  $data');

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

  Future<httpSonucModel> getAvailableActivities({@required String? controller, bool redirectLogin = false}) async {
    try {
      //ReloadApiBase(StaticVariables.token);
      final response = await dio.get(controller.toString());

      final data = jsonDecode(response.toString());

      print('dataActivities${data['records']}');

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

  Future<dynamic> addIssueActivity(
      {@required String? issueCode, @required String? userName, @required String? activityCode, @required String? description}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();

    String url =
        '${base_url_v1}wdaehtest!_$deviceToken&action=addActivity&issueCode=$issueCode&username=$userName&activityCode=$activityCode&locationCode=&asgGroupCode=&asgUserCode=&additionalTime=&module=issue&from_mobile=1&cardNo=&patientNo=&sampleNo=&description=$description';

    final response = await dio.post(url);

    return response;
  }

  Future<httpSonucModel> takeOverIssue({@required String? controller, bool redirectLogin = false}) async {
    print('url ${controller!}');

    try {
      //ReloadApiBase(StaticVariables.token);
      final response = await dio.get(controller);

      final data = jsonDecode(response.toString());

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

  Future<httpSonucModel> createSparepartIssue({@required String? controller, bool redirectLogin = false}) async {
    print('resultSpareparturl ${controller!}');

    try {
      //ReloadApiBase(StaticVariables.token);
      final response = await dio.get(controller);

      final data = jsonDecode(response.toString());

      print('resultSparepart' + ' : ' + data.toString());

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

  Future<httpSonucModel> cancelIssuePlanned({@required String? controller, bool redirectLogin = false}) async {
    print('url ${controller!}');

    try {
      //ReloadApiBase(StaticVariables.token);
      final response = await dio.get(controller);

      final data = jsonDecode(response.toString());

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

  Future<httpSonucModel> getLiveSelectAsgGroups({@required String? controller, bool redirectLogin = false}) async {
    print('dataASGurl ${controller!}');

    try {
      final response = await dio.get(controller);

      final data = jsonDecode(response.toString());

      print(data.toString());

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

  Future<httpSonucModel> getLiveSelectAsgUser({@required String? controller, bool redirectLogin = false}) async {
    print('dataASGurlUSERs ${controller!}');

    try {
      final response = await dio.get(controller);

      final data = jsonDecode(response.toString());

      print(data.toString());

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

  Future<httpSonucModel> changeCfg({@required String? controller, bool redirectLogin = false}) async {
    print('url ${controller!}');

    try {
      final response = await dio.get(controller);

      final data = jsonDecode(response.toString());

      print('dataCCC$data');

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

  Future<httpSonucModel> addActivity(
      {@required String? controller, @required String? description, @required String? image, bool redirectLogin = false}) async {
    print('url ${controller!}');

    try {
      final response = await dio.post(
        controller,
        data: {'description': description, 'base64string': image},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      print('addActivity$response');

      final data = jsonDecode(response.toString());

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
      print('photoAdError$e');
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

  Future<httpSonucModel> addAttachment(
      {@required String? controller, @required String? description, @required String? image, bool redirectLogin = false}) async {
    print('url ${controller!}');

    try {
      final response = await dio.post(
        controller,
        data: {'description': description, 'base64string': image},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      print('photoAdressAct$response  : $description   : $image');

      final data = jsonDecode(response.toString());

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

  Future<httpSonucModel> getListWorkOrders(
      {@required String? controller, @required Map<String, dynamic>? queryParameters, bool redirectLogin = false}) async {
    try {
      //ReloadApiBase(StaticVariables.token);
      final response = await dio.get(controller!,
          queryParameters: queryParameters,
          options: Options(
            headers: {"xusercode": "sgnm1040", "xtoken": TOKEN_V2},
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

  Future<httpSonucModel> woGetRelatedSpace({@required String? controller, @required String? xuserCode, bool redirectLogin = false}) async {
    try {
      //ReloadApiBase(StaticVariables.token);
      final response = await dio.get(controller!,
          options: Options(
            headers: {"xusercode": xuserCode, "xtoken": TOKEN_V2},
          ));
      print('woRele$controller');
      final data = jsonDecode(response.toString());

      print('woReleatedddddd${data['records']}');

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

  Future<httpSonucModel> getAnnouncements({@required String? controller, bool redirectLogin = false}) async {
    try {
      final response = await dio.get(controller.toString());

      final data = jsonDecode(response.toString());

      print('getAnnouncements + $data : $controller');

      //print(data['records'] as List);

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
}
