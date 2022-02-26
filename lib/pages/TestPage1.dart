import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ict4farmers/utils/AppConfig.dart';

import '../models/BannerModel.dart';
import '../models/ProductModel.dart';
import '../objectbox.g.dart';
import '../utils/Utils.dart';
import '../widget/empty_list.dart';

class TestPage1 extends StatefulWidget {
  const TestPage1({Key? key}) : super(key: key);

  @override
  State<TestPage1> createState() => _TestPage1State();
}

late Store _store;

List<BannerModel> banners = [];
bool initilized = false;
bool store_initilized = false;
BannerModel horizontal_banner_1 = BannerModel();
BannerModel horizontal_banner_2 = BannerModel();

class _TestPage1State extends State<TestPage1> {
  Future<void> _init_databse() async {
    if (initilized) {
      return;
    }
    print("refreshing...");

    if(!store_initilized){
      _store = await Utils.init_databse();
      store_initilized= true;
    }
    store_initilized = true;
    banners = await BannerModel.get(_store);


    int i = 0;
    _gridItems.clear();
    banners.forEach((element) {
      i++;

      if (i == 1) {
        horizontal_banner_1 = element;
      }
      if ((i > 1) && (i < 10)) {
        _gridItems.add(element);
      }


      if (i == 10) {
        horizontal_banner_2 = element;
      }

      if ((i > 10) && (i < 12)) {
        _gridBannersItems.add(element);
      }

    });

    initilized = true;
    setState(() {});
    return null;
  }

  @override
  void initState() {
    initilized = false;
      _init_databse();
  }

  @override
  void dipose() {
    _store.close();
    store_initilized = false;
  }

  List<String> _items = [];
  List<BannerModel> _gridItems = [];
  List<BannerModel> _gridBannersItems = [];
  List<ProductModel> _gridBannersItems2 = [];
  List<ProductModel> _products = [];
  int i = 0;

  Future<Null> _onRefresh() async {
    initilized = false;
    await _init_databse();
    return null;
  }

  @override
  Widget build(BuildContext context) {

    /*_gridBannersItems.clear();
    _gridBannersItems2.clear();


    _gridBannersItems2.add(new ProductModel());
    _gridBannersItems2.add(new ProductModel());*/

    _products.clear();
    for (int x = 1; x < 21; x++) {
      _products.add(new ProductModel());
    }

    return RefreshIndicator(
        onRefresh: _onRefresh,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                            height: 200,
                            fit: BoxFit.fill,
                            imageUrl:
                                "${AppConfig.BASE_URL}/${horizontal_banner_1.image}",
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                  );
                },
                childCount: 1, // 1000 list items
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 2,
                  mainAxisExtent: 100),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return singleGridItem(_gridItems[index]);
                },
                childCount: _gridItems.length,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      height: 90,
                      fit: BoxFit.fill,
                      imageUrl:
                      "${AppConfig.BASE_URL}/${horizontal_banner_2.image}",
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                    ),
                  );
                },
                childCount: 1, // 1000 list items
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 7,
                  childAspectRatio: 2,
                  mainAxisExtent: 215),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return singleGridImageItem(_gridBannersItems[index], index);
                },
                childCount: _gridBannersItems.length,
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                  mainAxisExtent: 110),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return singleGridImageIte2(_gridBannersItems2[index], index);
                },
                childCount: _gridBannersItems2.length,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/project/gif_banner_2.webp",
                      height: 110,
                      fit: BoxFit.fill,
                    ),
                  );
                },
                childCount: 1, // 1000 list items
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(top: 0, left: 18),
                    child: Text(
                      "You may also like",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
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
                  childAspectRatio: 1,
                  mainAxisExtent: 250),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return singleGridImageIte3(_products[index], index);
                },
                childCount: _products.length,
              ),
            ),
          ],
        ));
  }

  Widget singleGridImageIte3(ProductModel productModel, int index) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: 10,
        left: (index.isOdd) ? 0 : 15,
        right: (index.isOdd) ? 15 : 0,
      ),
      child: Column(
        children: [
          Image.asset(
            "assets/project/${productModel.thumbnail}",
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
    );
  }

  Widget singleGridImageIte2(ProductModel productModel, int index) {
    return Container(
      color: Color.fromARGB(255, 247, 216, 179),
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(
        top: 10,
        left: (index.isOdd) ? 0 : 15,
        right: (index.isOdd) ? 15 : 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "New Arrival",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("20% Off"),
            ],
          ),
          Image.asset(
            "assets/project/${productModel.thumbnail}",
            height: 100,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget singleGridImageItem(BannerModel bannerModel, int index) {
    return Container(
      padding: EdgeInsets.only(
        top: 5,
        left: (index.isOdd) ? 0 : 15,
        right: (index.isOdd) ? 15 : 0,
      ),
      alignment: Alignment.center,
      child: Column(
        children: [

          CachedNetworkImage(
            height: 210,
            fit: BoxFit.cover,
            imageUrl:
            "${AppConfig.BASE_URL}/${bannerModel.image}",
            placeholder: (context, url) =>
                CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                Icon(Icons.error),
          ),

        ],
      ),
    );
  }

  Widget singleGridItem(BannerModel data) {
    /*return
   */

    return Container(
      padding: EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      child: Column(
        children: [
          CachedNetworkImage(
            height: 70,
            imageUrl: "${AppConfig.BASE_URL}/${data.image}",
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Text(
            data.name,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
