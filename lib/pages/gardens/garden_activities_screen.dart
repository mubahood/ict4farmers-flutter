import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/widgets/text/text.dart';

import '../../models/GardenActivityModel.dart';
import '../../models/UserModel.dart';
import '../../theme/app_theme.dart';
import '../../utils/Utils.dart';

class GardenActivitiesScreen extends StatefulWidget {
  @override
  GardenActivitiesScreenState createState() => GardenActivitiesScreenState();
}

class GardenActivitiesScreenState extends State<GardenActivitiesScreen> {
  late ThemeData theme;

  GardenActivitiesScreenState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theme = AppTheme.theme;
    my_init();
  }

  List<GardenActivityModel> activities = [];

  Future<void> my_init() async {
    is_logged_in = true;
    setState(() {});

    loggedUser = await Utils.get_logged_in();
    if (loggedUser.id < 1) {
      Utils.showSnackBar("Not logged in.", context, Colors.white);
      Navigator.pop(context);
      return;
    }

    activities = await GardenActivityModel.get_items();

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
                    'My Activities',
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
                    return _widget_garden_activity_ui(activities[index]);
                  },
                  childCount: activities.length, // 1000 list items
                ),
              ),
            ],
          )),
    );
  }

  Widget _widget_garden_activity_ui(GardenActivityModel m) {
    return FxContainer(
        color: Colors.white,
        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: (Utils.screen_width(context) / 1.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText(
                          m.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontWeight: 800,
                        ),
                        FxText(
                          m.due_date,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
                Container(child: activity_status_widget(m)),
              ],
            ),
            Divider(
              height: 20,
              thickness: 1,
            ),
          ],
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

  activity_status_widget(GardenActivityModel m) {
    int status = m.get_status();

    return (status == 5)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FxText(
                'Done',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                color: Colors.green.shade600,
                fontWeight: 800,
              ),
              Icon(
                Icons.close,
                color: Colors.green.shade600,
              ),
            ],
          )
        : (status == 4)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FxText(
                    'Missed',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.red.shade600,
                    fontWeight: 800,
                  ),
                  Icon(
                    Icons.close,
                    color: Colors.red.shade600,
                  ),
                ],
              )
            : (status == 2)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FxText(
                        'Missing',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.red.shade600,
                        fontWeight: 800,
                      ),
                      Icon(
                        Icons.warning,
                        color: Colors.red.shade600,
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FxText(
                        'Pending',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.grey.shade600,
                        fontWeight: 800,
                      ),
                      Icon(
                        Icons.alarm_outlined,
                        color: Colors.grey.shade600,
                      ),
                    ],
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
