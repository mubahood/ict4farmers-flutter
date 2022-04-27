import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/container/container.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:flutx/widgets/widgets.dart';
import 'package:ict4farmers/models/UserModel.dart';
import 'package:ict4farmers/theme/app_theme.dart';
import 'package:ict4farmers/utils/AppConfig.dart';
import 'package:provider/provider.dart';

import '../../models/ProductModel.dart';
import '../../theme/app_notifier.dart';
import '../../utils/Utils.dart';
import '../../widget/empty_list.dart';
import '../../widget/shimmer_list_loading_widget.dart';
import '../../widget/shimmer_loading_widget.dart';
import '../product_add_form/product_add_form.dart';

class MyProductsScreen extends StatefulWidget {
  @override
  State<MyProductsScreen> createState() => MyProductsScreenState();
}

late CustomTheme customTheme;
String title = "My Products";
bool is_loading = false;

class MyProductsScreenState extends State<MyProductsScreen> {
  final PageController pageController = PageController(initialPage: 0);
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _do_refresh();
  }

  @override
  void dipose() {
    pageController.dispose();
  }

  UserModel userModel = new UserModel();
  List<ProductModel> items = [];
  bool is_logged_in = false;

  Future<Null> _onRefresh(BuildContext _context) async {
    is_loading = true;
    setState(() {});
    userModel = await Utils.get_logged_in();
    if (userModel.id < 1) {
      setState(() {
        is_loading = false;
      });
      //show_not_account_bottom_sheet(context);
      return;
    }

    is_logged_in = true;
    items = await ProductModel.get_user_products(userModel.id);
    setState(() {
      is_loading = false;
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
        builder: (BuildContext context, AppNotifier value, Widget? child) {
      return Scaffold(
          floatingActionButton: (!is_logged_in)
              ? FloatingActionButton(
                  onPressed: () {
                    Utils.navigate_to(AppConfig.AccountRegister, context);
                  },
                  backgroundColor: CustomTheme.primary,
                  child: Icon(Icons.person),
                  elevation: 5,
                )
              : FloatingActionButton(
                  onPressed: () {
                    open_add_product(context);
                  },
                  backgroundColor: CustomTheme.primary,
                  child: Icon(Icons.add),
                  elevation: 5,
                ),
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            elevation: 1,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
              child: is_loading
                  ? ShimmerListLoadingWidget()
                  : RefreshIndicator(
                      onRefresh: _do_refresh,
                      color: CustomTheme.primary,
                      backgroundColor: Colors.white,
                      child: (!is_logged_in)
                          ? EmptyList(
                              empty_image:
                                  "assets/project/on_board_toll_free.png",
                              body: "You are not logged in yet.",
                              action_text:
                                  "Press the user button to create an create account and access all features of ${AppConfig.AppName}")
                          : items.isEmpty
                              ? EmptyList(
                                  body:
                                      "You have no any farm product or service in your store.",
                                  action_text:
                                      "Press on the Plus (+) button to Add a new farm product.")
                              : CustomScrollView(
                                  slivers: [
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                          return Container(
                                            padding: EdgeInsets.all(10),
                                            child: SingleProduct(items[index]),
                                          );
                                        },
                                        childCount:
                                            items.length, // 1000 list items
                                      ),
                                    )
                                  ],
                                ))));
    });
  }

  Future<Null> _do_refresh() async {
    return await _onRefresh(context);
  }

  open_add_product(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductAddForm()),
    );

    if (result != null) {
      if (result['task'] != null) {
        if (result['task'] == 'success') {
          _do_refresh();
        }
      }
    }
  }

  SingleProduct(ProductModel item) {
    String thumbnail = item.get_thumbnail();

    double height = 100;
    return InkWell(
      onTap: () => {_show_bottom_sheet_product_actions(context)},
      child: Container(
        child: Row(
          children: [
            CachedNetworkImage(
              height: height,
              width: 150,
              fit: BoxFit.cover,
              imageUrl: thumbnail,
              placeholder: (context, url) => ShimmerLoadingWidget(
                  height: 100, width: 100, is_circle: false, padding: 0),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: FxContainer(
                height: height,
                paddingAll: 0,
                color: Colors.white,
                width: double.infinity,
                borderRadiusAll: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FxText(
                      item.name,
                      maxLines: 1,
                      fontSize: 18,
                      textAlign: TextAlign.start,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FxText(
                      "Seen by 42",
                      maxLines: 1,
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FxText(
                      "Liked by 42",
                      maxLines: 1,
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FxText(
                      "Posted by ${item.created_at}",
                      maxLines: 1,
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _show_bottom_sheet_product_actions(context) {
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
                    /* ListTile(
                      onTap: () => {
                        Utils.showSnackBar(
                            "Viewing details....", context, CustomTheme.orange)
                      },
                      dense: false,
                      leading: Icon(Icons.share,
                          color: theme.colorScheme.onBackground),
                      title: FxText.b1("Share", fontWeight: 600),
                    ),*/
                    ListTile(
                      onTap: () => {
                        Utils.showSnackBar(
                            "Sharing....", context, CustomTheme.orange)
                      },
                      dense: false,
                      leading: Icon(Icons.remove_red_eye_outlined,
                          color: theme.colorScheme.onBackground),
                      title: FxText.b1("View details", fontWeight: 600),
                    ),
                    /*              ListTile(
                        dense: false,
                        onTap: () => {
                              Utils.showSnackBar(
                                  "Edit....", context, CustomTheme.orange)
                            },
                        leading: Icon(Icons.edit,
                            color: theme.colorScheme.onBackground),
                        title: FxText.b1("Edit", fontWeight: 600)),*/
                    ListTile(
                        dense: false,
                        onTap: () => {
                              Utils.showSnackBar(
                                  "Deleting....", context, CustomTheme.orange)
                            },
                        leading: Icon(Icons.delete,
                            color: theme.colorScheme.onBackground),
                        title: FxText.b1("Delete", fontWeight: 600)),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
