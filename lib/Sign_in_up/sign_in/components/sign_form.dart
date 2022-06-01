import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../constants/constant.dart';
import '../../../constants/custom_surfix_icon.dart';
import '../../../constants/default_button.dart';
import '../../../constants/form_error.dart';
import '../../../constants/keyboard.dart';
import '../../../constants/size_config.dart';
import '../../../firstscreen/home/home_screen.dart';
import '../../forgot_password/forgot_password_screen.dart';


class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
   String email;
   String password;
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
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context){
                  return ForgotPasswordScreen();
                } )),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () async {

              if (_formKey.currentState.validate() ) {
                _formKey.currentState.save();
                final newUser = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                // if all are valid then go to success screen
                if (newUser != null) {
                  KeyboardUtil.hideKeyboard(context);
                  Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }),);
                }
                }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
        } else if (value.length >= 8) {
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Please Enter Password";
        } else if (value.length < 8) {
          return "Wrong Password";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
        } else if (emailValidatorRegExp.hasMatch(value)) {
        }
        return null;
      },
      validator: (value) {
          if (value.isEmpty) {
            return "Please Enter Your Email";
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            return "Wrong Email";
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
    );
  }
}
