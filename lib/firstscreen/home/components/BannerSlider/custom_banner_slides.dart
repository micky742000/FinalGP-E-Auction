import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import 'banner_page_controller.dart';


class CustomBannerSlides extends StatelessWidget {
  const CustomBannerSlides({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Swiper(
        itemCount: sliderItems.length,
        autoplay: true,
        autoplayDelay: 5000,
        curve: Curves.easeIn,
        layout: SwiperLayout.DEFAULT,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: BannerImageModel(sliderItems[index], fit: BoxFit.fill),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: const EdgeInsets.all(20),
          );
        },
      ),
    );
  }
}
class BannerImageModel extends StatelessWidget {
  final String image;
  final BoxFit fit;
  final double width, height;
  const BannerImageModel(this.image,
      {Key key, this.fit, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      fit: fit,
      width: width,
      height: height,
    );
  }
}
