import 'package:e_auction/firstscreen/home/components/home_header/coins_field.dart';
import 'package:e_auction/firstscreen/home/components/home_header/search_screen.dart';
import 'package:flutter/material.dart';
import '../../../../constants/constant.dart';
import '../../../../constants/size_config.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            apptitle,
            style: headingStyle,
          ),
          CoinsField(),
          Container(
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SearchScreen();
                  }),
                );
              },
              icon: Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }
}
