import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:e_auction/firstscreen/home/components/Products/product_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../../constants/constant.dart';
import '../../../../../constants/default_button.dart';

class ProductDetailsCategory extends StatefulWidget {
  final int id;
  final BoxFit boxFit;
  final String assetPath = "assets/images/product/lambo5.jpeg";
final String category;
  const ProductDetailsCategory({Key key, this.id, this.boxFit,this.category})
      : super(key: key);

  @override
  State<ProductDetailsCategory> createState() => _ProductDetailsCategoryState();
}

class _ProductDetailsCategoryState extends State<ProductDetailsCategory> {
  int bidsvalue;
  String ErrorText = null;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAccentColor,
        title: const Text("Product Details"),
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height / 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: widget.assetPath,
                    image: ListcatProvider(context, widget.category)[widget.id].mainPic,
                    fit: widget.boxFit,
                    alignment: Alignment.topCenter,
                    fadeInDuration: const Duration(milliseconds: 350),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: (MediaQuery.of(context).size.height) / 2,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ListcatProvider(context, widget.category)[widget.id].name,
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(
                        ListcatProvider(context, widget.category)[widget.id].location,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .apply(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Description:",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        ListcatProvider(context, widget.category)[widget.id].description,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .apply(color: Colors.grey),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Text(
                            "Bid: ${ListcatProvider(context, widget.category)[widget.id].minBid} EGP",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const Expanded(child: SizedBox()),
                          CountDownText(
                            due: DateTime.parse(
                                ListcatProvider(context, widget.category)[widget.id].endDate),
                            finishedText: "Auction Closed",
                            showLabel: true,
                            longDateName: true,
                            daysTextLong: " D: ",
                            hoursTextLong: " H: ",
                            minutesTextLong: " M: ",
                            secondsTextLong: " S ",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "More Pictures",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                          ListcatProvider(context, widget.category)[widget.id].photos.length,
                          itemBuilder: (ctx, i) {
                            return Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: FadeInImage.assetNetwork(
                                  placeholder: widget.assetPath,
                                  image: ListcatProvider(context, widget.category)[widget.id]
                                      .photos[i],
                                  fit: widget.boxFit,
                                  alignment: Alignment.topCenter,
                                  fadeInDuration:
                                  const Duration(milliseconds: 350),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.height * .7,
                        height: 100,
                        child: TextFormField(
                          keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                          onChanged: (value) {
                            if (double.parse(value) >
                                ListcatProvider(context, widget.category)[widget.id].minBid) {
                              bidsvalue = int.parse(value);
                            }
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return ErrorText = "Please Enter your Bid Value";
                            }
                            if (double.parse(value) <=
                                ListcatProvider(context, widget.category)[widget.id].minBid) {
                              return ErrorText =
                              "Your Price Lower Than Product Price";
                            } else
                              return ErrorText;
                          },
                          decoration: InputDecoration(
                            labelText: "Bid Amount",
                            hintText: "Enter Your Bid",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      DateTime.now().compareTo(DateTime.parse(
                          ListcatProvider(context, widget.category)[widget.id].endDate)) <
                          0
                          ? SizedBox(
                        width: MediaQuery.of(context).size.height * .7,
                        height: 45,
                        child: DefaultButton(
                          text: "Place your bid",
                          press: () {
                            setState(() async {
                              int coins = await getCoinsFromUID();
                              String userwinnername =
                              await getNameFromUID();
                              if (_formKey.currentState.validate()) {
                                if (coins >=
                                    0.25 *
                                        ListcatProvider(context, widget.category)[widget.id]
                                            .minBid) {
                                  if (coins <
                                      0.25 *
                                          (ListcatProvider(context, widget.category)[widget.id]
                                              .minBid)) {
                                    return ErrorText =
                                    "Coins Lower than 25% of Product Price";
                                  } else if (coins < 0.25 * bidsvalue) {
                                    return ErrorText =
                                    "Coins Lower than 25% of Bid Amount";
                                  } else if (bidsvalue >
                                      ListcatProvider(context, widget.category)[widget.id]
                                          .minBid) {
                                    ListcatProvider(context, widget.category)[widget.id]
                                        .minBid =
                                            bidsvalue;
                                    setminBidFromUID(
                                        bidsvalue,
                                        ListcatProvider(context, widget.category)[widget.id]
                                            .name);
                                    ListcatProvider(context, widget.category)[widget.id]
                                        .userwinner = userwinnername;
                                    print(userwinnername);
                                  }
                                }}
                            });
                          },
                        ),
                      )
                          : Text(
                        "Bid Is Endded The Winner is ${ListcatProvider(context, widget.category)[widget.id].userwinner[0]}",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<int> getCoinsFromUID() async {
  int totalClasses = await FirebaseFirestore.instance
      .collection('User')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .get()
      .then((value) {
    return value.data()['coins']; // Access your after your get the data
  });
  return await totalClasses;
}

Future<String> getNameFromUID() async {
  String totalClasses = await FirebaseFirestore.instance
      .collection('User')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .get()
      .then((value) {
    return "${value.data()['firstname']} ${value.data()['lastname']}"; // Access your after your get the data
  });
  return await totalClasses;
}

void setminBidFromUID(var ecoins, String index) async {
  await FirebaseFirestore.instance
      .collection('Products')
      .doc(index)
      .update({'minBid': ecoins});
}
