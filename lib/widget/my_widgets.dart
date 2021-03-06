import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/button/button.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:ict4farmers/utils/AppConfig.dart';
import 'package:ict4farmers/widget/shimmer_loading_widget.dart';

import '../theme/app_theme.dart';
import '../theme/custom_theme.dart';
import '../utils/Utils.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Widget myNetworkImage(String url,double _height,double _width,double radiusAll){
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(radiusAll)),
    child: CachedNetworkImage(
      height: _height,
      width: double.infinity,
      fit: BoxFit.fill,
      imageUrl: url,
      placeholder: (context, url) => ShimmerLoadingWidget(
        height: _height,
      ),
      errorWidget: (context, url, error) => Image(
          fit: BoxFit.cover,
          image: AssetImage(
            './assets/project/no_image.jpg',
          ),
          height: _height,
          width: _width),
    ),
  );
}

Widget social_media_links(context) {
  return Row(
    children: <Widget>[
      InkWell(
        onTap: () => {Utils.launchOuLink(AppConfig.OurWhatsApp)},
        child: Container(
          margin: EdgeInsets.only(left: 0),
          padding: EdgeInsets.all(3),
          child: Icon(
            Icons.whatsapp,
            size: 30,
            color: Colors.green.shade600,
          ),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey.shade500, width: 1),
              color: AppTheme.lightTheme.backgroundColor,
              borderRadius:
              BorderRadius.all(Radius.circular(11))),
        ),
      ),
      InkWell(
        onTap: () =>
        {Utils.launchOuLink(AppConfig.OUR_FACEBOOK_LINK)},
        child: Container(
          margin: EdgeInsets.only(left: 16),
          padding: EdgeInsets.all(3),
          child: Icon(
            Icons.facebook,
            size: 30,
            color: Colors.blue.shade800,
          ),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey.shade500, width: 1),
              color: AppTheme.lightTheme.backgroundColor,
              borderRadius:
              BorderRadius.all(Radius.circular(11))),
        ),
      ),
      InkWell(
        onTap: () =>
        {Utils.launchOuLink(AppConfig.OUR_TWITTER_LINK)},
        child: Container(
          margin: EdgeInsets.only(left: 16),
          padding: EdgeInsets.all(3),
          child: Icon(
            MdiIcons.twitter,
            size: 30,
            color: Colors.blue.shade500,
          ),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey.shade500, width: 1),
              borderRadius:
              BorderRadius.all(Radius.circular(11))),
        ),
      ),
      InkWell(
        onTap: () =>
        {Utils.launchOuLink(AppConfig.OUR_YOUTUBE_LINK)},
        child: Container(
          margin: EdgeInsets.only(left: 16),
          padding: EdgeInsets.all(3),
          child: Icon(
            MdiIcons.youtube,
            size: 30,
            color: Colors.red.shade700,
          ),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey.shade500, width: 1),
              borderRadius:
              BorderRadius.all(Radius.circular(11))),
        ),
      ),

    ],
  );
}
void show_not_account_bottom_sheet(context) {
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
                  child: NoAccountWidget(context),
                ),
              );
            });
      });
}

Widget NoAccountWidget(BuildContext context,
    {String body: "You are not logged in yet.\n\n"
        "Create your ${AppConfig.AppName} account today! and share farming experience with hundreds of farmers in Uganda.",
    String action_text:
        "Sell your farm products, Chat with experts, Compare farm products prices, Manage your farms and much more...",
    String empty_image: ""}) {
  String _empty_image = './assets/project/no_account.png';
  if (!empty_image.isEmpty) {
    _empty_image = empty_image;
  }
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: Image(
            image: AssetImage(
              _empty_image,
            ),
          ),
          padding: EdgeInsets.only(left: 80, right: 80),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              FxText(
                body,
                textAlign: TextAlign.center,
              ),
              FxSpacing.height(20),
              action_text.isEmpty
                  ? Container()
                  : FxText.h2(
                      action_text,
                      fontSize: 18,
                      color: CustomTheme.primary,
                      textAlign: TextAlign.center,
                    ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Divider(height: 10, color: CustomTheme.primary.withAlpha(40)),
        SizedBox(
          height: 20,
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
                  Utils.navigate_to(AppConfig.AccountRegister, context);
                },
                child: FxText.l1(
                  "SIGN UP",
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
                  "LOG IN",
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

void my_bottom_sheet(context, Widget widget) {
  showModalBottomSheet(
      isScrollControlled: false,
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
                  child: widget,
                ),
              );
            });
      });
}
