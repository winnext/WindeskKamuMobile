import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win_kamu/api/static_variables.dart';
import 'package:win_kamu/pages/searchPage/mahalArama.dart';
import 'package:win_kamu/utils/api_urls.dart';
import 'package:win_kamu/utils/global_utils.dart';
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

  Future cikis(String kadi ) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();


    String cikis_url = base_url_v1+'wddemo!_' +
        deviceToken +'&action=logout&username='+kadi;

        print(cikis_url);

    try {
            BaseOptions options = new BaseOptions(
          baseUrl: cikis_url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3*1000, // 60 seconds
          receiveTimeout: 3*1000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(cikis_url);
          print(response);
          if (response.data['result'] == 'success') {
            prefs.remove('prefsUserName');
            return true;
          }else{
            return false;

          }

      

    }on DioError catch (e){
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';

    }

  }

  Future mahalAraMahalDetayBakimIsEmri(spaceCode) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String deviceToken = prefs.getString('deviceId').toString();

          String? kadi = prefs.getString('prefsUserName'); 

          String url = base_url_v1 + 'wddemo!_'+
          deviceToken+'&action=getWorkorderFromCode&username='+
          kadi.toString()+
          '&spaceCode='+ spaceCode+
          '&status='+ '~Closed%2C~Cancelled'+
          '&module='+ 'submaintenance' +
          '&entityCode=&type='+ '';

           try {
            BaseOptions options = new BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3*2000, // 60 seconds
          receiveTimeout: 3*2000 // 60 seconds
          );

            Dio dio = Dio(options);
            final response = await dio.get(url);
                print('bakim_is_emri');
                print(response);
                if (response.data['result'] == 'success') {
                              return response.data['records'];
                }else{
                  return false;

                }

            

          }on DioError catch (e){
            print('girdi');
            return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';

          }




  }


  Future mahalAramaMahalDetaySlaApi(spaceCode) async{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String deviceToken = prefs.getString('deviceId').toString();

          String? kadi = prefs.getString('prefsUserName'); 

             String url = base_url_v1 + 'wddemo!_'+
          deviceToken+'&action=getIssuesFromCode&username='+kadi.toString()+'&spaceCode='+spaceCode+
          '&parentStatus=openParentStatus&cmdbCode=';
            try {
            BaseOptions options = new BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3*2000, // 60 seconds
          receiveTimeout: 3*2000 // 60 seconds
          );

            Dio dio = Dio(options);
            final response = await dio.get(url);
                print('object');
                print(response);
                if (response.data['result'] == 'success') {
                              return response.data['records'];
                }else{
                  return false;

                }

            

          }on DioError catch (e){
            print('girdi');
            return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';

          }

  }

  Future mahalAramaMahalDetaySummaryApi(spaceCode)async{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String deviceToken = prefs.getString('deviceId').toString();

          String? kadi = prefs.getString('prefsUserName'); 

          String url = base_url_v1 + 'wddemo!_'+
          deviceToken+'&action=getSpaceDetail&username='+kadi.toString()+'&spaceCode='+spaceCode;
            try {
            BaseOptions options = new BaseOptions(
          baseUrl: url,
          receiveDataWhenStatusError: true,
          connectTimeout: 3*2000, // 60 seconds
          receiveTimeout: 3*2000 // 60 seconds
          );

            Dio dio = Dio(options);
            final response = await dio.get(url);
            
                //print(response);
                if (response.data['result'] == 'success') {
                              return response.data['detail'];
                }else{
                  return false;

                }

            

          }on DioError catch (e){
            print('girdi');
            return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';

          }

  }

    Future mahalAramaListesiApi(mahalKodu, mahalAdi, binaKodu, katKodu, kanatKodu, sinifKodu, grupKodu, data_sayisi, sayfa ) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String deviceToken = prefs.getString('deviceId').toString();

          String? kadi = prefs.getString('prefsUserName'); 

          int limitStart = data_sayisi * (sayfa-1) ;
          int limitEnd =  data_sayisi * sayfa;

          String mahalAramaListesiUrl = base_url_v1+'wddemo!_' +
        deviceToken +'&action=getSpace&username='+kadi.toString()+
        '&spaceCode='+mahalKodu.toString()+
        '&spaceName='+mahalAdi.toString()+
        '&buildingCode='+binaKodu.toString()+
        '&floorCode='+katKodu.toString()+
        '&blockCode='+kanatKodu.toString()+
        '&spaceClass='+sinifKodu.toString()+
        '&groupNo='+grupKodu.toString()+
        '&limitStart='+ limitStart.toString()+
        '&limitEnd='+ limitEnd.toString();

        print(mahalAramaListesiUrl);


            try {
            BaseOptions options = new BaseOptions(
          baseUrl: mahalAramaListesiUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 3*2000, // 60 seconds
          receiveTimeout: 3*2000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(mahalAramaListesiUrl);
      
          //print(response);
          if (response.data['result'] == 'success') {
                        return response.data['records'];
          }else{
            return false;

          }

      

    }on DioError catch (e){
      print('girdi');
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';

    }



    }

    Future mahalAramaKampus( ) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();


    String mahalAramaKampusUrl= base_url_v1+'wddemo!_' +
        deviceToken +'&action=getBuildings';

    try {
            BaseOptions options = new BaseOptions(
          baseUrl: mahalAramaKampusUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 3*1000, // 60 seconds
          receiveTimeout: 3*1000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(mahalAramaKampusUrl);
          print(response.data['records']);
          if (response.data['result'] == 'success') {
                        return response.data['records'];
          }else{
            return false;

          }

      

    }on DioError catch (e){
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';

    }

  }

   Future mahalAramaBina(String buildingCode ) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();


    String mahalAramaBinaUrl= base_url_v1+'wddemo!_' +
        deviceToken +'&action=getFloors&buildingCode='+buildingCode;

    try {
            BaseOptions options = new BaseOptions(
          baseUrl: mahalAramaBinaUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 3*1000, // 60 seconds
          receiveTimeout: 3*1000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(mahalAramaBinaUrl);
          //print(response.data['records'][0]);∂
          if (response.data['result'] == 'success') {
                        return response.data['records'];
          }else{
            return false;

          }

      

    }on DioError catch (e){
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';

    }

  }


  Future mahalAramaKat(String floorCode ) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();


    String mahalAramaBinaUrl= base_url_v1+'wddemo!_' +
        deviceToken +'&action=getBlocks&floorCode='+floorCode;

    try {
            BaseOptions options = new BaseOptions(
          baseUrl: mahalAramaBinaUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 3*1000, // 60 seconds
          receiveTimeout: 3*1000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(mahalAramaBinaUrl);
          //print(response.data['records']);
          if (response.data['result'] == 'success') {
                        return response.data['records'];
          }else{
            return false;

          }

      

    }on DioError catch (e){
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';

    }

  }


  Future mahalAramaKanat(String blockCode ) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();


    String mahalAramaBinaUrl= base_url_v1+'wddemo!_' +
        deviceToken +'&action=getSpaces&blockCode='+blockCode;

    try {
            BaseOptions options = new BaseOptions(
          baseUrl: mahalAramaBinaUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 3*1000, // 60 seconds
          receiveTimeout: 3*1000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(mahalAramaBinaUrl);
          if (response.data['result'] == 'success') {
                        return response.data['records'];
          }else{
            return false;

          }

      

    }on DioError catch (e){
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';

    }

  }


   Future mahalAramaGrup() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();


    String mahalAramaGrupUrl= base_url_v1+'wddemo!_' +
        deviceToken +'&action=getGroups';

    try {
            BaseOptions options = new BaseOptions(
          baseUrl: mahalAramaGrupUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 3*1000, // 60 seconds
          receiveTimeout: 3*1000 // 60 seconds
          );

      Dio dio = Dio(options);
      final response = await dio.get(mahalAramaGrupUrl);

          if (response.data['result'] == 'success') {
                  //print(response.data['records']);
                        return response.data['records'];
          }else{
            return false;

          }

      

    }on DioError catch (e){
      return 'Bağlantı Zaman Aşımına Uğradı Lütfen Ağınızı Kontrol Ediniz';

    }

  }





  Future login(String kadi, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceToken = prefs.getString('deviceId').toString();
    String deviceType = prefs.getString('deviceType').toString();
    print(deviceType);
    String loginUrl = base_url_v1 +
        TOKEN_V1 +
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
    print('loginUrl : ');
    print(loginUrl);
    var result = '';

    Future.delayed(const Duration(seconds: 2)).whenComplete(() {});

    try {
      BaseOptions options = new BaseOptions(
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

        String sendTokenUrl = base_url_v1 +
            'wddemo!_' +
            deviceToken +
            '&username=' +
            kadi +
            '&platform=' +
            platform +
            '&action=' +
            action +
            '&firebasetoken=' +
            token;
        print('Send Token Url : '+sendTokenUrl);
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

    String getServerTimeURL =
        base_url_v1 + 'wddemo!_' + deviceToken + '&action=getDateTime';
    print(getServerTimeURL);
    try {
      Dio dio = Dio();
      final getServerTimeResponse =
          await dio.get(getServerTimeURL, options: Options());

      print(getServerTimeResponse);
      if (getServerTimeResponse.statusCode == 200) {
        var tarih = getServerTimeResponse.data['records']; //20230418155418
        var yil = tarih[0].toString() +
            tarih[1].toString() +
            tarih[2].toString() +
            tarih[3].toString();
        var ay = tarih[4].toString() + tarih[5].toString();
        var gun = tarih[6].toString() + tarih[7].toString();

        var saat = tarih[8].toString() + tarih[9].toString();
        var dakika = tarih[10].toString() + tarih[11].toString();
        var saniye = tarih[12].toString() + tarih[13].toString();

        var duzenlenmis_tarih = '$gun/$ay/$yil $saat:$dakika:$saniye';

        return duzenlenmis_tarih;
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  Future accessTest1() async {
    String url = attachpath +
        '?&timestamp=' +
        (DateTime.now().millisecondsSinceEpoch).toString();

    try {
      Dio dio = Dio();
      final response = await dio.get(url, options: Options());
      print('Access Test v1  : ' + (response.statusCode).toString());
      if (response.statusCode == 200) {
        return 'success';
      } else {
        return 'notsuccess';
      }
    } on DioError catch (e) {
      return 'notsuccess';
    }
  }

  Future accessTest2(String kadi) async {
    String url = BASE_URL_V2 + '/workorder/reactive';

    try {
      Dio dio = Dio();
      final response = await dio.get(url,
          options: Options(
            headers: {'xusercode': kadi, 'xtoken': TOKEN_V2},
            responseType: ResponseType.json,
          ));
      print('Access Test v2  : ' + (response.data['result']).toString());

      return response.data['result'];
    } on DioError catch (e) {
      return 'notsuccess';
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
            headers: {"xusercode": xusercode, "xtoken": TOKEN_V2},
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

  Future<httpSonucModel> getIssueActivities(
      {@required String? controller,
      @required String? xusercode,
      @required String? issuecode,
      bool redirectLogin = false}) async {
    print('dataActivitiesUrl ' + controller! + ' ::: ' + issuecode.toString());

    try {
      final response = await dio.get(controller,
          options: Options(
            headers: {"xusercode": xusercode, "xtoken": TOKEN_V2},
          ));

      final data = jsonDecode(response.toString());

      print('dataActivities + ' + data.toString());

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

  Future<httpSonucModel> getIssueOperations(
      {@required String? controller,
      @required String? xusercode,
      bool redirectLogin = false}) async {
    try {
      final response = await dio.get(controller.toString(),
          options: Options(
            headers: {"xusercode": xusercode, "xtoken": TOKEN_V2},
          ));

      final data = jsonDecode(response.toString());

      print('dataActivities + ' + data.toString());

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

  Future<httpSonucModel> getIssueOpenStatusCodes(
      {@required String? controller, bool redirectLogin = false}) async {
    try {
      final response = await dio.get(controller.toString());

      final data = jsonDecode(response.toString());

      print('getIssueOpenStatusCodes + ' +
          data.toString() +
          '  :  ' +
          controller.toString());

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

  Future<httpSonucModel> getSpaceBfwByType(
      {@required String? controller, bool redirectLogin = false}) async {
    try {
      final response = await dio.get(controller.toString());

      final data = jsonDecode(response.toString());

      print('getSpaceBfwByType + ' + data.toString());

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

  Future<httpSonucModel> getIssueAttachments(
      {@required String? controller,
      @required String? xusercode,
      @required String? issuecode,
      bool redirectLogin = false}) async {
    print('dataActivitiesUrl ' + controller! + ' ::: ' + issuecode.toString());

    try {
      final response = await dio.get(controller,
          options: Options(
            headers: {"xusercode": xusercode, "xtoken": TOKEN_V2},
          ));

      final data = jsonDecode(response.toString());

      print('dataAtttachments + ' + data.toString());

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
      {@required String? controller,
      @required Map<String, dynamic>? queryParameters,
      bool redirectLogin = false}) async {
    print('url ' + controller!);

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
      {@required String? controller,
      @required String? issueCode,
      @required String? xuserCode,
      bool redirectLogin = false}) async {
    print('url DDDDE' + controller!);

    try {
      //ReloadApiBase(StaticVariables.token);
      final response = await dio.get(controller,
          options: Options(
            headers: {"xusercode": 'sgnm1040', "xtoken": TOKEN_V2},
          ));

      final data = jsonDecode(response.toString());

      print('kkkkkkk1  :  ' + data.toString());

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
            headers: {"xusercode": 'sgnm1040', "xtoken": TOKEN_V2},
          ));

      final data = jsonDecode(response.toString());

      print('kkkkkkkk2  :  ' + data.toString());

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

  Future<httpSonucModel> getAvailableActivities(
      {@required String? controller, bool redirectLogin = false}) async {
        
    try {
      //ReloadApiBase(StaticVariables.token);
      final response = await dio.get(controller.toString());

      final data = jsonDecode(response.toString());

      print('dataActivities' + data['records'].toString());

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

  Future<httpSonucModel> takeOverIssue(
      {@required String? controller, bool redirectLogin = false}) async {
    print('url ' + controller!);

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

    Future<httpSonucModel> getLiveSelectAsgGroups(
      {@required String? controller, bool redirectLogin = false}) async {
    print('url ' + controller!);

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
    Future<httpSonucModel> getLiveSelectAsgUser(
      {@required String? controller, bool redirectLogin = false}) async {
    print('url ' + controller!);

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

    Future<httpSonucModel> changeCfg(
      {@required String? controller, bool redirectLogin = false}) async {
    print('url ' + controller!);

    try {
      final response = await dio.get(controller);

      final data = jsonDecode(response.toString());

      print('dataCCC' + data.toString());


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
      {@required String? controller,
      @required Map<String, dynamic>? queryParameters,
      bool redirectLogin = false}) async {
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
  
}
