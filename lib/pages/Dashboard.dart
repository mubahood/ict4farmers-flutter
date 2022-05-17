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
import '../models/BannerModel.dart';
import '../models/FarmersGroup.dart';
import '../widget/my_widgets.dart';
import '../widget/shimmer_loading_widget.dart';

class Dashboard extends StatefulWidget {
  BuildContext _context;
  TabController tabController;

  Dashboard(this._context, this.tabController);

  @override
  DashboardState createState() => DashboardState(_context, tabController);
}

class DashboardState extends State<Dashboard> {
  late ThemeData theme;
  BuildContext _context;
  TabController tabController;

  List<BannerModel> menu_items = [
    new BannerModel(),
    new BannerModel(),
    new BannerModel(),
    new BannerModel(),
  ];

  DashboardState(this._context, this.tabController);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theme = AppTheme.theme;
    my_init();
  }

  animate_to_page() {
    this.tabController.animateTo(2);
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
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
          color: CustomTheme.primary,
          backgroundColor: Colors.white,
          onRefresh: _onRefresh,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                  titleSpacing: 0,
                  toolbarHeight: (Utils.screen_height(context) / 3),
                  title: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(80),
                          bottomRight: Radius.circular(80),
                        ),
                        child: Image(
                          width: double.infinity,
                          height: (Utils.screen_height(context) / 3),
                          fit: BoxFit.cover,
                          image: AssetImage("assets/project/farm_doodle.jpg"),
                        ),
                      ),
                      InkWell(
                        onTap: () => {
                          if (!is_logged_in)
                            {show_not_account_bottom_sheet(context)}
                          else
                            {Utils.navigate_to(AppConfig.AccountEdit, context)}
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
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        imageUrl: loggedUser.avatar,
                                        placeholder: (context, url) =>
                                            ShimmerLoadingWidget(
                                          height: 100,
                                          width: 100,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image(
                                          image: AssetImage(
                                              './assets/project/user.png'),
                                          height: 100,
                                          width: 100,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              onTap: () => {animate_to_page()},
                              child: FxContainer.rounded(
                                bordered: true,
                                border: Border.all(color: CustomTheme.primary),
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
                                border: Border.all(color: CustomTheme.primary),
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
                  floating: true,
                  backgroundColor: CustomTheme.primary),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio: 2,
                    mainAxisExtent: (160)),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _single_item();
                  },
                  childCount: menu_items.length,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => {},
                      child: _list_item(),
                    );
                  },
                  childCount: menu_items.length, // 1000 list items
                ),
              ),
            ],
          )),
    );
  }

  Widget _list_item() {
    String badge = "1";
    return Container(
      color: CustomTheme.primary,
      child: FxContainer(
        margin: EdgeInsets.only(left: 10, top: 10, bottom: 0, right: 10),
        padding: FxSpacing.all(20),
        bordered: true,
        border: Border.all(color: CustomTheme.primary, width: 1),
        child: InkWell(
          onTap: () {

          },
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
                  'Simple title...',
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
      ),
    );
  }

  Widget _single_item() {
    return Container(
      color: CustomTheme.primary,
      padding: EdgeInsets.only(left: 10, top: 20, right: 10),
      child: FxContainer(
        paddingAll: 0,
        bordered: true,
        width: MediaQuery.of(context).size.width / 2.3,
        border: Border.all(color: CustomTheme.primary, width: 1),
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image(
                image: AssetImage("assets/project/3.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FxText(
                '3.png',
                fontSize: 22,
                height: 1,
                fontWeight: 700,
                color: Colors.grey.shade900,
              ),
            ),
          ],
        ),
        color: Colors.white,
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
