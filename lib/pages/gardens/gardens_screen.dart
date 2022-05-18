import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ict4farmers/models/GardenModel.dart';

import '../../models/UserModel.dart';
import '../../theme/app_theme.dart';
import '../../utils/AppConfig.dart';
import '../../utils/Utils.dart';
import '../../widget/my_widgets.dart';

class GardensScreen extends StatefulWidget {
  GardensScreen();

  @override
  GardensScreenState createState() => GardensScreenState();
}

class GardensScreenState extends State<GardensScreen> {
  late ThemeData theme;
  String title = "My gardens";

  GardensScreenState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theme = AppTheme.theme;
    my_init();
  }

  List<GardenModel> gardens = [];

  Future<void> my_init() async {
    Utils.ini_theme();

    is_logged_in = true;
    setState(() {});

    loggedUser = await Utils.get_logged_in();
    if (loggedUser.id < 1) {
      Navigator.pop(context);
      return;
    }

    gardens = await GardenModel.get_items();


    is_logged_in = false;
    setState(() {});
  }

  bool is_logged_in = false;
  UserModel loggedUser = new UserModel();

  Future<Null> _onRefresh() async {
    my_init();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            {Utils.navigate_to(AppConfig.GardenCreateScreen, context)},
        tooltip: 'Create new garden.',
        backgroundColor: CustomTheme.primary,
        child: const Icon(Icons.add),
      ),
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
                    my_colors.shuffle();
                    return widget_grid_item(context,
                        title: gardens[index].name,
                        id: gardens[index].id.toString(),
                        screen: AppConfig.GardenScreen,
                        caption: gardens[index].created_at,
                        bg_color: gardens[index].color);
                  },
                  childCount: gardens.length,
                ),
              ),
            ],
          )),
    );
  }
}
