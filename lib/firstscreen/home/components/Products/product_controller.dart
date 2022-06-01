
import 'package:e_auction/firstscreen/home/components/Products/product_model.dart';
import 'package:e_auction/Providers/productservices.dart';
import 'package:provider/provider.dart';
List<ProductModel> ListProvider(context){
  List<ProductModel> products;
  ProductService proServices = Provider.of<ProductService>(context,listen: false);
  return products = proServices.getProducts();
}
List<ProductModel> ListProviderWishList(context){
  List<ProductModel> products;
  ProductService proServices = Provider.of<ProductService>(context,listen: false);
  return products = proServices.getWishList();
}

List<ProductModel> ListcatProvider(context,String category){
  List<ProductModel> productss;
  List<ProductModel> cars=[] ;
  List<ProductModel> estate=[] ;
  List<ProductModel> coins=[] ;
  List<ProductModel> plates=[] ;
  List<ProductModel> other=[] ;
  ProductService proServices = Provider.of<ProductService>(context,listen: false);
  if(category == "Cars"){
    return cars = proServices.getcats(category);

  }else if(category == "Plates"){
    return plates = proServices.getcats(category);

  }else if(category == "Estates"){
    return estate = proServices.getcats(category);

  }else if(category == "Coins"){
    return coins = proServices.getcats(category);

  }else if(category == "Other"){
    return other = proServices.getcats(category);

  }
}


