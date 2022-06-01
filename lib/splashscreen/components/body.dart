import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Sign_in_up/sign_in/sign_in_screen.dart';
import '../../constants/constant.dart';
import '../../constants/default_button.dart';
import '../../constants/size_config.dart';
import '../../Providers/productservices.dart';
import '../components/splash_content.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to E-Auction, Let’s Make a Bid!",
      "image": "assets/images/splash_1.jpg"
    },
    {
      "text":
          "We help people connect with auctions \naround All the world",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to Auction. \nJust stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        ProductService proServices = Provider.of<ProductService>(context,listen: false);
                        proServices.getData();
                        proServices.getProductCategory("Cars");
                        proServices.getProductCategory("Estates");
                        proServices.getProductCategory("Plates");
                        proServices.getProductCategory("Coins");
                        proServices.getProductCategory("Other");
                        proServices.getWishListData();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                          return SignInScreen();
                        } ),);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
