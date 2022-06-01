import 'package:e_auction/firstscreen/home/components/Products/product_container.dart';

class WishListModel{
  final List<ProductContainer> WishList;

  WishListModel({this.WishList});

  List<ProductContainer> getWishList(){
    return WishList;
  }

}