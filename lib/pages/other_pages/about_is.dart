import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:flutx/widgets/widgets.dart';
import '../../theme/app_theme.dart';
import '../../utils/AppConfig.dart';
import 'package:provider/provider.dart';

import '../../theme/app_notifier.dart';

class AboutUs extends StatefulWidget {
  @override
  State<AboutUs> createState() => AboutUsState();
}

late CustomTheme customTheme;

bool is_loading = false;

class AboutUsState extends State<AboutUs> {
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  void dipose() {}

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
        builder: (BuildContext context, AppNotifier value, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          elevation: .5,
          title: Text(
            "About ${AppConfig.AppName}",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
            child: ListView(
          children: [
            SingleWidget(
              "${AppConfig.AppName} is a website where you can buy and sell almost everything. The best deals are often done with people who live in your own city or on your own street, so on Goprint.ug it's easy to buy and sell locally. All you have to do is select your region.",
              'logo_2.png',
              false,
            ),
            SingleWidget(
              "It takes you less than 2 minutes to post an ad on ${AppConfig.AppName}. You can sign up for a free account and post ads easily every time.",
              'sell_fast_1.png',
              false,
            ),
            SingleWidget(
              "${AppConfig.AppName} has the widest selection of popular services and items all over Uganda, which makes it easy to find exactly what you are looking for. So if you're looking for a branding, printing, software, jobs or maybe stationary, you will find the best deal on ${AppConfig.AppName}.",
              'sell_fast_3.png',
              false,
            ),
            SingleWidget(
              "${AppConfig.AppName}  does not specialize in any specific category - here you can buy and sell items in more than 50 different categories. We also carefully review all ads that are being published, to make sure the quality is up to our standards..",
              'on_board_market_place.png',
              true,
            ),
          ],
        )),
      );
    });
  }

  SingleWidget(String body, String image, bool is_last) {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: [
          FxSpacing.height(20),
          Image(
            image: AssetImage('./assets/project/${image}'),
            width: (MediaQuery.of(context).size.width - 200),
            fit: BoxFit.cover,
          ),
          FxSpacing.height(15),
          FxText.b1(
            body,
            textAlign: TextAlign.justify,
          ),
          FxSpacing.height(20),
          is_last
              ? Container()
              : Container(
                  child: Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Divider(
                      height: 10, color: CustomTheme.primary.withAlpha(40)),
                )),
          FxSpacing.height(20),
        ],
      ),
    );
  }
}
