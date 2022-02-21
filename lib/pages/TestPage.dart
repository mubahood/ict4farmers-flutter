import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Image.asset(
            "assets/project/slide_1.jpeg",
            height: 180,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              singleGridItem(image: "circle_1.webp", title: "Tops"),
              singleGridItem(image: "circle_2.webp", title: "Bottom"),
              singleGridItem(image: "circle_3.webp", title: "Dresses"),
              singleGridItem(image: "circle_4.webp", title: "Outwear"),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              singleGridItem(image: "circle_5.webp", title: "Shoes"),
              singleGridItem(image: "circle_6.webp", title: "Bags"),
              singleGridItem(image: "circle_7.webp", title: "Beauty"),
              singleGridItem(image: "circle_8.webp", title: "Home"),
            ],
          ),

        ],
      ),
    );
  }

  Widget singleGridItem({
    String image: "circle_1.webp",
    String title: "Tops",
  }) {
    return Container(
      padding: EdgeInsets.only(top: 8,bottom: 8),
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset(
            "assets/project/${image}",
            height: 70,
            fit: BoxFit.cover,
          ),
          Text(title,style: TextStyle(
            fontSize: 14
          ),),
        ],
      ),
    );
  }
}
