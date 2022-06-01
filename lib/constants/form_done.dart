import 'package:e_auction/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class FormDone extends StatelessWidget {
  const FormDone({
    Key key,
    this.done,
  }) : super(key: key);

  final List<String> done;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          done.length, (index) => formErrorText(error: done[index])),
    );
  }

  Row formErrorText({String error}) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/Success.svg",
          height: getProportionateScreenWidth(14),
          width: getProportionateScreenWidth(14),
        ),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        Text(error),
      ],
    );
  }
}
