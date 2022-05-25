import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/widgets/text/text.dart';

import '../../models/GardenActivityModel.dart';
import '../../models/GardenProductionModel.dart';
import '../../models/UserModel.dart';
import '../../theme/app_theme.dart';
import '../../utils/AppConfig.dart';
import '../../utils/Utils.dart';
import '../../widget/shimmer_loading_widget.dart';

class GardenProductionRecordScreen extends StatefulWidget {
  GardenProductionRecordScreen(this.params);

  dynamic params;

  @override
  GardenProductionRecordScreenState createState() =>
      GardenProductionRecordScreenState();
}

class GardenProductionRecordScreenState
    extends State<GardenProductionRecordScreen> {
  late ThemeData theme;

  GardenProductionRecordScreenState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theme = AppTheme.theme;
    my_init();
  }

  String id = "";
  GardenProductionModel gardenProductionModel = new GardenProductionModel();
  List<String> thumbnails = [];
  List<String> photos = [];

  Future<void> my_init() async {
    is_logged_in = true;
    setState(() {});

    if (widget.params != null) {
      if (widget.params['id'] != null) {
        id = widget.params['id'].toString();
      }
    }

    List<GardenProductionModel> items = await GardenProductionModel.get_items();
    items.forEach((element) {
      if (element.id.toString() == id.toString()) {
        gardenProductionModel = element;
      }
    });
    thumbnails = gardenProductionModel.get_images(true);
    photos = gardenProductionModel.get_images(false);

    loggedUser = await Utils.get_logged_in();
    if (loggedUser.id < 1) {
      Navigator.pop(context);
      return;
    }

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
                    'Production record',
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
                    return FxContainer(
                      borderRadiusAll: 0,
                      color: Colors.white,
                      child: FxText.h2(
                        "Photos",
                        color: Colors.black,
                      ),
                    );
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
                    mainAxisExtent: (170)),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return InkWell(
                      onTap: () => {
                        Utils.navigate_to(
                            AppConfig.ViewFullImagesScreen, context,
                            data: photos)
                      },
                      child: FxContainer(
                          bordered: true,
                          border: Border.all(color: CustomTheme.primary),
                          margin: index.isEven
                              ? EdgeInsets.only(left: 20, right: 5, bottom: 10)
                              : EdgeInsets.only(left: 5, right: 10, bottom: 10),
                          paddingAll: 0,
                          color: Colors.white,
                          borderRadiusAll: 0,
                          child: CachedNetworkImage(
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            imageUrl: thumbnails[index].toString(),
                            placeholder: (context, url) => ShimmerLoadingWidget(
                              height: 100,
                              width: 100,
                            ),
                            errorWidget: (context, url, error) => Image(
                              image:
                                  AssetImage('./assets/project/no_image.jpg'),
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          )),
                    );
                  },
                  childCount: thumbnails.length,
                ),
              ),
            ],
          )),
    );
  }

  Widget _widget_garden_activity_ui(GardenActivityModel m) {
    return FxContainer(
        color: Colors.white,
        padding: EdgeInsets.only(top: 0, left: 15, right: 10),
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

  Widget _widget_overview() {
    return FxContainer(
        borderRadiusAll: 0,
        color: CustomTheme.primary,
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(bottom: 20),
                child: FxText(
                  gardenProductionModel.garden_name,
                  color: Colors.white,
                  fontSize: 45,
                  fontWeight: 400,
                )),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  height: 1.2,
                  fontSize: 16,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Description\n',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  TextSpan(
                    text: '${gardenProductionModel.description}, ',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                  ),
                ],
              ),
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

  String screen = '';
}
