import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutx/widgets/button/button.dart';
import 'package:flutx/widgets/container/container.dart';
import 'package:flutx/widgets/text/text.dart';
import '../../models/UserModel.dart';
import '../../pages/products/product_details.dart';
import '../../utils/AppConfig.dart';
import '../../widget/my_widgets.dart';

import '../models/BannerModel.dart';
import '../models/ProductModel.dart';
import '../models/VendorModel.dart';
import '../theme/custom_theme.dart';
import '../utils/Utils.dart';
import '../widget/shimmer_loading_widget.dart';

class VendorsPage extends StatefulWidget {
  @override
  State<VendorsPage> createState() => _VendorsPageState();
}

List<BannerModel> banners = [];
bool initilized = false;
bool store_initilized = false;
BannerModel horizontal_banner_1 = BannerModel();
BannerModel horizontal_banner_2 = BannerModel();
BannerModel horizontal_banner_3 = BannerModel();
List<ProductModel> _trending_products = [];

class _VendorsPageState extends State<VendorsPage> {
  Future<void> get_owner(VendorModel v) async {
    UserModel u = new UserModel();
    u.id = v.id;
    u.name = v.name;
    u.phone_number = v.phone_number;
    u.email = v.email;
    u.username = v.username;
    u.address = v.address;
    u.avatar = v.avatar;
    u.cover_photo = v.cover_photo;
    u.created_at = v.created_at;

    Utils.navigate_to(AppConfig.AccountDetails, context, data: u);
  }

  _VendorsPageState();

  bool is_logged_in = true;
  bool is_loading = true;
  bool complete_profile = true;
  UserModel logged_in_user = new UserModel();
  List<VendorModel> vendors = [];

  Future<void> _init_databse() async {
    setState(() {
      is_loading = true;
    });
    is_logged_in = await Utils.is_login();
    if (is_logged_in) {
      logged_in_user = await Utils.get_logged_in();
      if (logged_in_user.phone_number == "null" ||
          logged_in_user.phone_number.isEmpty ||
          (logged_in_user.phone_number.length < 3)) {
        complete_profile = false;
      } else {
        complete_profile = true;
      }
    } else {
      complete_profile = true;
    }

    vendors = await VendorModel.get_items();

    initilized = true;
    setState(() {
      is_loading = false;
    });
    return null;
  }

  @override
  void initState() {
    initilized = false;
    _init_databse();
  }

  @override
  void dipose() {
    store_initilized = false;
  }

  int i = 0;

  Future<Null> _onRefresh() async {
    initilized = false;
    await _init_databse();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _onRefresh,
        color: CustomTheme.primary,
        backgroundColor: Colors.white,
        child: is_loading
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              )
            : CustomScrollView(
                slivers: [
                  (is_logged_in && complete_profile)
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Container();
                            },
                            childCount: 0, // 1000 list items
                          ),
                        )
                      : SliverAppBar(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FxText(
                                complete_profile
                                    ? "Want to access everything?"
                                    : "Just 1 more step remaining!",
                                color: Colors.yellow.shade700,
                                fontWeight: 600,
                              ),
                              FxButton.text(
                                  onPressed: () {
                                    if (!is_logged_in) {
                                      show_not_account_bottom_sheet(context);
                                    } else if (!complete_profile) {
                                      Utils.navigate_to(
                                          AppConfig.AccountEdit, context);
                                    }
                                  },
                                  splashColor:
                                      CustomTheme.primary.withAlpha(40),
                                  child: FxText.l2(
                                      complete_profile ? "YES" : "WHAT?",
                                      fontSize: 18,
                                      textAlign: TextAlign.center,
                                      color: Colors.white))
                            ],
                          ),
                          floating: true,
                          backgroundColor: Colors.red.shade700,
                        ),
                  SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 2,
                            mainAxisExtent: 170),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return singleGridItem(vendors[index]);
                      },
                      childCount: vendors.length,
                    ),
                  ),
                ],
              ));
  }

  Widget singleGridImageIte3(ProductModel productModel, int index) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                ProductDetails(productModel),
            transitionDuration: Duration.zero,
          ),
        )
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          top: 10,
          left: (index.isOdd) ? 0 : 15,
          right: (index.isOdd) ? 15 : 0,
        ),
        child: Column(
          children: [
            Image.asset(
              "assets/project/no_image.jpg",
              height: 210,
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5, left: 5),
                  child: Text(
                    productModel.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                        fontSize: 16),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                  child: Icon(
                    Icons.verified_rounded,
                    color: Colors.grey.shade800,
                    size: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget singleGridImageIte2(BannerModel productModel, int index) {
    return InkWell(
      onTap: () => {open_product_listting(productModel)},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                productModel.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(productModel.sub_title),
            ],
          ),
          CachedNetworkImage(
            height: 100,
            fit: BoxFit.cover,
            imageUrl: "${AppConfig.BASE_URL}/${productModel.image}",
            placeholder: (context, url) =>
                ShimmerLoadingWidget(height: 100, width: 100, is_circle: true),
            errorWidget: (context, url, error) => Image(
              image: AssetImage('./assets/project/no_image.jpg'),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }

  Widget singleGridImageItem(BannerModel bannerModel, int index) {
    return InkWell(
      onTap: () => {open_product_listting(bannerModel)},
      child: Container(
        height: 240,
        padding: EdgeInsets.only(
          top: 5,
          left: (index.isOdd) ? 0 : 15,
          right: (index.isOdd) ? 15 : 0,
        ),
        alignment: Alignment.center,
        child: CachedNetworkImage(
          width: ((MediaQuery.of(context).size.width / 2) - 15),
          fit: BoxFit.fill,
          imageUrl: "${AppConfig.BASE_URL}/${bannerModel.image}",
          placeholder: (context, url) => ShimmerLoadingWidget(
            height: 210,
          ),
          errorWidget: (context, url, error) => Image(
            image: AssetImage('./assets/project/no_image.jpg'),
            height: 210,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget singleGridItem(VendorModel data) {
    return InkWell(
      onTap: () => {get_owner(data)},
      child: FxContainer(
        alignment: Alignment.center,
        child: Column(
          children: [
            FxContainer.rounded(
              width: 70,
              paddingAll: 0,
              marginAll: 0,
              height: 70,
              child: CachedNetworkImage(
                height: 70,
                imageUrl: "${AppConfig.BASE_URL}/${data.avatar}",
                placeholder: (context, url) => ShimmerLoadingWidget(
                    height: 100, width: 100, is_circle: true, padding: 0),
                errorWidget: (context, url, error) => Image(
                  image: AssetImage('./assets/project/no_image.jpg'),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            FxText.b1(
              data.name,
              maxLines: 1,
              color: Colors.black,
              fontWeight: 600,
              fontSize: 16,
              textAlign: TextAlign.center,
            ),
            Divider(),
            FxText.b1(
              data.products_count + " Products",
              maxLines: 2,
              color: Colors.black,
              fontWeight: 300,
              fontSize: 10,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void open_product_listting(BannerModel item) {
    Utils.navigate_to(AppConfig.ProductListting, context, data: {
      'title': item.name,
      'id': item.category_id,
      'task': 'Banner',
    });
  }
}
