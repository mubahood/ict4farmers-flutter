import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/container/container.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:ict4farmers/pages/product_add_form/product_add_form.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../models/UserModel.dart';
import '../../theme/app_theme.dart';
import '../../utils/AppConfig.dart';
import '../../utils/Utils.dart';
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
  }

  bool is_logged_in = false;
  UserModel loggedUser = new UserModel();

  @override
  Widget build(BuildContext context) {
    Utils.ini_theme();

    return SafeArea(
      child: Column(
        children: [
          Stack(
            children: [
              Image(
                width: double.infinity,
                image: AssetImage("assets/project/farm_doodle.jpg"),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(35),
                    topLeft: Radius.circular(35),
                  ),
                ),
                margin: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height / 3.8),
                ),
                width: double.infinity,
                height: ((MediaQuery.of(context).size.height) -
                    (MediaQuery.of(context).size.height / 2.75)),
                child: ListView(
                  children: [
                    /*FxContainer(
                        padding: EdgeInsets.only(
                            top: 20, left: 15, right: 15, bottom: 20),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            widget_item_counter(context),
                            widget_item_counter(context),
                            widget_item_counter(context),
                          ],
                        )),*/
                    FxContainer(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(35),
                          topLeft: Radius.circular(35),
                        ),
                        paddingAll: 0,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: 30, left: 20, right: 20, bottom: 0),
                              child: Row(
                                children: [

                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 15, left: 20, right: 20, bottom: 15),
                              child: Row(
                                children: [

                                ],
                              ),
                            ),
                            singleOption(_context, theme,
                                iconData: Icons.people,
                                option: "My Workers",
                                navigation: AppConfig.MyProductsScreen),
                            singleOption(_context, theme,
                                iconData: MdiIcons.calendar,
                                option: "My farm calender",
                                navigation: AppConfig.MyProductsScreen),
                            singleOption(_context, theme,
                                iconData: MdiIcons.receipt,
                                option: "My farm records",
                                navigation: AppConfig.MyProductsScreen),
                            singleOption(_context, theme,
                                iconData: MdiIcons.tableNetwork,
                                option: "My farm activities",
                                navigation: AppConfig.MyProductsScreen),
                            singleOption(_context, theme,
                                iconData: MdiIcons.shapeOutline,
                                option: "My Products & Services",
                                navigation: AppConfig.MyProductsScreen),
                            singleOption(_context, theme,
                                iconData: Icons.forum,
                                option: "Browse farmers",
                                navigation: AppConfig.MyProductsScreen),
                            singleOption(_context, theme,
                                iconData: MdiIcons.accountEdit,
                                option: "Extension services",
                                navigation: AppConfig.MyProductsScreen),
                            singleOption(_context, theme,
                                iconData: Icons.sell,
                                option: "Products Pricing",
                                navigation: AppConfig.MyProductsScreen),
                            singleOption(_context, theme,
                                iconData: Icons.question_answer_outlined,
                                option: "Ask an expert",
                                navigation: AppConfig.MyProductsScreen),
                            singleOption(_context, theme,
                                iconData: Icons.info,
                                option: "About this App",
                                navigation: AppConfig.MyProductsScreen),
                            singleOption(_context, theme,
                                iconData: Icons.policy,
                                option: "Privacy policy",
                                navigation: AppConfig.MyProductsScreen),
                            singleOption(_context, theme,
                                iconData: Icons.info,
                                option: "Privacy policy",
                                navigation: AppConfig.MyProductsScreen),
                            singleOption(_context, theme,
                                iconData: Icons.help,
                                option: "Help & Support",
                                navigation: AppConfig.MyProductsScreen),
                            singleOption(_context, theme,
                                iconData: Icons.call,
                                option: "Toll free",
                                navigation: AppConfig.MyProductsScreen),
                            Divider(),
                            Container(
                              margin: EdgeInsets.only(top: 10, left: 25),
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
                                          color: Colors.white,
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
                                          color: Colors.white,
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
                            FxSpacing.height(24),
                          ],
                        ))
                  ],
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
                    top: (MediaQuery.of(context).size.height / 9.4),
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
                          errorWidget: (context, url, error) => Image(
                            image:
                            AssetImage('./assets/project/user.png'),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Image(
                          width: 80,
                          height: 80,
                          image: AssetImage("./assets/project/user.png"),
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
                  left: 10,
                  right: 10,
                  top: 10,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () =>
                      {Utils.launchPhone(AppConfig.OUR_PHONE_NUMBER)},
                      child: Container(
                        child: Row(
                          children: [
                            FxContainer.rounded(
                              bordered: true,
                              border: Border.all(color: CustomTheme.primary),
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
                                  top: 3, bottom: 3, left: 10, right: 10),
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
                      onTap: () => {},
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
        ],
      ),
    );
  }

  void _show_bottom_sheet_sell_or_buy(context) {

    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: theme.backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Padding(
                padding: FxSpacing.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      onTap: () => {open_add_product(context)},
                      dense: false,
                      leading: Icon(Icons.sell,
                          color: theme.colorScheme.onBackground),
                      title: FxText.b1("Sell something", fontWeight: 600),
                    ),
                    ListTile(
                        dense: false,
                        onTap: () => {open_add_product(context)},
                        leading: Icon(Icons.campaign,
                            color: theme.colorScheme.onBackground),
                        title: FxText.b1("Look for something to buy",
                            fontWeight: 600)),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget singleOption(_context, theme,
      {IconData? iconData,
        required String option,
        String navigation: "",
        String badge: ""}) {
    return FxContainer(
      color: Colors.white,
      margin: EdgeInsets.only(left: 20, top: 0, bottom: 10, right: 20),
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

}
