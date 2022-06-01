import 'package:e_auction/firstscreen/home/components/Products/product_container.dart';
import 'package:e_auction/firstscreen/home/components/Products/product_controller.dart';
import 'package:e_auction/Providers/productservices.dart';
import 'package:e_auction/firstscreen/home/components/WishList/product_details_wish.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constant.dart';
import '../../home_screen.dart';

class wishListPage extends StatefulWidget {
  @override
  State<wishListPage> createState() => _wishListPageState();
}

class _wishListPageState extends State<wishListPage> {

  @override
  Widget build(BuildContext context) {
    ProductService proServices = Provider.of<ProductService>(context,listen: false);
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
          title: Text("Favourite Products"),
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: proServices.getWishLists(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (ListProviderWishList(context).isEmpty == true) {
                return Center(child: Text("No Products Available Now Here",style:headingStyle2 ,));
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: ListProviderWishList(context).length,
                    itemBuilder: (ctx, i) {
                      return ProductContainer(
                        name: ListProviderWishList(context)[i].name,
                        description: ListProviderWishList(context)[i].description,
                        mainPic: ListProviderWishList(context)[i].mainPic,
                        location: ListProviderWishList(context)[i].location,
                        minBid: ListProviderWishList(context)[i].minBid,
                        endDate: ListProviderWishList(context)[i].endDate,
                        userwinner: ListProviderWishList(context)[i].userwinner,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => ProductDetailsWish(id: i),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              }
                return Text("Loading...");
            },
          ),
        ),
      ),
    );
  }
}
