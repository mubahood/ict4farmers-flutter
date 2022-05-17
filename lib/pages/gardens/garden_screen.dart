import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/UserModel.dart';
import '../../theme/app_theme.dart';
import '../../utils/Utils.dart';
import '../../widget/my_widgets.dart';

class GardenScreen extends StatefulWidget {
  GardenScreen();

  @override
  GardenScreenState createState() => GardenScreenState();
}

class GardenScreenState extends State<GardenScreen> {
  late ThemeData theme;
  String title = "My garden";

  GardenScreenState();

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
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          color: CustomTheme.primary,
          backgroundColor: Colors.white,
          onRefresh: _onRefresh,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                  iconTheme: IconThemeData(
                    color: Colors.white, // <= You can change your color here.
                  ),
                  titleSpacing: 0,
                  elevation: 0,
                  title: Text(title),
                  floating: false,
                  pinned: true,
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
                    return widget_grid_item(context,
                        title: "Title", asset_image: "Sub title");
                  },
                  childCount: ["1", 2, 3, 4, 6].length,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Text("Anjane");
                  },
                  childCount: [2, 4, 5, 6].length, // 1000 list items
                ),
              ),
            ],
          )),
    );
  }
}
