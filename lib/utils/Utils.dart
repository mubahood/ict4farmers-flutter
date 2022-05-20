import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ict4farmers/models/BannerModel.dart';
import 'package:ict4farmers/models/GardenActivityModel.dart';
import 'package:ict4farmers/models/GardenModel.dart';
import 'package:ict4farmers/models/PostCategoryModel.dart';
import 'package:ict4farmers/models/ProductModel.dart';
import 'package:ict4farmers/models/UserModel.dart';
import 'package:ict4farmers/pages/HomPage.dart';
import 'package:ict4farmers/pages/account/account_register.dart';
import 'package:ict4farmers/pages/account/account_splash.dart';
import 'package:ict4farmers/pages/gardens/garden_activity_create_screen.dart';
import 'package:ict4farmers/pages/pests/pests_screen.dart';
import 'package:ict4farmers/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/CategoryModel.dart';
import '../models/ChatModel.dart';
import '../models/ChatThreadModel.dart';
import '../models/CropCategory.dart';
import '../models/DynamicTable.dart';
import '../models/FormItemModel.dart';
import '../models/LocationModel.dart';
import '../models/PestModel.dart';
import '../models/PostModel.dart';
import '../pages/account/account_details.dart';
import '../pages/account/account_edit.dart';
import '../pages/account/account_login.dart';
import '../pages/account/my_products_screen.dart';
import '../pages/account/onboarding_widget.dart';
import '../pages/chat/chat_home_screen.dart';
import '../pages/forum/create_post_screen.dart';
import '../pages/gardens/garden_activities_screen.dart';
import '../pages/gardens/garden_create_screen.dart';
import '../pages/gardens/garden_screen.dart';
import '../pages/gardens/gardens_screen.dart';
import '../pages/homes/advisory/advisory_home.dart';
import '../pages/homes/homes_screen.dart';
import '../pages/other_pages/MoreMenuScreen1.dart';
import '../pages/other_pages/PaymentPage.dart';
import '../pages/other_pages/SuccessPaymentPage.dart';
import '../pages/other_pages/privacy_policy.dart';
import '../pages/other_pages/sell_fast.dart';
import '../pages/pests/pest_case_create_screen.dart';
import '../pages/pests/pest_screen.dart';
import '../pages/posts/post_details_screen.dart';
import '../pages/product_add_form/product_add_form.dart';
import '../pages/products/product_details.dart';
import '../pages/products/product_listting.dart';
import '../pages/products/view_full_images_screen.dart';
import '../pages/search/search_screen.dart';
import 'AppConfig.dart';

class Utils {
  static void boot_system() async {
    await CropCategory.get_items();
    await GardenModel.get_items();
    await GardenActivityModel.get_items();
    await PestModel.get_items();
  }

  static void launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  static void launchPhone(String phone_number) async {
    if (!await launch('tel:${phone_number}'))
      throw 'Could not launch $phone_number';
  }

//
  static void launchOuLink(String link) async {
    if (link == AppConfig.CallUs) {
      Utils.launchPhone(AppConfig.OUR_PHONE_NUMBER);
    } else if (link == AppConfig.OurWhatsApp) {
      Utils.launchURL(
          'https://wa.me/${AppConfig.OUR_WHATSAPP_NUMBER}?text=Hi, I am contacting you from go ${AppConfig.AppName}.\n\n');
    } else {
      Utils.launchURL(link);
    }
  }

  static void launch_browser(String _url) {
    do_launch_browser(_url);
  }

  static void do_launch_browser(dynamic _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  static LatLng get_default_lati_long() {
    double lati = 0.364607;
    double long = 32.604781;

    return new LatLng(lati, long);
  }

  static void showSnackBar(String message, BuildContext context, color,
      {background_color: Colors.green}) {
    if (Colors.green == background_color) {
      background_color = CustomTheme.primary;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FxText.sh2(message, color: color),
        backgroundColor: background_color,
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }

  static int int_parse(dynamic x) {
    if(x == null){
      return 0;
    }
    int temp = 0;
    try {
      temp = int.parse(x.toString());
    } catch (e) {
      temp = 0;
    }

    return temp;
  }



  static bool bool_parse(dynamic x) {
    int temp = 0;
    bool ans = false;
    try {
      temp = int.parse(x.toString());
    } catch (e) {
      temp = 0;
    }

    if (temp == 1) {
      ans = true;
    } else {
      ans = false;
    }
    return ans;
  }

  static double screen_width(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    return x;
  }

   static double get_screen_height(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

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
      print(e);
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
      return "";
    }

    return jsonEncode(response.data);
  }

  static Future<dynamic> init_databse() async {
    if (!Hive.isAdapterRegistered(20)) {
      Hive.registerAdapter(BannerModelAdapter());
    }

    if (!Hive.isAdapterRegistered(30)) {
      Hive.registerAdapter(ProductModelAdapter());
    }

    if (!Hive.isAdapterRegistered(40)) {
      Hive.registerAdapter(UserModelAdapter());
    }

    if (!Hive.isAdapterRegistered(50)) {
      Hive.registerAdapter(FormItemModelAdapter());
    }

    if (!Hive.isAdapterRegistered(51)) {
      Hive.registerAdapter(CategoryModelAdapter());
    }
    if (!Hive.isAdapterRegistered(52)) {
      Hive.registerAdapter(LocationModelAdapter());
    }

    if (!Hive.isAdapterRegistered(53)) {
      Hive.registerAdapter(PostModelAdapter());
    }

    if (!Hive.isAdapterRegistered(54)) {
      Hive.registerAdapter(PostCategoryModelAdapter());
    }

    if (!Hive.isAdapterRegistered(55)) {
      Hive.registerAdapter(ChatModelAdapter());
    }

    if (!Hive.isAdapterRegistered(56)) {
      Hive.registerAdapter(ChatThreadModelAdapter());
    }
    if (!Hive.isAdapterRegistered(60)) {
      Hive.registerAdapter(DynamicTableAdapter());
    }
  }

  static navigate_to(String screen, context, {dynamic data: null}) {
    switch (screen) {
      case AppConfig.MarketPlace1:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => HomesScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.MoreMenuScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => MoreMenuScreen1(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.PestCaseCreateScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                PestCaseCreateScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.PestScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => PestScreen(data),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.GardenActivityCreateScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                GardenActivityCreateScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.PestsScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => PestsScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.GardenCreateScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                GardenCreateScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.GardenActivitiesScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                GardenActivitiesScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.GardensScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => GardensScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case AppConfig.GardenScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => GardenScreen(data),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.PaymentPage:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => PaymentPage(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.SuccessPaymentPage:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                SuccessPaymentPage(),
            transitionDuration: Duration.zero,
          ),
        );
        break;


        case AppConfig.ViewFullImagesScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                ViewFullImagesScreen(data),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.SearchScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => SearchScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.ForumScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => ForumScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.SellFast:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => SellFast(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.AccountEdit:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => AccountEdit(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.AccountDetails:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                AccountDetails(data),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.PrivacyPolicy:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => PrivacyPolicy(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.ProductDetails:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                ProductDetails(data),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.AccountLogin:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => AccountLogin(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.ChatHomeScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => ChatHomeScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.OnBoardingWidget:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                OnBoardingWidget2(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.PostDetailsScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                PostDetailsScreen(data),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.CreatePostScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                CreatePostScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      /*    case AppConfig.ChatScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => ChatScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;*/

      case AppConfig.ProductListting:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                ProductListting(data),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.MyProductsScreen:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                MyProductsScreen(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case AppConfig.ProductAddForm:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => ProductAddForm(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

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
      default:
        Utils.showSnackBar("Coming soon...", context, Colors.white);
        break;
    }
  }

  static Future<bool> login_user(UserModel u) async {
    if (await is_login()) {
      await logged_out();
    }

    u.status = 'logged_in';
    u.status_comment = u.id.toString();

    var box = null;

    if (Hive.isBoxOpen('UserModel')) {
      box = await Hive.openBox<UserModel>("UserModel");
    }

    if (box == null) {
      return false;
    }

    box.add(u);

    return true;
  }

  static Future<bool> is_login() async {
    UserModel u = await get_logged_in();
    if (u == null) {
      return false;
    }
    if (u.id < 1) {
      return false;
    }

    if (u.status != 'logged_in') {
      return false;
    }

    return true;
  }

  static Future<UserModel> get_logged_in() async {
    UserModel u = new UserModel();
    List<UserModel> users = [];
    users = await get_local_users();
    if (users == null || users.isEmpty) {
      return u;
    }
    users.forEach((element) {
      if (element != null) {
        if (element.status == 'logged_in') {
          try {
            u.id = int.parse(element.status_comment);
          } catch (e) {
            u.id = 0;
          }
          u = element;
        }
      }
    });
    return u;
  }

  static Future<void> logged_out() async {
    List<UserModel> users = [];
    users = await get_local_users();

    users.forEach((element) {
      if (element != null) {
        if (element.status == 'logged_in') {
          element.delete();
        }
      }
    });
  }

  static Future<List<UserModel>> get_local_users() async {
    Utils.init_databse();
    await Hive.initFlutter();
    var box = await Hive.openBox<UserModel>("UserModel");
    if (box.values.isEmpty) {
      return [];
    }

    List<UserModel> items = [];
    box.values.forEach((element) {
      items.add(element);
    });

    return items;
  }

  static Future<Position> get_device_location() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

    }

    Position p = await Geolocator.getCurrentPosition();
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  static screen_height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }


  static void ini_theme() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: CustomTheme.primary,
      statusBarIconBrightness: Brightness.light,
    ));
  }

}
