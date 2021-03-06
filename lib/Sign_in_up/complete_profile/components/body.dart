import 'package:e_auction/Sign_in_up/complete_profile/components/profile_pic.dart';
import 'package:flutter/material.dart';
import '../../../constants/constant.dart';
import '../../../constants/size_config.dart';
import '../../../firstscreen/profile/components/terms_conditional.dart';
import 'complete_profile_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text("Complete Profile", style: headingStyle),
                Text(
                  "Complete your details or continue  \nwith social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                ProfilePic(),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                CompleteProfileForm(),
                SizedBox(height: getProportionateScreenHeight(30)),
                TextButton(
                  child: Text("By continuing your confirm that you agree \nwith our Term and Condition",textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TermsAndConditional(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
