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
                    item.name,
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
                    mainAxisExtent: (180)),
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
      item.title = "Garden activities";
      item.all = "ALL";
      item.all_text = "25";
      item.done = "DONE";
      item.done_text = "10";
      item.complete = "REMAINING";
      item.complete_text = "11";
    } else if (index == 1) {
      item.title = "Financial records";
      item.all = "EXPENSE";
      item.all_text = "UGX 25";
      item.done = "INCOME";
      item.done_text = "10";
      item.complete = "PROFIT/LOSS";
      item.complete_text = " 11";
    } else if (index == 2) {
      item.title = "Garden records";
      item.all = "All records";
      item.all_text = "25";
      item.done = "INCOME";
      item.done_text = "10";
      item.complete = "PROFIT/LOSS";
      item.complete_text = " 11";
    } else if (index == 3) {
      item.title = "Garden's gallery";
      item.all = "All albums";
      item.all_text = "8";
      item.done = "INCOME";
      item.done_text = "10";
      item.complete = "PROFIT/LOSS";
      item.complete_text = " 11";
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
                fontSize: 20,
              ),
              Spacer(),
              my_rich_text(
                  item.all, item.all_text.toString(), Colors.grey.shade800),
              (index > 1)
                  ? SizedBox()
                  : my_rich_text(item.done, item.done_text.toString(),
                      Colors.grey.shade800),
              (index > 1)
                  ? SizedBox()
                  : my_rich_text(item.complete, item.complete_text.toString(),
                      Colors.grey.shade800),
              Spacer(),
              FxContainer(
                child: FxText(
                  "See All",
                  fontSize: 16,
                  fontWeight: 700,
                  color: CustomTheme.primary,
                ),
                paddingAll: 0,
                padding: EdgeInsets.only(top: 2, bottom: 2),
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

                    Container(
                      padding: EdgeInsets.only(top: 5),
                      width: (Utils.screen_width(context) / 1.5),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'CROP: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: '${item.crop_category_name}, ',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                                text: 'PLANTED: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: '${item.plant_date}, ',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                                text: 'LAND SIZE: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: '${item.size} acres, ',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                                text: 'LOCATION: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: '${item.location_name} acres, ',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText(
                      '%40',
                      fontWeight: 800,
                      fontSize: 40,
                      height: .8,
                      color: Colors.white,
                    ),
                    FxText(
                      'Done',
                      height: .8,
                      fontWeight: 400,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ));
  }

  Widget my_rich_text(String t, String s, Color c) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
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
