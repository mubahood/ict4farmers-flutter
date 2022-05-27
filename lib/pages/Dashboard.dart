import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/container/container.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:ict4farmers/pages/location_picker/single_item_picker.dart';
import 'package:ict4farmers/pages/product_add_form/product_add_form.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../models/UserModel.dart';
import '../../theme/app_theme.dart';
import '../../utils/AppConfig.dart';
import '../../utils/Utils.dart';
import '../models/FarmersGroup.dart';
import '../models/MenuItemModel.dart';
import '../utils/SizeConfig.dart';
import '../widget/my_widgets.dart';

class Dashboard extends StatefulWidget {
  BuildContext _context;

  Dashboard(this._context);

  @override
  DashboardState createState() => DashboardState(_context);
}

class DashboardState extends State<Dashboard> {
  late ThemeData themeData;
  BuildContext _context;

  List<MenuItemModel> main_menu_items = [
//    new MenuItemModel('HRM', "1.png", AppConfig.WorkersScreen, true),
    new MenuItemModel(
        'Enterprise Management', "1.png", AppConfig.GardensScreen, true),
    new MenuItemModel('Pests & Diseases', "4.png", AppConfig.PestsScreen, true),
    new MenuItemModel('Market Place', "3.png", AppConfig.MarketPlace1, false),
    new MenuItemModel('Resource Sharing', "2.png", AppConfig.ComingSoon, true),
    new MenuItemModel(
        'Extension Services', "6.png", AppConfig.ComingSoon, true),
    new MenuItemModel(
        'Ask the Expert', "5.png", AppConfig.QuestionsScreen, true),
  ];

  DashboardState(this._context);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    themeData = AppTheme.theme;
    my_init();
  }

  Future<void> my_init() async {
    loggedUser = await Utils.get_logged_in();
    if (loggedUser.id < 1) {
      is_logged_in = false;
    } else {
      is_logged_in = true;
    }

    setState(() {});
    Utils.ini_theme();
  }

  bool is_logged_in = false;
  UserModel loggedUser = new UserModel();
  int pending_activities_number = 0;
  int missing_activities_number = 0;

  Future<Null> _onRefresh() async {
    await my_init();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<MenuItemModel> sub_menu_items = [];
    MenuItemModel i1 = new MenuItemModel(
        'My Acivities', "1.png", AppConfig.GardenActivitiesScreen, true);
    i1.icon = Icons.agriculture;
    sub_menu_items.add(i1);

    MenuItemModel i2 = new MenuItemModel(
        'My Records', "1.png", AppConfig.GardenProductionRecordsScreen, true);
    i2.icon = Icons.assignment;
    sub_menu_items.add(i2);

    MenuItemModel i3 = new MenuItemModel(
        'My Products', "1.png", AppConfig.MyProductsScreen, true);
    i3.icon = Icons.inventory;
    sub_menu_items.add(i3);

    MenuItemModel i4 =
        new MenuItemModel('My Chats', "1.png", AppConfig.ChatHomeScreen, true);
    i4.icon = Icons.forum;
    sub_menu_items.add(i4);



    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomTheme.primary_bg,
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          color: CustomTheme.primary,
          backgroundColor: Colors.white,
          child: Container(
            color: Colors.grey.shade100,
            child: ListView(
              padding: Spacing.top(20),
              children: [
                Container(
                  padding: Spacing.only(left: 15, right: 15),
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Hello ',
                            style: TextStyle(fontWeight: FontWeight.w200)),
                        TextSpan(
                          text: 'Muhindo Mubaraka Mutheke',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: Spacing.fromLTRB(10, 10, 10, 0),
                  padding: Spacing.all(15),
                  decoration: BoxDecoration(
                      color: (missing_activities_number > 0)
                          ? Colors.red.shade700
                          : (pending_activities_number > 0)
                              ? Colors.yellow.shade800
                              : CustomTheme.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FxText(
                            (missing_activities_number > 0)
                                ? "Attention!"
                                : (pending_activities_number > 0)
                                    ? "Heads Up!"
                                    : "You are Good!",
                            color: Colors.white,
                            fontWeight: 700,
                            fontSize: 20,
                          ),
                          singleHorizontalpWidget(
                              screen: "",
                              iconData: Icons.arrow_right,
                              color: (missing_activities_number > 0)
                                  ? Colors.red.shade700
                                  : (pending_activities_number > 0)
                                      ? Colors.yellow.shade800
                                      : CustomTheme.primary,
                              title: (missing_activities_number > 0)
                                  ? "Do Action!"
                                  : (pending_activities_number > 0)
                                      ? "Do Action!"
                                      : "My Activities"),
                        ],
                      ),
                      Container(
                        margin: Spacing.top(10),
                        child: FxText(
                          (missing_activities_number > 0)
                              ? "You currently have ${missing_activities_number} MISSED activitie(s) that require your attention!"
                              : (pending_activities_number > 0)
                                  ? "You currently have ${pending_activities_number} PENDING activitie(s) that require your attention!"
                                  : "You currently have NO activity that requires your attention.",
                          color: Colors.white,
                          fontSize: 14,
                          letterSpacing: .1,
                          fontWeight: 500,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: Spacing.fromLTRB(10, 0, 10, 0),
                  padding: Spacing.fromLTRB(0, 15, 0, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          header_widget(AppConfig.GardenCreateScreen,
                              "Create Garden", Icons.add_circle_outline),
                          header_widget(AppConfig.SubmitActivityScreen,
                              "My Activities", Icons.date_range),
                          header_widget('sell', "Sell Something", Icons.sell),
                          header_widget("ContactUs", "Contact Us", Icons.phone),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: Spacing.fromLTRB(10, 10, 10, 10),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    childAspectRatio: 1.3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      singleService(
                          icon: Icons.agriculture,
                          title: "Production Guides",
                          screen: AppConfig.PestsScreen),
                      singleService(
                          icon: Icons.add,
                          title: "Production Guides",
                          screen: AppConfig.GardenCreateScreen),
                      singleService(
                          icon: Icons.add,
                          title: "Production Guides",
                          screen: AppConfig.GardenCreateScreen),
                      singleService(
                          icon: Icons.add,
                          title: "Production Guides",
                          screen: AppConfig.GardenCreateScreen),
                      singleService(
                          icon: Icons.add,
                          title: "Production Guides",
                          screen: AppConfig.GardenCreateScreen),
                      singleService(
                          icon: Icons.add,
                          title: "Production Guides",
                          screen: AppConfig.GardenCreateScreen),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _list_item(MenuItemModel menu_item) {
    String badge = "1";
    return InkWell(
      onTap: () => {Utils.navigate_to(menu_item.screen, context)},
      child: Container(
        child: FxContainer(
          margin: EdgeInsets.only(left: 10, top: 10, bottom: 0, right: 10),
          padding: FxSpacing.all(20),
          bordered: true,
          border: Border.all(color: CustomTheme.primary, width: 1),
          child: InkWell(
            onTap: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.access_alarms,
                    size: 22,
                  ),
                ),
                FxSpacing.width(16),
                Expanded(
                  child: FxText.b1(
                    menu_item.title,
                    fontWeight: 800,
                    color: Colors.black,
                    fontSize: (menu_item.title.length > 20) ? 16 : 18,
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      badge.toString().isEmpty
                          ? SizedBox()
                          : FxContainer(
                              color: Colors.red.shade500,
                              width: 28,
                              paddingAll: 0,
                              marginAll: 0,
                              alignment: Alignment.center,
                              borderRadiusAll: 15,
                              height: 28,
                              child: FxText(
                                badge.toString(),
                                color: Colors.white,
                              )),
                      Icon(
                        MdiIcons.chevronRight,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _single_item(MenuItemModel item) {
    return InkWell(
      onTap: () => {
        item.is_protected
            ? (loggedUser.id > 0)
                ? Utils.navigate_to(item.screen, context)
                : show_not_account_bottom_sheet(context)
            : Utils.navigate_to(item.screen, context)
      },
      child: FxCard(
        paddingAll: 5,
        color: Colors.white,
        borderRadiusAll: 10,
        margin: EdgeInsets.only(left: 5, right: 5, top: 10),
        child: Column(
          children: [
            Container(
              height: 80,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage("assets/project/${item.photo}"),
              ),
            ),
            Spacer(),
            FxText(
              "${item.title}",
              textAlign: TextAlign.center,
              color: CustomTheme.primaryDark,
              fontWeight: 800,
              height: 1,
              maxLines: 2,
              fontSize: 14,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  /*
  Container(
        padding: EdgeInsets.only(left: 10, top: 20, right: 10),
        child: FxContainer(
          paddingAll: 0,
          bordered: true,
          width: MediaQuery.of(context).size.width / 2.3,
          border: Border.all(color: CustomTheme.primary, width: 1),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                  child: FxText(
                    item.title,
                    maxLines: 3,
                    fontSize: (item.title.length > 16) ? 18 : 22,
                    height: .8,
                    fontWeight: 700,
                    color: Colors.grey.shade900,
                  ),
                ),
                Spacer(),
                Container(
                  height: 90,
                  child: Image(
                    fit: BoxFit.fill,
                    width: (Utils.screen_width(context) / 2),
                    image: AssetImage("assets/project/${item.photo}"),
                  ),
                ),
              ],
            ),
          ),
          color: Colors.white,
        ),
      )
   */

  Widget singleOption(_context, theme,
      {IconData? iconData,
      required String option,
      String navigation: "",
      String badge: ""}) {
    return FxContainer(
      margin: EdgeInsets.only(left: 20, top: 0, bottom: 20, right: 20),
      padding: FxSpacing.all(20),
      bordered: true,
      border: Border.all(color: CustomTheme.primary, width: 1),
      child: InkWell(
        onTap: () {
          if (navigation == AppConfig.CallUs) {
            Utils.launchOuLink(navigation);
          } else if (navigation == AppConfig.ProductAddForm) {
            Utils.navigate_to(navigation, _context);
            //_show_bottom_sheet_sell_or_buy(_context);
          } else {
            Utils.navigate_to(navigation, _context);
          }
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
            FxSpacing.width(16),
            Expanded(
              child: FxText.b1(
                option,
                fontWeight: 800,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            Container(
              child: Row(
                children: [
                  badge.toString().isEmpty
                      ? SizedBox()
                      : FxContainer(
                      color: Colors.red.shade500,
                      width: 28,
                      paddingAll: 0,
                      marginAll: 0,
                      alignment: Alignment.center,
                      borderRadiusAll: 15,
                      height: 28,
                      child: FxText(
                        badge.toString(),
                        color: Colors.white,
                      )),
                  Icon(MdiIcons.chevronRight,
                      size: 22, color: theme.colorScheme.onBackground),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> do_logout() async {
    await Utils.logged_out();
    Utils.showSnackBar("Logged out successfully.", _context, Colors.white);
    my_init();
  }

  open_add_product(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductAddForm()),
    );

    if (result != null) {
      if (result['task'] != null) {
        if (result['task'] == 'success') {
          Utils.navigate_to(AppConfig.MyProductsScreen, context);
        }
      }
    }
  }

  List<FarmersGroup> farmers_groups = [];

  test_function() async {
    farmers_groups = await FarmersGroup.get_items();

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SingleItemPicker(
              "Pick farmer group", jsonEncode(farmers_groups), "0")),
    );
    if (result != null) {
      if (result['id'] != null && result['name'] != null) {
        print(result);
      }
    }
  }

  Widget sub_menu_widget(MenuItemModel sub_menu_item) {
    return InkWell(
      onTap: () => {
        if (sub_menu_item.is_protected)
          {
            if (!is_logged_in)
              {show_not_account_bottom_sheet(context)}
            else
              {Utils.navigate_to(sub_menu_item.screen, context)}
          }
      },
      child: Column(
        children: [
          FxContainer.rounded(
            bordered: true,
            border: Border.all(color: CustomTheme.primary),
            paddingAll: 10,
            splashColor: CustomTheme.primary,
            color: CustomTheme.primary_bg,
            child: Icon(
              sub_menu_item.icon,
              size: 35,
              color: CustomTheme.primaryDark,
            ),
          ),
          FxCard(
            padding: EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 5),
            marginAll: 0,
            child: FxText(
              "${sub_menu_item.title}",
              color: CustomTheme.primaryDark,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              fontSize: 13,
              fontWeight: 800,
            ),
          )
        ],
      ),
    );
  }

  Widget singleHorizontalpWidget(
      {IconData? iconData,
      required String title,
      Color? color,
      required String screen}) {
    return GestureDetector(
      onTap: () {
        Utils.navigate_to(AppConfig.SubmitActivityScreen, context);
        //Utils.navigate_to(screen, context);
      },
      child: FxCard(
        padding: Spacing.fromLTRB(5, 5, 5, 5),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: color == null ? themeData.colorScheme.primary : color,
              size: 16,
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 0,
                  fontSize: 14,
                  color: (missing_activities_number > 0)
                      ? Colors.red.shade700
                      : (pending_activities_number > 0)
                          ? Colors.yellow.shade800
                          : CustomTheme.primary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget singleHelpWidget(
      {IconData? iconData,
      required String title,
      Color? color,
      required String screen}) {
    return GestureDetector(
      onTap: () {
        Utils.navigate_to(screen, context);
      },
      child: Container(
        padding: Spacing.fromLTRB(0, 20, 0, 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
                color: CustomTheme.primary, width: 1, style: BorderStyle.solid),
            boxShadow: [BoxShadow(blurRadius: 50, offset: Offset(0, 50))]),
        child: Column(
          children: [
            Icon(
              iconData,
              color: color == null ? themeData.colorScheme.primary : color,
              size: 50,
            ),
            Container(
              margin: Spacing.top(8),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 0,
                  fontSize: 18,
                  color: themeData.colorScheme.onBackground,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  header_widget(String screen, title, IconData iconData) {
    return InkWell(
      onTap: () => {
        if (screen == 'ContactUs')
          {Utils.launchPhone(AppConfig.OUR_PHONE_NUMBER)}
        else if (screen == 'sell')
          {}
        else
          {Utils.navigate_to(screen, context)}
      },
      child: Column(
        children: [
          Icon(
            iconData,
            color: CustomTheme.primary,
            size: 40,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 12,
                color: CustomTheme.primary,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget singleService(
      {required IconData icon, required String title, required String screen}) {
    return InkWell(
      onTap: () => {
        Utils.navigate_to(screen, context)
      },
      child: FxCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: CustomTheme.primary,
              size: 45,
            ),
            SizedBox(
              height: 5,
            ),
            FxText(
              "${title}",
              fontSize: 16,
              fontWeight: 800,
              height: 1,
              maxLines: 2,
              textAlign: TextAlign.center,
              color: Colors.grey.shade800,
            ),
          ],
        ),
        border: Border.all(color: CustomTheme.primary),
        bordered: true,
        color: Colors.white,
      ),
    );
  }
}
