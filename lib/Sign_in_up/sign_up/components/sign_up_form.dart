import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../constants/constant.dart';
import '../../../constants/custom_surfix_icon.dart';
import '../../../constants/default_button.dart';
import '../../../constants/form_error.dart';
import '../../../constants/keyboard.dart';
import '../../../constants/size_config.dart';
import '../../complete_profile/complete_profile_screen.dart';



class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
   String email;
   String password;
   String conform_password;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                final newUser = await auth.createUserWithEmailAndPassword(
                    email: email, password: password);
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                if (newUser != null) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return CompleteProfileScreen();
                  } ),);
                }
              }

                 },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) {
        if (value.isNotEmpty) {
        } else if (value.isNotEmpty && password == conform_password) {
        }
        conform_password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Please Confirm Your Password";
        } else if ((password != value)) {
          return "Wrong Password";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) {
        password = value;
        if (value.isNotEmpty) {
        } else if (value.length >= 8) {
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Please Enter Password";
        } else if (value.length < 8) {
          return "Password Length is between 8 and 12 ";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        email = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Please Enter Your Email";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          return "Invalid Email Adress";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
