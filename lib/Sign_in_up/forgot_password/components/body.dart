import 'package:e_auction/constants/form_done.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../constants/constant.dart';
import '../../../constants/custom_surfix_icon.dart';
import '../../../constants/default_button.dart';
import '../../../constants/form_error.dart';
import '../../../constants/size_config.dart';
import '../../no_account_text.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  List<String> success = [];

   String email;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              email = value;
              if (value.isNotEmpty && errors.contains("")) {
                setState(() {
                  errors.remove("");
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains("Please Enter Your Email")) {
                setState(() {
                  errors.remove("");
                });
              }
              return null;
            },
            validator: (value) {
              if (value.isEmpty && !errors.contains("")) {
                setState(() {
                  errors.add("");
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains("")) {
                setState(() {
                  errors.add("");
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          FormDone(done: success),
          DefaultButton(
            text: "Continue",
            press: () {
              setState(() {
                if (_formKey.currentState.validate()) {
                  FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                  success.add("Email Sent");
                }
              });


            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }
}
