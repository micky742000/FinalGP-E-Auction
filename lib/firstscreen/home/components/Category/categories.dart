import 'package:e_auction/firstscreen/home/components/Category/CarsCat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../constants/size_config.dart';

class Categories extends StatefulWidget {

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/category/cars.png", "text": "Cars","id":1},
      {"icon": "assets/category/estate.png", "text": "Estates","id":2},
      {"icon": "assets/category/coins80.png", "text": "Coins","id":3},
      {"icon": "assets/category/plate100.png", "text": "Plates","id":4},
      {"icon": "assets/category/other.png", "text": "Other","id":5},
    ];
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => CategoryCards(categories[index]["text"]),
                ),
              );

            },
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
     this.icon,
     this.text,
     this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(8)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image(image: AssetImage(icon)),
            ),
            SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
