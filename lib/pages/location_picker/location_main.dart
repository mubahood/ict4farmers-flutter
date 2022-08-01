import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutx/icons/box_icon/box_icon_data.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/container/container.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:flutx/widgets/widgets.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../models/CategoryModel.dart';
import '../../models/UserModel.dart';
import '../../theme/app_theme.dart';
import '../../utils/AppConfig.dart';
import '../../widget/loading_widget.dart';
import '../../widgets/images.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../models/BannerModel.dart';
import '../../models/LocationModel.dart';
import '../../models/ProductModel.dart';
import '../../models/FormItemModel.dart';
import '../../theme/app_notifier.dart';
import '../../theme/material_theme.dart';
import '../../utils/Utils.dart';
import '../../widget/shimmer_list_loading_widget.dart';
import '../../widget/shimmer_loading_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'location_sub.dart';

class LocationMain extends StatefulWidget {
  @override
  State<LocationMain> createState() => LocationMainState();
}

late CustomTheme customTheme;
String title = "Pick a region";
bool is_loading = false;

class LocationMainState extends State<LocationMain> {
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

  List<LocationModel> items = [];

  Future<Null> _onRefresh(BuildContext _context) async {
    is_loading = true;
    setState(() {});
    List<LocationModel> _items = await LocationModel.get_all();
    items.clear();
    _items.forEach((element) {
      if (element.parent_id < 1) {
        items.add(element);
      }
    });

    items.sort((a, b) => a.name.compareTo(b.name));
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
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          elevation: .5,
          title: Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: is_loading
              ? ShimmerListLoadingWidget()
              : RefreshIndicator(
                  onRefresh: _do_refresh,
                  color: CustomTheme.primary,
                  backgroundColor: Colors.white,
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return SingleProduct(items[index]);
                          },
                          childCount: items.length, // 1000 list items
                        ),
                      )
                    ],
                  ),
                ),
        ),
      );
    });
  }

  Future<Null> _do_refresh() async {
    return await _onRefresh(context);
  }

  SingleProduct(LocationModel item) {
    return ListTile(
      dense: true,
      title: FxText.h3(item.name, fontWeight: 400, fontSize: 20),
      onTap: () {
        pick_location(item);
      },
    );
  }

  Future<void> pick_location(LocationModel item) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LocationSub({
                'parent_id': item.id.toString(),
              })),
    );

    if (result != null) {
      if ((result['location_sub_id'] != null) &&
          (result['location_sub_name'] != null)) {
        Navigator.pop(context, {
          "location_sub_id": result['location_sub_id'],
          "location_sub_name":
              item.name + ", " + result['location_sub_name'].toString()
        });
      }
    }
  }
}
