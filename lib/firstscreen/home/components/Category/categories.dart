import 'package:e_auction/firstscreen/home/components/Category/CarsCat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../constants/size_config.dart';

class Categories extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "Cars","id":1},
      {"icon": "assets/icons/Bill Icon.svg", "text": "Estates","id":2},
      {"icon": "assets/icons/Game Icon.svg", "text": "Coins","id":3},
      {"icon": "assets/icons/Gift Icon.svg", "text": "Plates","id":4},
      {"icon": "assets/icons/Discover.svg", "text": "Other","id":5},
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
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFDFE8FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon),
            ),
            SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
