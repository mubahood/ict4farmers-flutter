import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:ict4farmers/extensions/string.dart';
import 'package:ict4farmers/extensions/widgets_extension.dart';
import 'package:ict4farmers/pages/TestPage1.dart';
import 'package:ict4farmers/pages/homes/homes_screen_segment.dart';
import 'package:ict4farmers/pages/homes/select_language_dialog.dart';
import 'package:ict4farmers/theme/app_notifier.dart';
import 'package:ict4farmers/theme/app_theme.dart';
import 'package:ict4farmers/theme/custom_theme.dart';
import 'package:ict4farmers/theme/theme_type.dart';
import 'package:ict4farmers/widgets/images.dart';
import 'package:ict4farmers/widgets/svg.dart';
import 'package:provider/provider.dart';

import '../TestPage.dart';
import 'app_setting_screen.dart';

class HomesScreen extends StatefulWidget {
  HomesScreen({Key? key}) : super(key: key);

  @override
  _HomesScreenState createState() => _HomesScreenState();
}

class _HomesScreenState extends State<HomesScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  late ThemeData theme;
  late CustomTheme customTheme;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  late TabController tabController;
  late List<NavItem> navItems;

  bool isDark = false;
  TextDirection textDirection = TextDirection.ltr;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
 //       animationDuration: Duration.zero,
        length: 5,
        vsync: this,
        initialIndex: 0);

    navItems = [
      NavItem('Home', Images.svg_home, HomesScreenSegment()),
      NavItem('Categories', Images.svg_category, Text("PAGE 2")),
      NavItem('Sell', Images.svg_add, Text("PAGE 3"), 32),
      NavItem('Chats', Images.svg_chats, Text("PAGE 4")),
      NavItem('Account', Images.svg_user, Text("PAGE 4")),
    ];

    tabController.addListener(() {
      currentIndex = tabController.index;

      setState(() {});
    });

    tabController.animation!.addListener(() {
      final aniValue = tabController.animation!.value;

      if (aniValue - currentIndex > 0.5) {
        currentIndex++;
      } else if (aniValue - currentIndex < -0.5) {
        currentIndex--;
      }

      setState(() {});
    });
  }

  void changeDirection() {
    if (AppTheme.textDirection == TextDirection.ltr) {
      Provider.of<AppNotifier>(context, listen: false)
          .changeDirectionality(TextDirection.rtl);
    } else {
      Provider.of<AppNotifier>(context, listen: false)
          .changeDirectionality(TextDirection.ltr);
    }
    setState(() {});
  }

  void changeTheme() {
    if (AppTheme.themeType == ThemeType.light) {
      Provider.of<AppNotifier>(context, listen: false)
          .updateTheme(ThemeType.dark);
    } else {
      Provider.of<AppNotifier>(context, listen: false)
          .updateTheme(ThemeType.light);
    }

    setState(() {});
  }

  void launchCodecanyonURL() async {
    String url = "https://codecanyon.net/user/coderthemes/portfolio";
    //await launch(url);
  }

  void launchDocumentation() async {
    String url = "https://onekit.coderthemes.com/index.html";
    //await launch(url);
  }

  void launchChangeLog() async {
    String url = "https://onekit.coderthemes.com/changlog.html";
    //await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (BuildContext context, AppNotifier value, Widget? child) {
        isDark = AppTheme.themeType == ThemeType.dark;
        textDirection = AppTheme.textDirection;
        theme = AppTheme.theme;
        customTheme = AppTheme.customTheme;
        return Scaffold(
          key: _drawerKey,
          appBar: AppBar(
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Image(
                    image: AssetImage(Images.logo_2),
                    width: 120,
                    color: null,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 7, bottom: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: theme.colorScheme.onBackground.withAlpha(20),
                  ),
                  width: 175,
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: theme.colorScheme.onBackground.withAlpha(200),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Search...",
                        style: TextStyle(
                          fontSize: 15,
                          color: theme.colorScheme.onBackground.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, SlideLeftRoute(AppSettingScreen()));
                  },
                  child: Container(
                    padding: FxSpacing.x(0),
                    child: Image(
                      image: AssetImage(Images.settingIcon),
                      color: theme.colorScheme.onBackground,
                      width: 26,
                      height: 26,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children:
                        navItems.map((navItem) => navItem.screen).toList()),
              ),
              FxContainer.none(
                padding: FxSpacing.xy(0, 2),
                color: theme.scaffoldBackgroundColor,
                bordered: true,
                enableBorderRadius: false,
                borderRadiusAll: 0,
                border: Border(
                  top: BorderSide(width: 2, color: customTheme.border),
                ),
                child: TabBar(
                  labelPadding: EdgeInsets.all(0),
                  controller: tabController,
                  indicator: FxTabIndicator(
                      indicatorColor: CustomTheme.primary,
                      indicatorStyle: FxTabIndicatorStyle.rectangle,
                      indicatorHeight: 2,
                      radius: 4,
                      yOffset: -4,
                      width: 35),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: CustomTheme.primary,
                  tabs: buildTab(),
                ),
              ),
            ],
          ),
/*          drawer: _buildDrawer(),*/
        );
      },
    );
  }

  List<Widget> buildTab() {
    List<Widget> tabs = [];

    for (int i = 0; i < navItems.length; i++) {
      tabs.add(Container(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 2, top: 2),
            child: SVG(navItems[i].icon,
                color: (currentIndex == i)
                    ? CustomTheme.primary
                    : theme.colorScheme.onBackground.withAlpha(220),
                size: 23),
          ),
          Text(
            navItems[i].title,
            style: TextStyle(
              color: (currentIndex == i)
                  ? CustomTheme.primary
                  : theme.colorScheme.onBackground.withAlpha(220),
            ),
          )
        ],
      )));
    }
    return tabs;
  }
}

class NavItem {
  final String title;
  final String icon;
  final Widget screen;
  final double size;

  NavItem(this.title, this.icon, this.screen, [this.size = 28]);
}
