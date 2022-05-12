import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/container/container.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:ict4farmers/models/ChatModel.dart';
import 'package:ict4farmers/models/FormItemModel.dart';
import 'package:ict4farmers/pages/product_add_form/product_add_form.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../models/UserModel.dart';
import '../../theme/app_theme.dart';
import '../../utils/AppConfig.dart';
import '../../utils/Utils.dart';
import '../widget/my_widgets.dart';

class Dashboard extends StatefulWidget {
  BuildContext _context;

  Dashboard(this._context);

  @override
  DashboardState createState() => DashboardState(_context);
}

class DashboardState extends State<Dashboard> {
  late ThemeData theme;
  BuildContext _context;
  UserModel logged_in_user = new UserModel();

  DashboardState(this._context);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theme = AppTheme.theme;
    my_init();
  }

  bool _has_pending_form = false;
  List<ChatModel> chat_threads = [];

  Future<void> my_init() async {
    logged_in_user = await Utils.get_logged_in();
    if (logged_in_user.id < 1) {
      Utils.showSnackBar("Login before you proceed.", _context, Colors.red);
      return;
    }
    chat_threads = await ChatModel.get_threads(logged_in_user.id);
    await check_daft_form();
    setState(() {});
  }

  Future<void> check_daft_form() async {
    if ((await FormItemModel.get_all()).isEmpty) {
      _has_pending_form = false;
    } else {
      _has_pending_form = true;
    }
  }

  @override
  Widget build(BuildContext context) {
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
         
                child: ListView(
                  children: [
                    FxContainer(
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
                        )),
                    FxContainer(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(35),
                          topLeft: Radius.circular(35),
                        ),
                        paddingAll: 0,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: 30, left: 15, right: 15, bottom: 0),
                              child: Row(
                                children: [
                                  widget_dashboard_item(context),
                                  Spacer(),
                                  widget_dashboard_item(context),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 15, left: 15, right: 15, bottom: 25),
                              child: Row(
                                children: [
                                  widget_dashboard_item(context),
                                  Spacer(),
                                  widget_dashboard_item(context),
                                ],
                              ),
                            ),
                            FxText(
                              "1",
                              fontSize: 50,
                            ),
                            FxText(
                              "1",
                              fontSize: 50,
                            ),
                            FxText(
                              "1",
                              fontSize: 50,
                            ),
                            FxText(
                              "1",
                              fontSize: 50,
                            ),
                            FxText(
                              "1",
                              fontSize: 50,
                            ),
                            FxText(
                              "1",
                              fontSize: 50,
                            ),
                            FxText(
                              "1",
                              fontSize: 50,
                            ),
                            FxText(
                              "2",
                              fontSize: 50,
                            ),
                            FxText(
                              "3",
                              fontSize: 50,
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: (MediaQuery.of(context).size.height / 8),
                ),
                child: Row(
                  children: [
                    FxContainer.rounded(
                      paddingAll: 0,
                      color: CustomTheme.primary,
                      child: Image(
                        width: 70,
                        height: 70,
                        image: AssetImage("assets/project/no_chat.png"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: FxText.h1(
                        "Tusiime bob",
                        fontWeight: 700,
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                    /* Container(
                      child:
                      FxText.h2("Bob Tusiime"),
                    )*/
                  ],
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
                    FxContainer.rounded(
                      color: Colors.transparent,
                      child: Icon(
                        Icons.home,
                        size: 25,
                      ),
                    ),
                    Spacer(),
                    FxContainer.rounded(
                      bordered: true,
                      border: Border.all(color: CustomTheme.primary),
                      paddingAll: 10,
                      splashColor: CustomTheme.primary,
                      color: Colors.white,
                      child: Icon(
                        Icons.shopping_cart,
                        size: 25,
                      ),
                    ),
                    FxContainer.rounded(
                      margin: EdgeInsets.only(left: 10),
                      paddingAll: 11,
                      splashColor: CustomTheme.primary,
                      color: Colors.white,
                      child: Icon(
                        Icons.sort,
                        size: 25,
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
    return Container(
      padding: FxSpacing.y(8),
      child: InkWell(
        onTap: () {
          //print("======> ${logged_in_user.avatar}");
          //return;
          //Utils.navigate_to(AppConfig.MyProductsScreen, _context);
          //return;
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
              child: FxText.b1(option, fontWeight: 600),
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
