import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import '../widget/my_widgets.dart';
import '../widget/shimmer_loading_widget.dart';

class Dashboard extends StatefulWidget {
  BuildContext _context;

  Dashboard(this._context);

  @override
  DashboardState createState() => DashboardState(_context);
}

class DashboardState extends State<Dashboard> {
  late ThemeData theme;
  BuildContext _context;

  List<MenuItemModel> main_menu_items = [
//    new MenuItemModel('HRM', "1.png", AppConfig.WorkersScreen, true),
    new MenuItemModel(
        'Garden management', "1.png", AppConfig.GardensScreen, true),
    new MenuItemModel(
        'Pest & disease control', "4.png", AppConfig.PestsScreen, true),
    new MenuItemModel('Market place', "3.png", AppConfig.MarketPlace1, false),
    new MenuItemModel('Resource sharing', "2.png", AppConfig.ComingSoon, true),
  ];

  DashboardState(this._context);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theme = AppTheme.theme;
    my_init();
  }

  Future<void> my_init() async {

    loggedUser = await Utils.get_logged_in();
    if (loggedUser.id < 1) {
      return;
    }
    is_logged_in = true;
    setState(() {});
    Utils.ini_theme();
  }

  bool is_logged_in = false;
  UserModel loggedUser = new UserModel();

  Future<Null> _onRefresh() async {
    await my_init();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<MenuItemModel> sub_menu_items = [
      new MenuItemModel('My farmer calender', "1.png",
          AppConfig.GardenActivitiesScreen, true),
      new MenuItemModel('My workers', "1.png", AppConfig.ComingSoon, true),
      new MenuItemModel('My farm records', "1.png", AppConfig.ComingSoon, true),
      new MenuItemModel(
          'My products & services', "1.png", AppConfig.MyProductsScreen, true),
      new MenuItemModel('My orders', "1.png", AppConfig.ComingSoon, true),
      new MenuItemModel(
          'Production guides', "1.png", AppConfig.ComingSoon, true),
      new MenuItemModel('Resources', "1.png", AppConfig.ComingSoon, true),
      new MenuItemModel('Browse farmers', "1.png", AppConfig.ComingSoon, true),
      new MenuItemModel(
          'Extension services', "1.png", AppConfig.ComingSoon, true),
      new MenuItemModel(
          'Products pricing', "1.png", AppConfig.ComingSoon, true),
      new MenuItemModel('Ask an expert', "1.png", AppConfig.ComingSoon, true),
      new MenuItemModel('About this App', "1.png", AppConfig.ComingSoon, true),
      new MenuItemModel(
          'Our privacy policy', "1.png", AppConfig.PrivacyPolicy, true),
      new MenuItemModel('Help & Support', "1.png", AppConfig.ComingSoon, true),
      new MenuItemModel('Toll free', "1.png", AppConfig.ComingSoon, true),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomTheme.primary,
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: CustomTheme.primary,
            elevation: 20,
            onPressed: () {
              Utils.navigate_to(AppConfig.MoreMenuScreen, context);
            },
            label: Row(
              children: [
                Icon(
                  MdiIcons.plus,
                  size: 18,
                ),
                Container(
                  child: Text(
                    "MORE",
                  ),
                ),
              ],
            )),
        body: RefreshIndicator(
            color: CustomTheme.primary,
            backgroundColor: Colors.white,
            onRefresh: _onRefresh,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                    titleSpacing: 0,
                    elevation: 0,
                    pinned: true,
                    toolbarHeight: (Utils.screen_height(context) / 3.5),
                    title: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(80),
                            bottomRight: Radius.circular(80),
                          ),
                          child: Image(
                            width: double.infinity,
                            height: (Utils.screen_height(context) / 3.5),
                            fit: BoxFit.cover,
                            image: AssetImage("assets/project/farm_doodle.jpg"),
                          ),
                        ),
                        InkWell(
                          onTap: () => {
                            if (!is_logged_in)
                              {show_not_account_bottom_sheet(context)}
                            else
                              {
                                Utils.navigate_to(
                                    AppConfig.AccountEdit, context)
                              }
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: (MediaQuery.of(context).size.height / 7),
                            ),
                            child: Row(
                              children: [
                                FxContainer.rounded(
                                  paddingAll: 0,
                                  color: CustomTheme.primary,
                                  child: is_logged_in
                                      ? CachedNetworkImage(
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                          imageUrl: loggedUser.avatar,
                                          placeholder: (context, url) =>
                                              ShimmerLoadingWidget(
                                            height: 70,
                                            width: 70,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image(
                                            image: AssetImage(
                                                './assets/project/user.png'),
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Image(
                                          width: 60,
                                          height: 60,
                                          image: AssetImage(
                                              "./assets/project/user.png"),
                                        ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FxText.h1(
                                        (is_logged_in)
                                            ? loggedUser.name
                                            : "Join ${AppConfig.AppName}",
                                        fontWeight: 700,
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                      FxText.caption(
                                        (is_logged_in)
                                            ? loggedUser.email
                                            : "To access all features of ${AppConfig.AppName}!",
                                        fontWeight: 500,
                                        fontSize: 14,
                                        color: Colors.grey.shade700,
                                      ),
                                    ],
                                  ),
                                ),
                                /* Container(
                            child:
                            FxText.h2("Bob Tusiime"),
                          )*/
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 20,
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () => {
                                  Utils.launchPhone(
                                      AppConfig.TOLL_FREE_PHONE_NUMBER)
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      FxContainer.rounded(
                                        bordered: true,
                                        border: Border.all(
                                            color: CustomTheme.primary),
                                        paddingAll: 10,
                                        splashColor: CustomTheme.primary,
                                        color: Colors.green.shade50,
                                        child: Icon(
                                          CupertinoIcons.phone,
                                          size: 25,
                                        ),
                                      ),
                                      FxContainer(
                                        padding: EdgeInsets.only(
                                            top: 3,
                                            bottom: 3,
                                            left: 10,
                                            right: 10),
                                        splashColor: CustomTheme.primary,
                                        color: Colors.white,
                                        child: FxText(
                                          "Toll free",
                                          fontWeight: 800,
                                          color: CustomTheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () => {},
                                child: FxContainer.rounded(
                                  bordered: true,
                                  border:
                                      Border.all(color: CustomTheme.primary),
                                  paddingAll: 10,
                                  splashColor: CustomTheme.primary,
                                  color: Colors.green.shade50,
                                  child: Icon(
                                    CupertinoIcons.shopping_cart,
                                    size: 25,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => {test_function()},
                                child: FxContainer.rounded(
                                  bordered: true,
                                  border:
                                      Border.all(color: CustomTheme.primary),
                                  margin: EdgeInsets.only(left: 10),
                                  paddingAll: 11,
                                  splashColor: CustomTheme.primary,
                                  color: Colors.green.shade50,
                                  child: Icon(
                                    CupertinoIcons.bell,
                                    size: 25,
                                  ),
                                ),
                              ),
                              /* Container(
                          child:
                          FxText.h2("Bob Tusiime"),
                        )*/
                            ],
                          ),
                        ),
                      ],
                    ),
                    floating: false,
                    backgroundColor: CustomTheme.primary),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      childAspectRatio: 1,
                      mainAxisExtent: (160)),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _single_item(main_menu_items[index]);
                    },
                    childCount: main_menu_items.length,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return _list_item(sub_menu_items[index]);
                    },
                    childCount: sub_menu_items.length, // 1000 list items
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(top: 15),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: FxText.caption("FOLLOW US"),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(top: 5, left: 15, right: 10),
                              child: Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () => {
                                      Utils.launchOuLink(AppConfig.OurWhatsApp)
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 0),
                                      padding: EdgeInsets.all(3),
                                      child: Icon(
                                        Icons.whatsapp,
                                        size: 30,
                                        color: Colors.green.shade600,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade500,
                                              width: 1),
                                          color: AppTheme
                                              .lightTheme.backgroundColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(11))),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => {
                                      Utils.launchOuLink(
                                          AppConfig.OUR_FACEBOOK_LINK)
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 16),
                                      padding: EdgeInsets.all(3),
                                      child: Icon(
                                        Icons.facebook,
                                        size: 30,
                                        color: Colors.blue.shade800,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade500,
                                              width: 1),
                                          color: AppTheme
                                              .lightTheme.backgroundColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(11))),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => {
                                      Utils.launchOuLink(
                                          AppConfig.OUR_TWITTER_LINK)
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 16),
                                      padding: EdgeInsets.all(3),
                                      child: Icon(
                                        MdiIcons.twitter,
                                        size: 30,
                                        color: Colors.blue.shade500,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade500,
                                              width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(11))),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => {
                                      Utils.launchOuLink(
                                          AppConfig.OUR_INSTAGRAM_LINK)
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 16),
                                      padding: EdgeInsets.all(3),
                                      child: Icon(
                                        MdiIcons.instagram,
                                        size: 30,
                                        color: Colors.purple.shade300,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade500,
                                              width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(11))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FxSpacing.height(22),
                          ],
                        ),
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _list_item(MenuItemModel menu_item) {
    String badge = "1";
    return InkWell(
      onTap: () => {Utils.navigate_to(menu_item.screen, context)},
      child: Container(
        color: CustomTheme.primary,
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
                    color: theme.colorScheme.onBackground,
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
                      Icon(MdiIcons.chevronRight,
                          size: 22, color: theme.colorScheme.onBackground),
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
      child: Container(
        color: CustomTheme.primary,
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
      ),
    );
  }

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
}
