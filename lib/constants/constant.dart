import 'package:flutter/material.dart';
import 'size_config.dart';

const String apptitle = "E-Auction";
Color primaryTextColor = const Color(0xFF414C6B);

const kPrimaryColor = Color(0xFF4388FF);
const kAccentColor = Color(0xFF4388FF);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF3EB2FF), Color(0xFF436CFF)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
final headingStyle2 = TextStyle(
  fontSize: getProportionateScreenWidth(20),
  color: Colors.black,
  height: 1.5,
);
final headingStyle3 = TextStyle(
  fontSize: getProportionateScreenWidth(20),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
final headingStyle4 = TextStyle(
  fontSize: getProportionateScreenWidth(18),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

final textStyle1 = TextStyle(
  fontSize: getProportionateScreenWidth(18),
  color: Colors.black,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailAlreadyExistError = "This Email Already in use";


final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
