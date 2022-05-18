import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:ict4farmers/models/GardenModel.dart';

import '../../models/UserModel.dart';
import '../../theme/app_theme.dart';
import '../../utils/Utils.dart';

class GardenScreen extends StatefulWidget {
  GardenScreen(this.params);

  dynamic params;

  @override
  GardenScreenState createState() => GardenScreenState();
}

class GardenScreenState extends State<GardenScreen> {
  late ThemeData theme;
  String title = "Garden overview";

  GardenScreenState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theme = AppTheme.theme;
    my_init();
  }

  GardenModel item = new GardenModel();
  String id = "";

  Future<void> my_init() async {
    is_logged_in = false;
    setState(() {});

    if (widget.params != null) {
      if (widget.params['id'] != null) {
        id = widget.params['id'].toString();
      }
    }
    List<GardenModel> gardens = [];
    gardens = await GardenModel.get_items();
    gardens.forEach((element) {
      if (element.id.toString() == id) {
        item = element;
      }
    });
    if (item.id < 1) {
      Utils.showSnackBar("Garden not found.", context, Colors.white);
      Navigator.pop(context);
      return;
    }

    loggedUser = await Utils.get_logged_in();
    if (loggedUser.id < 1) {
      Utils.showSnackBar("Not logged in.", context, Colors.white);
      Navigator.pop(context);
      return;
    }
    is_logged_in = true;
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
                  title: FxText(
                    title,
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: 500,
                  ),
                  floating: false,
                  pinned: true,
                  backgroundColor: CustomTheme.primary),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return _widget_overview();
                  },
                  childCount: 1, // 1000 list items
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio: 2,
                    mainAxisExtent: (160)),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _widget_grid_item(index);
                  },
                  childCount: [2, 3, 4, 6].length,
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

  Widget _widget_grid_item(int index) {
    GridItemWidget item = new GridItemWidget();
    if (index == 0) {
      item.title = "Activities";
      item.all = "ALL";
      item.all_text = "25";
      item.done = "DONE";
      item.done_text = "10";
      item.complete = "REMAINING";
      item.complete_text = "11";
    }

    return InkWell(
      onTap: () => {
        Utils.navigate_to((index == 1) ? "" : "", context, data: {'id': id})
      },
      child: Container(
        color: CustomTheme.primary,
        child: FxContainer(
          paddingAll: 10,
          marginAll: 10,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FxText(
                item.title,
                color: CustomTheme.primary,
                fontWeight: 800,
                height: 1.0,
                fontSize: 22,
              ),
              Container(
                height: 10,
              ),
              my_rich_text(
                  item.all, item.all_text.toString(), Colors.grey.shade800),
              my_rich_text(
                  item.done, item.done_text.toString(), Colors.grey.shade800),
              my_rich_text(item.complete, item.complete_text.toString(),
                  Colors.grey.shade800),
              FxContainer(
                child: FxText(
                  "See All",
                  fontSize: 16,
                  fontWeight: 700,
                  color: CustomTheme.primary,
                ),
                paddingAll: 0,
                padding: EdgeInsets.only(top: 2, bottom: 2),
                margin: EdgeInsets.only(top: 5),
                color: CustomTheme.primary.withAlpha(20),
                alignment: Alignment.center,
                width: double.infinity,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _widget_overview() {
    return FxContainer(
        borderRadiusAll: 0,
        color: CustomTheme.primary,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText(
                      item.name,
                      color: Colors.white,
                      fontWeight: 800,
                      fontSize: 25,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FxText(
                      item.plant_date,
                      fontWeight: 500,
                      fontSize: 14,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
                FxText(
                  '%40',
                  fontWeight: 800,
                  fontSize: 40,
                  color: Colors.white,
                ),
              ],
            ),
            Container(
              height: 15,
            ),
            my_rich_text(
                "CROP", item.crop_category_id.toString(), Colors.white),
            my_rich_text("PLANTED", item.plant_date.toString(), Colors.white),
            my_rich_text("GARDEN SIZE", item.size.toString(), Colors.white),
            my_rich_text("LOCATION", item.location_id.toString(), Colors.white),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ));
  }

  Widget my_rich_text(String t, String s, Color c) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: '${t}: ',
                style: TextStyle(fontWeight: FontWeight.bold, color: c)),
            TextSpan(
                text: '${s}',
                style: TextStyle(fontWeight: FontWeight.normal, color: c)),
          ],
        ),
      ),
    );
  }
}

class GridItemWidget {
  String title = "Title";

  String all = "Title";
  String all_text = "Title";

  String done = "Title";
  String done_text = "Title";

  String complete = "Title";
  String complete_text = "Title";
}
