import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/constants/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_auction/firstscreen/home/components/home_header/coins_payment/paypal_payment.dart';

import '../../../../../constants/size_config.dart';

class makePayment extends StatefulWidget {
  @override
  _makePaymentState createState() => _makePaymentState();
}

class _makePaymentState extends State<makePayment> {
  TextStyle style = TextStyle(fontFamily: 'Open Sans', fontSize: 15.0);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int inputvalue = 0;
  int ecoinsprice;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'E-Coins Payment',
            style: headingStyle2,
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: getFromUID(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(height: 40,),
                  Text('E-Coins Pay',style: TextStyle(
                    fontSize: getProportionateScreenWidth(35),
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    foreground: Paint()..shader = LinearGradient(
                      colors: <Color>[Color(0xff7ba3ea), Color(0xff5e77fa)],
                    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  ),),
                  SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: false),
                      initialValue: inputvalue.toString(),
                      key: _scaffoldKey,
                      onChanged: (value) {
                        setState(() {
                          inputvalue = int.parse(value);
                        });
                      },
                      onTap: () {},
                      decoration: const InputDecoration(
                        labelText: "E-Coins Amount",
                        hintText: "Enter Your E-Coins Amount",
                      ),
                    ),
                  ),
                  SizedBox(height: 60,),
                  Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Your E-Coins Amount = $inputvalue",
                              style: headingStyle3,
                            ),
                          )),
                      SizedBox(width: 10,height: 10,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "E-Coins Price = 1 USD",
                              style: headingStyle3,
                            ),
                          )),
                      SizedBox(width: 10,height: 10,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Your Checkout Price  1 * $inputvalue = $inputvalue",
                              style: headingStyle3,
                            ),
                          )),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => PaypalPayment(
                                  itemName: "E-Coins",
                                  itemPrice: "${inputvalue.toString()}",
                                  quantity: inputvalue,
                                  onFinish: (number) async {
                                    // payment done
                                    print('order id: ' + number);
                                    setFromUID(snapshot.data+inputvalue);
                                  },
                                ),
                              ),
                            );
                          },
                          label: Text(
                            'Pay With Paypal ',
                            style: headingStyle,
                          ),
                          icon: Icon(Icons.paypal),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: TextButton.icon(
                        onPressed: () {

                        },
                        label: Text(
                          'Pay With Credit',
                          style: headingStyle,
                        ),
                        icon: Icon(Icons.credit_card),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: TextButton.icon(
                        onPressed: () {
                        },
                        label: Text(
                          ' Pay With Stripe',
                          style: headingStyle,
                        ),
                        icon: Icon(Icons.strikethrough_s),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
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

Future<void> setFromUID(var ecoins) async {
  await FirebaseFirestore.instance
      .collection('User')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .update({'coins': ecoins});
}