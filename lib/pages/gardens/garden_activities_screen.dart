import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/widgets/text/text.dart';

import '../../models/GardenActivityModel.dart';
import '../../models/UserModel.dart';
import '../../theme/app_theme.dart';
import '../../utils/AppConfig.dart';
import '../../utils/Utils.dart';

class GardenActivitiesScreen extends StatefulWidget {
  dynamic params;

  GardenActivitiesScreen(this.params);

  @override
  GardenActivitiesScreenState createState() => GardenActivitiesScreenState();
}

class GardenActivitiesScreenState extends State<GardenActivitiesScreen> {
  late ThemeData theme;
  int id = 0;

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

    if (widget.params != null) {
      if (widget.params['id'] != null) {
        id = Utils.int_parse(widget.params['id'].toString());
      }
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Utils.navigate_to(AppConfig.GardenActivityCreateScreen, context,data: {
            'garden_id':id,
            'activity_text':'Activity name',
            'enterprise_text':'Garden name',
          });
        },
        backgroundColor: CustomTheme.primary,
        child: Icon(Icons.add),
        elevation: 5,
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
                  title: FxText(
                    'Production Activities',
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

  void _show_details_bottom_sheet(context, GardenActivityModel m) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext buildContext) {
          return DraggableScrollableSheet(
              initialChildSize: 0.75,
              //set this as you want
              maxChildSize: 0.75,
              //set this as you want
              minChildSize: 0.75,
              //set this as you want
              expand: true,
              builder: (context, scrollController) {
                return Container(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16))),
                    child: _details_bottom_sheet_content(context, m),
                  ),
                );
              });
        });
  }

  Widget _details_bottom_sheet_content(
      BuildContext context, GardenActivityModel m) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 30, right: 30),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 40,
              right: 20,
            ),
            child: Row(
              children: [
                Expanded(
                    child: FxButton.outlined(
                  borderRadiusAll: 10,
                  borderColor: CustomTheme.accent,
                  splashColor: CustomTheme.primary.withAlpha(40),
                  padding: FxSpacing.y(12),
                  onPressed: () {
                    Utils.navigate_to(AppConfig.SubmitActivityScreen, context);
                  },
                  child: FxText.l1(
                    "SUBMIT REPORT",
                    color: CustomTheme.accent,
                    letterSpacing: 0.5,
                  ),
                )),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: FxButton(
                  elevation: 0,
                  padding: FxSpacing.y(12),
                  borderRadiusAll: 4,
                  onPressed: () {
                    Utils.navigate_to(AppConfig.AccountLogin, context);
                  },
                  child: FxText.l1(
                    "DELETE ACTIVITY",
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                  backgroundColor: CustomTheme.primary,
                )),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _widget_garden_activity_ui(GardenActivityModel m) {
    return InkWell(
      onTap: () => {_show_details_bottom_sheet(context, m)},
      child: FxContainer(
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
          )),
    );
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
                    FxText('Overview',color: Colors.white,fontSize: 45,fontWeight: 400,),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      width: (Utils.screen_width(context) / 1.6),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(height: 1.2,
                            fontSize: 16

                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Enterprize: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: 'xxxxx\n',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                                text: 'All activities: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: '13\n',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                                text: 'SUBMITTED: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: '11\n',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                                text: 'MISSING: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: '1\n',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),

                            TextSpan(
                                text: 'MISSED: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: '1\n',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),


                            TextSpan(
                                text: 'DONE: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: '1\n',
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
                      'Completed',
                      height: .8,
                      fontWeight: 400,
                      fontSize: 16.5,
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
