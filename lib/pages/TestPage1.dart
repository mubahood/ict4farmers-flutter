import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/ProductModel.dart';
import '../widget/empty_list.dart';

class TestPage1 extends StatefulWidget {
  const TestPage1({Key? key}) : super(key: key);

  @override
  State<TestPage1> createState() => _TestPage1State();
}

class _TestPage1State extends State<TestPage1> {
  @override
  void initState() {
    print("====> INITNG... <[====");
  }

  List<String> _items = [];
  List<ProductModel> _gridItems = [];
  List<ProductModel> _gridBannersItems = [];
  List<ProductModel> _gridBannersItems2 = [];
  List<ProductModel> _products = [];
  int i = 0;

  Future<Null> _onRefresh() async {
    i++;
    _items.add("${i}. Romina");
    setState(() {});
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _gridItems.clear();
    _gridBannersItems.clear();
    _gridBannersItems2.clear();

    _gridItems.add(new ProductModel());
    _gridItems.add(new ProductModel());

    _gridBannersItems.add(new ProductModel( ));
    _gridBannersItems.add(new ProductModel( ));

    _gridBannersItems2.add(new ProductModel());
    _gridBannersItems2.add(new ProductModel());

    _products.clear();
    for(int x=1;x<21;x++){
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
                    child: Image.asset(
                      "assets/project/slide_1.jpeg",
                      height: 180,
                      fit: BoxFit.cover,
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
                  return singleGridItem(
                      image: _gridItems[index].thumbnail,
                      title: _gridItems[index].name);
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
                    child: Image.asset(
                      "assets/project/gif_banner_1.webp",
                      height: 90,
                      fit: BoxFit.fill,
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
                          fontWeight: FontWeight.bold, ),
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
                padding: EdgeInsets.only(top: 5,bottom: 5,left: 5),
                child: Text(
                  productModel.name,
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800,fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5,bottom: 5,right: 5),
                child: Icon(Icons.verified_rounded,color: Colors.grey.shade800,size: 18,),
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

  Widget singleGridImageItem(ProductModel productModel, int index) {
    return Container(
      padding: EdgeInsets.only(
        top: 5,
        left: (index.isOdd) ? 0 : 15,
        right: (index.isOdd) ? 15 : 0,
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset(
            "assets/project/${productModel.thumbnail}",
            height: 210,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget singleGridItem({
    String image: "circle_2.webp",
    String title: "Tops",
  }) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset(
            "assets/project/${image}",
            height: 70,
            fit: BoxFit.cover,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
