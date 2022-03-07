import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ict4farmers/models/BannerModel.dart';
import 'package:ict4farmers/models/TestModel.dart';
import 'package:ict4farmers/models/UserModel.dart';
import 'package:ict4farmers/pages/HomPage.dart';
import 'package:ict4farmers/pages/account/account_register.dart';
import 'package:ict4farmers/pages/account/account_splash.dart';

import 'AppConfig.dart';

class Utils {
  static Future<String> http_post(
      String path, Map<String, dynamic> body) async {
    bool is_online = await Utils.is_connected();
    if (!is_online) {
      return "";
    }
    Response response;
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

/*    UserModel u = new UserModel();
    u = await Utils.get_logged_user();*/
    var da = FormData.fromMap(body);
    try {
      response = await dio.post(AppConfig.BASE_URL + "/${path}",
          data: da,
          options: Options(headers: <String, String>{
            //"user": "${u.id}",
            "Content-Type": "application/json",
            "accept": "application/json",
          }));
      return jsonEncode(response.data);
    } catch (e) {
      return "";
    }

    return "";
  }

  static Future<bool> is_connected() async {
    bool is_connected = false;
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      is_connected = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      is_connected = true;
    }

    return is_connected;
  }

  static Future<String> http_get(String path, Map<String, dynamic> body) async {
    bool is_connected = await Utils.is_connected();

    /*


        try {
      print("Connecting≥...≤");
      var response = await Dio().get('https://goprint.ug/api/products');
      print("Connecting≥..!!..≤");
      print(response);
      print("Connecting≥..GOOOOOD..≤");
    } catch (e) {
      print("Connecting≥. failed ..≤");
      print(e);
    }


     */

    if (!is_connected) {
      return "";
    }
    Response response;
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    var da = FormData.fromMap(body);
    //UserModel u = new UserModel();
    //u = await Utils.get_logged_user();

    try {
      response = await dio.get(AppConfig.BASE_URL + "/${path}",
          queryParameters: body,
          options: Options(headers: <String, String>{
            //"user": "${u.id}",
            "Content-Type": "application/json",
            "accept": "application/json",
          }));
    } catch (E) {
      print("FAILED BECAUSE  ====> ${E.toString()}");
      return "";
    }

    return jsonEncode(response.data);
  }

  static Future<dynamic> init_databse() async {
    if (!Hive.isAdapterRegistered(20)) {
      Hive.registerAdapter(BannerModelAdapter());
    }

    if (!Hive.isAdapterRegistered(30)) {
      Hive.registerAdapter(TestModelsAdapter());
    }
  }

  static navigate_to(String screen, context, {dynamic data: null}) {
    switch (screen) {
      case AppConfig.HomePage:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => HomePage(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case AppConfig.AccountRegister:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => AccountRegister(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case AppConfig.AccountSplash:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => AccountSplash(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
    }
  }

  static Future<void> login_user(UserModel u) async {
    print("good to login!");
  }
}
