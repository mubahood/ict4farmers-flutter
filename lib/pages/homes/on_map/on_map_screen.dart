import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ict4farmers/models/ProductModel.dart';
import 'package:ict4farmers/pages/homes/on_map/search_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../theme/app_theme.dart';
import '../../../theme/material_theme.dart';
import '../../../widget/loading_effect.dart';
import '../../../widgets/images.dart';

class OnMapScreen extends StatefulWidget {
  const OnMapScreen({Key? key}) : super(key: key);

  @override
  _OnMapScreenState createState() => _OnMapScreenState();
}

class _OnMapScreenState extends State<OnMapScreen> {
  late ThemeData theme;
  late MaterialThemeData mTheme;
  late SearchController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    mTheme = MaterialTheme.estateTheme;
    controller = FxControllerStore.putOrFind(SearchController());
    _init_state();
  }

  List<Widget> _buildHouseList() {
    List<Widget> list = [];

    /* for (ProductModel house in controller.houses!) {
      list.add(_SinglePosition(house));
    }*/
    list.add(_SinglePosition(new ProductModel()));
    list.add(_SinglePosition(new ProductModel()));
    list.add(_SinglePosition(new ProductModel()));
    list.add(_SinglePosition(new ProductModel()));
    list.add(_SinglePosition(new ProductModel()));
    list.add(_SinglePosition(new ProductModel()));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<SearchController>(
        controller: controller,
        builder: (controller) {
          return Theme(
            data: theme.copyWith(
                colorScheme: theme.colorScheme
                    .copyWith(secondary: mTheme.primaryContainer)),
            child: Scaffold(
              body: Container(
                padding: FxSpacing.top(FxSpacing.safeAreaTop(context)),
                child: Column(
                  children: [
                    Container(
                      height: 2,
                      child: controller.showLoading
                          ? LinearProgressIndicator(
                              color: mTheme.primary,
                              minHeight: 2,
                            )
                          : Container(
                              height: 0,
                            ),
                    ),
                    Expanded(
                      child: _buildBody(),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _buildBody() {
    if (controller.uiLoading) {
      return Container(
          margin: FxSpacing.top(FxSpacing.safeAreaTop(context)),
          child: LoadingEffect.getSearchLoadingScreen(
            context,
            theme,
            mTheme,
          ));
    } else {
      return Stack(
        children: [
          GoogleMap(
            markers: controller.marker,
            onMapCreated: controller.onMapCreated,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              new Factory<OneSequenceGestureRecognizer>(
                () => new EagerGestureRecognizer(),
              ),
            ].toSet(),
            initialCameraPosition: CameraPosition(
              target: controller.center,
              zoom: 7.0,
            ),
          ),
          Positioned(
            bottom: FxSpacing.safeAreaTop(context) + 100,
            left: 24,
            right: 40,
            child: Row(
              children: <Widget>[
                FxSpacing.width(12),
                Expanded(
                  child: FxContainer(
                    color: CustomTheme.accent,
                    borderRadiusAll: 4,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext buildContext) {
                            return SortBottomSheet();
                          });
                    },
                    margin: FxSpacing.x(4),
                    padding: FxSpacing.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          MdiIcons.swapVertical,
                          color: Colors.grey.shade100,
                          size: 20,
                        ),
                        FxSpacing.width(8),
                        FxText.sh2("Sort",                          color: Colors.grey.shade100, fontWeight: 600, letterSpacing: 0)
                      ],
                    ),
                  ),
                ),
                FxSpacing.width(12),
                Expanded(
                  child: FxContainer(
                    color: CustomTheme.primary,
                    borderRadiusAll: 4,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext buildContext) {
                            return FilterBottomSheet();
                          });
                    },
                    padding: FxSpacing.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          MdiIcons.tune,
                          color: Colors.grey.shade100,
                          size: 22,
                        ),
                        FxSpacing.width(8),
                        FxText.sh2("Filter",
                            color: Colors.white,
                            fontWeight: 600, letterSpacing: 0)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: Container(
              height: 100,
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              child: PageView(
                pageSnapping: true,
                physics: ClampingScrollPhysics(),
                controller: controller.pageController,
                onPageChanged: controller.onPageChange,
                children: _buildHouseList(),
              ),
            ),
          ),
        ],
      );
    }
  }

  void _init_state() {
    controller.addMarkers();
  }
}

class _SinglePosition extends StatelessWidget {
  final ProductModel house;
  List<String> _images = [];

  _SinglePosition(this.house);

  @override
  Widget build(BuildContext context) {
    _images = Images.network_links;
    _images.shuffle();
    _images.shuffle();

    MaterialThemeData mTheme = MaterialTheme.estateTheme;
    return FxContainer(
      color: CustomTheme.primary,
      borderRadiusAll: mTheme.containerRadius.medium,
      padding: EdgeInsets.only(top: 16, bottom: 16, left: 16),
      margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(mTheme.containerRadius.medium),
            child: Image(
              image: NetworkImage(_images[0]),
              fit: BoxFit.cover,
              width: 72,
              height: 72,
            ),
          ),
          Expanded(
            child: Container(

              margin: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FxText.b1(
                    'Item name go here',
                    fontWeight: 600,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.grey.shade100,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.location_pin,
                          color:  Colors.grey.shade200,
                          size: 14,
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left: 2),
                              child: FxText.b3(
                                'Item detail go here...',
                                fontWeight: 400,
                                color: Colors.grey.shade200,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}




class SortBottomSheet extends StatefulWidget {
  @override
  _SortBottomSheetState createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  int _radioValue = 0;
  late ThemeData theme;
  late CustomTheme customTheme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        padding: FxSpacing.xy(24, 16),
        decoration: BoxDecoration(
            color: customTheme.card,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FxSpacing.height(8),
            Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      _radioValue = 0;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Radio(
                        onChanged: (dynamic value) {
                          setState(() {
                            _radioValue = 0;
                          });
                        },
                        groupValue: _radioValue,
                        value: 0,
                        visualDensity: VisualDensity.compact,
                        activeColor: theme.colorScheme.primary,
                      ),
                      FxText.sh2("Price - ", fontWeight: 60),
                      FxText.sh2("Cheapest"),
                    ],
                  ),
                ),

                InkWell(
                  onTap: () {
                    setState(() {
                      _radioValue = 2;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Radio(
                        onChanged: (dynamic value) {
                          setState(() {
                            _radioValue = 2;
                          });
                        },
                        groupValue: _radioValue,
                        value: 2,
                        visualDensity: VisualDensity.compact,
                        activeColor: theme.colorScheme.primary,
                      ),
                      FxText.sh2("Distance - ", fontWeight: 600),
                      FxText.sh2("Nearest"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _radioValue = 3;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Radio(
                        onChanged: (dynamic value) {
                          setState(() {
                            _radioValue = 3;
                          });
                        },
                        groupValue: _radioValue,
                        value: 3,
                        visualDensity: VisualDensity.compact,
                        activeColor: theme.colorScheme.primary,
                      ),
                      FxText.sh2("Name - ", fontWeight: 600),
                      FxText.sh2("A to Z"),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}




class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  bool colorBlack = false,
      colorRed = true,
      colorOrange = false,
      colorTeal = true,
      colorPurple = false;

  bool sizeXS = false,
      sizeS = true,
      sizeM = false,
      sizeL = true,
      sizeXL = false;

  late ThemeData theme;
  late CustomTheme customTheme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: customTheme.card,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      padding: FxSpacing.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Center(child: FxText.b1("Filter", fontWeight: 700))),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    padding: FxSpacing.all(8),
                    decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.all(Radius.circular(22))),
                    child: Icon(
                      MdiIcons.check,
                      size: 20,
                      color: theme.colorScheme.onPrimary,
                    )),
              )
            ],
          ),
          FxSpacing.height(8),
          FxText.sh2("What do you want to see?", fontWeight: 600, letterSpacing: 0),
          Container(
            child: _TypeChipWidget(),
          ),
          FxSpacing.height(8),


        ],
      ),
    );
  }

  Widget colorWidget({Color? color, bool checked = true}) {
    return FxContainer.none(
      width: 36,
      height: 36,
      color: color,
      borderRadiusAll: 18,
      child: checked
          ? Center(
        child: Icon(
          MdiIcons.check,
          color: Colors.white,
          size: 20,
        ),
      )
          : Container(),
    );
  }
}


class _TypeChipWidget extends StatefulWidget {
  final List<String> typeList = ["Products", "Farmers", "Markets"];

  @override
  _TypeChipWidgetState createState() => _TypeChipWidgetState();
}

class _TypeChipWidgetState extends State<_TypeChipWidget> {
  List<String> selectedChoices = ["Man"];
  late ThemeData theme;
  late CustomTheme customTheme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.typeList.forEach((item) {
      choices.add(Container(
        padding: FxSpacing.all(8),
        child: ChoiceChip(
          backgroundColor: customTheme.card,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          selectedColor: theme.colorScheme.primary,
          label: FxText.b2(item,
              color: selectedChoices.contains(item)
                  ? theme.colorScheme.onSecondary
                  : theme.colorScheme.onBackground,
              fontWeight: selectedChoices.contains(item) ? 700 : 600),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

