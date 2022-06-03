import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/firstscreen/home/components/home_header/coins_payment/payment_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../constants/constant.dart';
import '../../../../constants/size_config.dart';

class CoinsField extends StatefulWidget {

  @override
  State<CoinsField> createState() => _CoinsFieldState();
}

class _CoinsFieldState extends State<CoinsField> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(46),
      width: getProportionateScreenWidth(95),
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: FutureBuilder(
        future: getFromUID(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return TextButton.icon(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return makePayment();
                      }),
                    );

                    // setFromUID(snapshot.data * 5);
                  });
                },
                icon: Image.asset('assets/category/syscoins.png',) ,
                label: Text("${snapshot.data}"));
          } else
            return Text("0");
        },
      ),
    );
  }
}

Future<int> getFromUID() async {
  int totalClasses = await FirebaseFirestore.instance
      .collection('User')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .get()
      .then((value) {
    return value.data()['coins']; // Access your after your get the data
  });
  return await totalClasses;
}

void setFromUID(var ecoins) async {
  await FirebaseFirestore.instance
      .collection('User')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .update({'coins': ecoins});
}
