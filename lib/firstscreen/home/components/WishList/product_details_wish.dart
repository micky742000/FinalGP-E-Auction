import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:e_auction/firstscreen/home/components/Products/product_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Providers/productservices.dart';
import '../../../../constants/constant.dart';
import '../../../../constants/default_button.dart';
import '../../../../constants/loading.dart';
import '../../home_screen.dart';

class ProductDetailsWish extends StatefulWidget {
  final int id;
  final BoxFit boxFit;
  final String assetPath = "assets/images/product/lambo5.jpeg";

  const ProductDetailsWish({Key key, @required this.id, this.boxFit})
      : super(key: key);

  @override
  State<ProductDetailsWish> createState() => _ProductDetailsWishState();
}

class _ProductDetailsWishState extends State<ProductDetailsWish> {
  int bidsValue;
  String errorText ;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }),);

      },
      child: Scaffold(
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
                      image: ListProviderWishList(context)[widget.id].mainPic,
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
                          ListProviderWishList(context)[widget.id].name,
                          style: const TextStyle(fontSize: 24),
                        ),
                        Text(
                          ListProviderWishList(context)[widget.id].location,
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
                          ListProviderWishList(context)[widget.id].description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .apply(color: Colors.grey),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          "Highest Bid: ${ListProviderWishList(context)[widget.id].minBid} EGP",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(),
                        Row(
                          children: [
                            Text(
                              "End Time: ",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            CountDownText(
                              due: DateTime.parse(
                                  ListProviderWishList(context)[widget.id].endDate),
                              finishedText: "Auction Closed",
                              showLabel: true,
                              longDateName: true,
                              daysTextLong: " D: ",
                              hoursTextLong: " H: ",
                              minutesTextLong: " M: ",
                              secondsTextLong: " S ",
                              style: Theme.of(context).textTheme.subtitle1,
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
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.height * .7,
                          height: 100,
                          child: TextFormField(
                            keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                            onChanged: (value) {
                              if (int.parse(value) >
                                  ListProviderWishList(context)[widget.id].minBid) {
                                bidsValue = int.parse(value);
                              }
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return errorText = "Please Enter your Bid Value";
                              }
                              if (int.parse(value) <=
                                  ListProviderWishList(context)[widget.id].minBid) {
                                return errorText =
                                "Your Price Lower Than Product Price";
                              } else {
                                return errorText;
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: "Bid Amount",
                              hintText: "Enter Your Bid",
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        DateTime.now().compareTo(DateTime.parse(
                            ListProviderWishList(context)[widget.id].endDate)) <
                            0
                            ? SizedBox(
                          width: MediaQuery.of(context).size.height * .7,
                          height: 45,
                          child: DefaultButton(
                            text: "Place your bid",
                            press: () async{
                              int coins = await getCoinsFromUID();
                              String userwinnername =
                              await getNameFromUID();

                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  if (coins >=
                                      0.25 *
                                          ListProviderWishList(context)[widget.id]
                                              .minBid) {
                                    if (coins <
                                        0.25 *
                                            (ListProviderWishList(context)[widget.id]
                                                .minBid)) {
                                      errorText =
                                      "Coins Lower than 25% of Product Price";
                                    } else if (coins < 0.25 * bidsValue) {
                                      errorText =
                                      "Coins Lower than 25% of Bid Amount";
                                    } else if (bidsValue >
                                        ListProviderWishList(context)[widget.id]
                                            .minBid) {
                                      ProductService proServices = Provider.of<ProductService>(context,listen: false);
                                      loading(context);
                                      proServices.getProductCategory("Cars");
                                      proServices.getProductCategory("Estates");
                                      proServices.getProductCategory("Plates");
                                      proServices.getProductCategory("Coins");
                                      proServices.getProductCategory("Other");
                                      ListProviderWishList(context)[widget.id]
                                          .minBid =
                                          bidsValue;
                                      setMinBidFromUID(
                                          bidsValue,
                                          ListProviderWishList(context)[widget.id]
                                              .name);
                                      ListProviderWishList(context)[widget.id]
                                          .userwinner = userwinnername;
                                      if(ListProviderWishList(context)[widget.id]
                                          .userwinner == userwinnername ){
                                        Navigator.pop(context);
                                      }
                                    }
                                  }}
                              });
                            },
                          ),
                        )
                            : Text(
                          "Bid Is Endded The Winner is ${ListProviderWishList(context)[widget.id].userwinner[0]}",
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
  return  totalClasses;
}

Future<String> getNameFromUID() async {
  String totalClasses = await FirebaseFirestore.instance
      .collection('User')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .get()
      .then((value) {
    return "${value.data()['firstname']} ${value.data()['lastname']}"; // Access your after your get the data
  });
  return totalClasses;
}

void setMinBidFromUID(var eCoins, String index) async {
  await FirebaseFirestore.instance
      .collection('Products')
      .doc(index)
      .update({'minBid': eCoins});
}
