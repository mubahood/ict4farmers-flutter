import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ict4farmers/theme/app_notifier.dart';
import 'package:ict4farmers/theme/app_theme.dart';
import 'package:ict4farmers/utils/AppConfig.dart';
import 'package:ict4farmers/utils/Utils.dart';
import 'package:ict4farmers/widgets/images.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../models/BannerModel.dart';
import '../../models/TestModel.dart';

class AccountSplash extends StatefulWidget {
  @override
  AaccountSplashState createState() => AaccountSplashState();
}

class AaccountSplashState extends State<AccountSplash> {
  late CustomTheme customTheme;
  late ThemeData theme;

  List<String> test_links = [];
  void shuffle_images(){

    test_links = Images.network_links;
    test_links.shuffle();
    test_links.shuffle();
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();

    FxTextStyle.changeFontFamily(GoogleFonts.mali);
    FxTextStyle.changeDefaultFontWeight({
      100: FontWeight.w100,
      200: FontWeight.w200,
      300: FontWeight.w300,
      400: FontWeight.w400,
      500: FontWeight.w500,
      600: FontWeight.w600,
      700: FontWeight.w700,
      800: FontWeight.w800,
      900: FontWeight.w900,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
        builder: (BuildContext context, AppNotifier value, Widget? child) {
      theme = AppTheme.theme;
      customTheme = AppTheme.customTheme;

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.copyWith(
            colorScheme: theme.colorScheme
                .copyWith(secondary: customTheme.cookifyPrimary.withAlpha(40))),
        home: Scaffold(
          body: ListView(
            children: [
              Container(
                margin: FxSpacing.fromLTRB(24, 50, 24, 32),
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      child:CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl:
                        "${test_links[0]}",
                        placeholder: (context, url) => Text("Loading..."),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 30),
                      child: Image.asset(
                        Images.logo_2,
                        height: 70,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 8),
                      child: FxText.sh1(
                          "Sign in to receive  offers and promotions.",
                          textAlign: TextAlign.center,
                          fontWeight: 600,
                          letterSpacing: 0),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: FxButton.text(
                          splashColor: customTheme.cookifyPrimary.withAlpha(40),
                          padding: FxSpacing.y(12),
                          onPressed: () {
                            Utils.navigate_to(AppConfig.AccountRegister, context);
                          },
                          child: FxText.l1(
                            "SIGN UP",
                            color: customTheme.cookifyPrimary,
                            letterSpacing: 0.5,
                          ),
                        )),
                        Expanded(
                            child: FxButton(
                          elevation: 0,
                          padding: FxSpacing.y(12),
                          borderRadiusAll: 4,
                          onPressed: () {
                            shuffle_images();
                            return;
                            Utils.navigate_to(AppConfig.AccountRegister, context);
                          },
                          child: FxText.l1(
                            "LOG IN",
                            color: customTheme.cookifyOnPrimary,
                            letterSpacing: 0.5,
                          ),
                          backgroundColor: customTheme.cookifyPrimary,
                        )),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 34),
                      child: Column(
                        children: <Widget>[
                          singleOption(
                              iconData: MdiIcons.mapMarkerOutline,
                              option: "Address"),
                          Divider(),
                          singleOption(
                              iconData: MdiIcons.creditCardOutline,
                              option: "Subscriptions",
                              navigation: Text("Subscriptions")),
                          Divider(),
                          singleOption(
                              iconData: MdiIcons.faceAgent,
                              option: "Help \& Support",
                              navigation: Text("Subscriptions")),
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 0),
                                  padding: EdgeInsets.all(3),
                                  child: Icon(
                                    Icons.facebook,
                                    size: 30,
                                    color: Colors.blue.shade800,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade500, width: 1),
                                      color: AppTheme.lightTheme.backgroundColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(11))),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 16),
                                  padding: EdgeInsets.all(3),
                                  child: Icon(
                                    MdiIcons.twitter,
                                    size: 30,
                                    color: Colors.blue.shade500,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade500, width: 1),
                                      color: AppTheme.lightTheme.backgroundColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(11))),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 16),
                                  padding: EdgeInsets.all(3),
                                  child: Icon(
                                    MdiIcons.instagram,
                                    size: 30,
                                    color: Colors.purple.shade300,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade500, width: 1),
                                      color: AppTheme.lightTheme.backgroundColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(11))),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 16),
                                  padding: EdgeInsets.all(3),
                                  child: Icon(
                                    MdiIcons.youtube,
                                    size: 30,
                                    color: Colors.red.shade500,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade500, width: 1),
                                      color: AppTheme.lightTheme.backgroundColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(11))),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 24),
                            width: double.infinity,
                            child: Text(
                              "(C) ${AppConfig.AppName} 2022",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget singleOption(
      {IconData? iconData, required String option, Widget? navigation}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: InkWell(
        onTap: () {
          if (navigation != null)
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => navigation));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Icon(
                iconData,
                size: 22,
                color: theme.colorScheme.onBackground,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16),
                child: FxText.b1(option, fontWeight: 600),
              ),
            ),
            Container(
              child: Icon(Icons.chevron_right,
                  size: 22, color: theme.colorScheme.onBackground),
            ),
          ],
        ),
      ),
    );
  }

  List<BannerModel> banners = [];

  void test_db() async {
    print("we start ");
    Utils.init_databse();

    await Hive.initFlutter();

    //Hive.registerAdapter(BannerModelAdapter());

    var box = await Hive.openBox<BannerModel>("BannerModel");

    BannerModel b = new BannerModel();
    BannerModel a = new BannerModel();
    b.name = "Romina";
    await box.add(b);

    print("${box.length} =========>  ");

    return;

    b.name = "Romina";
    await box.add(b);

    a.name = "Aanjane";
    await box.add(a);

    print("${box.length} =========> ${box.get(1)?.name}");
    box.close();

    print("WE ARE GOOD!");
  }
}
