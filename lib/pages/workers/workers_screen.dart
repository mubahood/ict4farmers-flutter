import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:ict4farmers/models/WorkerModel.dart';

import '../../models/WorkerModel.dart';
import '../../theme/app_theme.dart';
import '../../utils/AppConfig.dart';
import '../../utils/Utils.dart';
import '../../widget/shimmer_loading_widget.dart';

class WorkersScreen extends StatefulWidget {
  @override
  WorkersScreenState createState() => WorkersScreenState();
}

class WorkersScreenState extends State<WorkersScreen> {
  late ThemeData theme;

  WorkersScreenState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theme = AppTheme.theme;
    my_init();
  }

  List<WorkerModel> items = [];

  Future<void> my_init() async {
    WorkerModel.get_items();

    setState(() {});

    items = await WorkerModel.get_items();

    setState(() {});
  }

  Future<Null> _onRefresh() async {
    my_init();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Utils.navigate_to(AppConfig.PestCaseCreateScreen, context);
        },
        backgroundColor: CustomTheme.primary,
        tooltip: 'Report a case',
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
                    'Workers',
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
                    return _widget_garden_activity_ui(items[index]);
                  },
                  childCount: items.length, // 1000 list items
                ),
              ),
            ],
          )),
    );
  }

  Widget _widget_garden_activity_ui(WorkerModel m) {
    return InkWell(
      onTap: () => {
        Utils.navigate_to(AppConfig.PestScreen, context,
            data: {'id': m.id.toString()})
      },
      child: FxContainer(
          color: Colors.white,
          padding: EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: (Utils.screen_width(context) / 1.8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                            'NEW CASES: 10',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          FxText(
                            'SOLUTIONS: 15',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          FxText(
                            'TOO MUCH IN: Lira',
                            maxLines: 1,
                            fontSize:
                                ('TOO MUCH IN: Lira'.length > 21) ? 12 : 16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )),
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: CachedNetworkImage(
                        height: (Utils.screen_width(context) / 3.8),
                        width: (Utils.screen_width(context) / 2.8),
                        fit: BoxFit.cover,
                        imageUrl: m.get_image(),
                        placeholder: (context, url) => ShimmerLoadingWidget(
                          height: (Utils.screen_width(context) / 3.8),
                        ),
                        errorWidget: (context, url, error) => Image(
                            image: AssetImage(
                              './assets/project/no_image.jpg',
                            ),
                            fit: BoxFit.cover,
                            height: (Utils.screen_width(context) / 3.8),
                            width: (Utils.screen_width(context) / 2.8)),
                      )),
                ],
              ),
            ],
          )),
    );
  }
}
