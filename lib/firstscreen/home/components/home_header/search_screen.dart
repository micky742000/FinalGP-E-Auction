import 'package:e_auction/firstscreen/home/components/Products/product_controller.dart';
import 'package:e_auction/firstscreen/home/components/Products/product_model.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import '../../../../constants/constant.dart';
import '../Products/product_details_page.dart';


class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'search_page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: ListView.builder(
        itemCount: ListProvider(context).length,
        itemBuilder: (context, index) {
          final ProductModel person = ListProvider(context)[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: ListTile(
                title: Text(person.name),
                subtitle: Text("End Date is ${person.endDate}"),
                trailing: Text('Highest Bid is ${person.minBid} EGP'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ProductDetailsPage(id: index);
                  } ),);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Search people',
        onPressed: () => showSearch(
          context: context,
          delegate: SearchPage<ProductModel>(
            onQueryUpdate: (s) => print(s),
            items: ListProvider(context),
            searchLabel: 'Search people',
            suggestion: Center(
              child: Text('Filter people by name, surname or age'),
            ),
            failure: Center(
              child: Text('No person found :('),
            ),
            filter: (person) => [
              person.name,
              person.endDate,
              person.minBid.toString(),
            ],
            builder: (person) => ListTile(
              title: Text(person.name),
              subtitle: Text(person.endDate),
              trailing: Text('${person.minBid} EGP'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ProductDetailsPage(id: 1);
              } ),);
            },
            ),
          ),
        ),
        child: Icon(Icons.search),
      ),
    );
  }
}