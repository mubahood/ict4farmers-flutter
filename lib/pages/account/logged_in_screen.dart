import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/utils/color_utils.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/button/button.dart';
import 'package:flutx/widgets/container/container.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:ict4farmers/models/FormItemModel.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../models/UserModel.dart';
import '../../theme/app_theme.dart';
import '../../theme/custom_theme.dart';
import '../../utils/AppConfig.dart';
import '../../utils/Utils.dart';
import '../../widget/my_widgets.dart';
import '../../widget/shimmer_loading_widget.dart';
import '../product_add_form/product_add_form.dart';

class LoggedInScreen extends StatefulWidget {
  ThemeData theme;
  BuildContext _context;

  LoggedInScreen(this.theme, this._context);

  @override
  LoggedInScreenState createState() =>
      LoggedInScreenState(this.theme, _context);
}

class LoggedInScreenState extends State<LoggedInScreen> {
  ThemeData theme;
  BuildContext _context;

  LoggedInScreenState(this.theme, this._context);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    my_init();
    check_daft_form();
  }

  bool _has_pending_form = false;
  UserModel logged_in_user = new UserModel();

  void check_daft_form() async {
    if ((await FormItemModel.get_all()).isEmpty) {
      _has_pending_form = false;
    } else {
      _has_pending_form = true;
    }
  }

  Future<void> my_init() async {
    logged_in_user = await Utils.get_logged_in();
    if (logged_in_user.id < 1) {
      Utils.showSnackBar("Login before you proceed.", _context, Colors.red);
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding:
          FxSpacing.fromLTRB(20, FxSpacing.safeAreaTop(_context) + 20, 20, 20),
      children: <Widget>[
        Column(
          children: <Widget>[
            FxContainer.rounded(
              paddingAll: 0,
              width: 100,
              height: 100,
              child: CachedNetworkImage(
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                imageUrl: logged_in_user.avatar,
                placeholder: (context, url) => ShimmerLoadingWidget(
                  height: 100,
                  width: 100,
                ),
                errorWidget: (context, url, error) => Image(
                  image: AssetImage('./assets/project/no_image.jpg'),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            FxSpacing.height(8),
            FxText.sh1(logged_in_user.name, fontWeight: 600, letterSpacing: 0),
          ],
        ),
        FxSpacing.height(24),
        InkWell(
          onTap: ()=>{
            Utils.launchPhone(AppConfig.OUR_PHONE_NUMBER)
          },
          child: FxContainer(
            color: CustomTheme.accent,
            padding: FxSpacing.xy(16, 8),
            borderRadiusAll: 4,
            child: Row(
              children: <Widget>[
                Icon(MdiIcons.informationOutline,
                    color: theme.colorScheme.onPrimary, size: 18),
                FxSpacing.width(16),
                Expanded(
                  child: FxText.b2("Need help?",
                      color: FxColorUtils.goldColor,
                      fontWeight: 600,
                      letterSpacing: 0.2),
                ),
                FxSpacing.width(16),
                FxText.caption(
                  "Call Free Now!",
                  fontWeight: 600,
                  letterSpacing: 0.2,
                  color: theme.colorScheme.onPrimary,
                )
              ],
            ),
          ),
        ),
        FxSpacing.height(24),
        Column(
          children: <Widget>[
            singleOption(
              _context,
              theme,
              iconData: Icons.question_answer_outlined,
              option: "Extension services",
              navigation: '',
            ),
            Divider(),
            singleOption(_context, theme,
                iconData: Icons.agriculture_outlined,
                option: "Farm management",
                navigation: ""),
            Divider(),
            singleOption(_context, theme,
                iconData: Icons.task_alt,
                option: "Enterprise selection",
                navigation: ""),
            Divider(),
            singleOption(_context, theme,
                iconData: Icons.sell,
                option: "Farm products pricing",
                navigation: ""),
            Divider(),
            singleOption(_context, theme,
                iconData: Icons.inventory_2_outlined,
                option: "My products",
                navigation: AppConfig.MyProductsScreen),
            Divider(),
            singleOption(_context, theme,
                iconData: Icons.assignment_ind_outlined,
                option: "My Profile",
                navigation: AppConfig.AccountEdit),
            Divider(),
            singleOption(_context, theme,
                iconData: Icons.bolt,
                option: "How to sell faster",
                navigation: AppConfig.SellFast),
            Divider(),
            singleOption(_context, theme,
                iconData: Icons.emoji_objects_outlined,
                option: "About This App",
                navigation: AppConfig.PrivacyPolicy),
            Divider(),
            singleOption(_context, theme,
                iconData: Icons.security,
                option: "Privacy policy",
                navigation: AppConfig.PrivacyPolicy),
            Divider(),
            singleOption(_context, theme,
                iconData: Icons.live_help_outlined,
                option: "Ask an expert",
                navigation: ""),
            Divider(),
            singleOption(_context, theme,
                iconData: MdiIcons.faceAgent,
                option: "Toll Free",
                navigation: ""),
            Divider(),
            FxSpacing.height(24),
            social_media_links(context),
            FxSpacing.height(24),
            Center(
              child: FxButton(
                elevation: 0,
                backgroundColor: CustomTheme.primary,
                borderRadiusAll: 4,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      MdiIcons.logoutVariant,
                      color: CustomTheme.onPrimary,
                      size: 18,
                    ),
                    FxSpacing.width(16),
                    FxText.caption("LOGOUT",
                        letterSpacing: 0.3,
                        fontWeight: 600,
                        color: CustomTheme.onPrimary)
                  ],
                ),
                onPressed: () {
                  do_logout();
                },
              ),
            ),
          ],
        )
      ],
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
      padding: FxSpacing.y(10),
      child: InkWell(
        onTap: () {
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostScreen()),
          );

          return;*/
          if (navigation == AppConfig.ProductAddForm) {
            _show_bottom_sheet_sell_or_buy(_context);
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
                size: 30,
                color: CustomTheme.primary,
              ),
            ),
            FxSpacing.width(16),
            Expanded(
              child: FxText.b1(
                option,
                fontWeight: 600,
                fontSize: 18,
              ),
            ),
            Container(
              child: Row(
                children: [
                  badge.toString().isEmpty
                      ? SizedBox()
                      : FxContainer(
                          paddingAll: 5,
                          borderRadiusAll: 30,
                          color: Colors.red.shade500,
                          child: Text(
                            "12",
                            style: TextStyle(color: Colors.white),
                          )),
                  Icon(MdiIcons.chevronRight,
                      size: 30, color: CustomTheme.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

  Future<void> do_logout() async {
    await Utils.logged_out();
    Utils.showSnackBar("Logged out successfully.", _context, Colors.white);
    my_init();
  }
}
