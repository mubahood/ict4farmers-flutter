import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ict4farmers/objectbox.g.dart';
import 'package:ict4farmers/pages/HomPage.dart';
import 'package:ict4farmers/pages/account/account_register.dart';
import 'package:ict4farmers/pages/account/account_splash.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'AppConfig.dart';

class Utils {
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

  static Future<Store> init_databse() async {
    Directory value = await getApplicationDocumentsDirectory();

    return Store(getObjectBoxModel(), directory: "${value.path}/objectbox ");
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
}
