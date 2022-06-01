import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/constants/constant.dart';
import 'package:e_auction/Providers/productservices.dart';
import 'package:e_auction/firstscreen/home/components/Products/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:provider/provider.dart';

class ProductContainer extends StatefulWidget  {
   ProductContainer({
    Key key,
    this.boxFit,
     this.mainPic,
     this.name,
     this.description,
     this.location,
     this.minBid,
     this.coins,
     this.onTap, this.endDate,
    this.userwinner, this.isFav,
  });
  final String mainPic, name, location, description,endDate;
  final double coins;
    bool isFav;
  final String userwinner;
  final int  minBid;
  final Function onTap;
  final BoxFit boxFit;
final String assetPath ="assets/images/product/lambo5.jpeg" ;
  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer>  {
  @override
  Icon icon = Icon(Icons.favorite_border,color: Colors.black,);

  Widget build(BuildContext context) {
    ProductService proServices = Provider.of<ProductService>(context,listen: false);
    proServices.findByName(widget.name).whenComplete(() async {
      if(await proServices.findByName(widget.name) == true) {
        setState(() {
          icon =  Icon(Icons.favorite,color: Colors.red,);
        });
      }
      if( await proServices.findByName(widget.name)!=true) {
        setState(() {
          icon = Icon(Icons.favorite_border,color: Colors.black,);
        });
      }

    }).timeout(Duration(seconds: 3));
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(9.0),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 5.0, offset: Offset(0, 3))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: widget.assetPath,
                      image: widget.mainPic,
                      fit: widget.boxFit,
                      alignment: Alignment.topCenter,
                      fadeInDuration: const Duration(milliseconds: 350),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),

                      CountDownText(
                        due: DateTime.parse(widget.endDate),
                        finishedText: "Auction Closed",
                        showLabel: true,
                        longDateName: true,
                        daysTextLong: " D: ",
                        hoursTextLong: " H: ",
                        minutesTextLong: " M: ",
                        secondsTextLong: " S ",
                        style: const TextStyle(color: kPrimaryColor),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            Text(
              widget.description,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .apply(color: Colors.grey),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 9),

            Row(
              children: [
                Text(
                  "${widget.minBid} EGP",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .apply(fontWeightDelta: 2),
                ),
                const Expanded(child: SizedBox(width: 2,)),
                   IconButton(
                  onPressed: ()
                  {
                    proServices.findByName(widget.name).then((value) async => {
                    proServices.getWishList(),
                      if(await proServices.findByName(widget.name) == true) {
                        setState(() {
                          widget.isFav = false;
                          icon = Icon(Icons.favorite_border, color: Colors.black,);
                          proServices.getWishList().removeWhere((item) =>item.name == widget.name);
                          proServices.removeByName(widget.name);
                          proServices.getWishList();
                        }),

                      },
                        if(await proServices.findByName(widget.name) == false) {
                        setState(() {
                          widget.isFav = true;
                          proServices.getWishList().add(ProductModel(mainPic: widget.mainPic, name: widget.name, description: widget.description, location: widget.location, minBid: widget.minBid, coins: widget.coins, onTap: widget.onTap, endDate: widget.endDate));
                          FirebaseFirestore.instance.collection('WishList').doc(FirebaseAuth.instance.currentUser.uid).collection('WishList').doc(widget.name).set(
                              {
                                'name': widget.name,
                                'description': widget.description,
                                'mainPic': widget.mainPic,
                                'location': widget.location,
                                'minBid': widget.minBid,
                                'userwinner': widget.userwinner,
                                'endDate': widget.endDate,

                              }
                          );
                          icon = Icon(
                            Icons.favorite,
                            color: Colors.red,
                          );
                          proServices.getWishList();
                        }),

                      }
                    });

                }, icon: icon ),
                const Expanded(child: SizedBox(width: 2,)),

                Text(
                  widget.location,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .apply(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
