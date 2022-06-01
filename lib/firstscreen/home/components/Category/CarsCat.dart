import 'package:e_auction/firstscreen/home/components/Products/product_container.dart';
import 'package:e_auction/firstscreen/home/components/Products/product_controller.dart';
import 'package:e_auction/Providers/productservices.dart';
import 'package:e_auction/firstscreen/home/components/Category/product_details_cats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constant.dart';

class CategoryCards extends StatefulWidget {
  final String category;
  CategoryCards(@required this.category);
  @override
  State<CategoryCards> createState() => _CategoryCardsState();
}

class _CategoryCardsState extends State<CategoryCards> {
  @override
  Widget build(BuildContext context) {
    ProductService proServices =
        Provider.of<ProductService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAccentColor,
        title: Text(widget.category),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: proServices.getcatss(widget.category),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (ListcatProvider(context, widget.category).isEmpty == true) {
              return Center(child: Text("No Products Available Now Here",style:headingStyle2 ,));
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: ListcatProvider(context, widget.category).length,
                  itemBuilder: (ctx, i) {
                        ListcatProvider(context, widget.category)[i].category;
                    return ProductContainer(
                      name: ListcatProvider(context, widget.category)[i].name,
                      description: ListcatProvider(context, widget.category)[i]
                          .description,
                      mainPic:
                          ListcatProvider(context, widget.category)[i].mainPic,
                      location:
                          ListcatProvider(context, widget.category)[i].location,
                      minBid:
                          ListcatProvider(context, widget.category)[i].minBid,
                      endDate:
                          ListcatProvider(context, widget.category)[i].endDate,
                      userwinner: ListcatProvider(context, widget.category)[i]
                          .userwinner,
                      onTap: () async {
                        int x = ListcatProvider(context, widget.category).indexOf(ListcatProvider(context, widget.category)[i]);
                        print(x);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => ProductDetailsCategory(id:i,category: widget.category,),
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
        ),
      ),
    );
  }
}
