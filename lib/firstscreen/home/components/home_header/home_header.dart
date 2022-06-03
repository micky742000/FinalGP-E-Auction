import 'package:date_count_down/date_count_down.dart';
import 'package:e_auction/firstscreen/home/components/home_header/coins_field.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import '../../../../constants/constant.dart';
import '../../../../constants/size_config.dart';
import '../Products/product_controller.dart';
import '../Products/product_details_page.dart';
import '../Products/product_model.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            apptitle,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(28),
              fontFamily: 'Muli',
              fontWeight: FontWeight.bold,
              height: 1.5,
                foreground: Paint()..shader = LinearGradient(
                  colors: <Color>[Color(0xff7ba3ea), Color(0xff5e77fa)],
                ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
            ),
          ),
          CoinsField(),
          Container(
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () =>showSearch(
                context: context,
                delegate: SearchPage<ProductModel>(
                  onQueryUpdate: (s) => print(s),
                  items: ListProvider(context),
                  barTheme: ThemeData( primaryColor: Colors.greenAccent,),
                  searchLabel: 'Search Product',
                  suggestion: Center(
                    child: Text('Filter Product by name'),
                  ),
                  failure: Center(
                    child: Text('No Product found :('),
                  ),
                  filter: (person) => [
                    person.name,
                    person.endDate,
                    person.minBid.toString(),
                  ],
                  builder: (person) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 1.3),
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(9.0),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26, blurRadius: 5.0, offset: Offset(0, 3))
                        ],
                      ),
                      child: Center(
                        child: ListTile(
                          leading: Image(image: NetworkImage(person.mainPic)),
                          title: Text(person.name),
                          subtitle: CountDownText(
                            due: DateTime.parse(person.endDate),
                            finishedText: "Auction Closed",
                            showLabel: true,
                            longDateName: true,
                            daysTextLong: " D: ",
                            hoursTextLong: " H: ",
                            minutesTextLong: " M: ",
                            secondsTextLong: " S ",
                            style: const TextStyle(color: kPrimaryColor),
                          ),
                          trailing: Text('${person.minBid} EGP',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,)),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return ProductDetailsPage(id: person.id);
                            } ),);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
