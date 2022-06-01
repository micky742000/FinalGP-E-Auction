import 'package:e_auction/firstscreen/home/components/Products/product_page.dart';
import 'package:e_auction/firstscreen/home/components/section_title.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../constants/size_config.dart';
import 'BannerSlider/custom_banner_slides.dart';
import 'Category/categories.dart';
import 'home_header/home_header.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        child: SingleChildScrollView(
          child: Column(
            children: [
             SizedBox(height: getProportionateScreenHeight(20)),
              HomeHeader(),
              SizedBox(height: getProportionateScreenWidth(20)),
              const CustomBannerSlides(),
              SizedBox(height: getProportionateScreenHeight(20)),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: SectionTitle(title: "Categories", press: () {}),
              ),
              Categories(),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: SectionTitle(title: "Available Products", press: () {}),
              ),
              ProductPage(),
              SizedBox(height: getProportionateScreenWidth(30)),
            ],
          ),
        ),
        inAsyncCall: _saving,
        opacity: 1,
        progressIndicator: CircularProgressIndicator(),
      ),
    );
  }
}
