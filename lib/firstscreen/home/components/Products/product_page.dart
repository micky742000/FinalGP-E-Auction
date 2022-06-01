import 'package:e_auction/firstscreen/home/components/Products/product_container.dart';
import 'package:e_auction/firstscreen/home/components/Products/product_controller.dart';
import 'package:e_auction/firstscreen/home/components/Products/product_details_page.dart';
import 'package:e_auction/Providers/productservices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  @override
  Widget build(BuildContext context) {
    ProductService proServices = Provider.of<ProductService>(context,listen: false);
    return FutureBuilder(
      future: proServices.getProductss(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: ListProvider(context).length,
              itemBuilder: (ctx, i) {
                return ProductContainer(
                  name: ListProvider(context)[i].name,
                  description: ListProvider(context)[i].description,
                  mainPic: ListProvider(context)[i].mainPic,
                  location: ListProvider(context)[i].location,
                  minBid: ListProvider(context)[i].minBid,
                  endDate: ListProvider(context)[i].endDate,
                  userwinner: ListProvider(context)[i].userwinner,
                  onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => ProductDetailsPage(id: i),
                          ),
                        );

                  },
                );
              },
            ),
          );
        } else
          return Text("Loading...");
      },
    );
  }
}
