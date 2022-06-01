import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/Providers/user_info.dart';
import 'package:e_auction/firstscreen/home/components/Products/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class ProductService{
  List<ProductModel> productmodel=[] ;
  List<ProductModel> wishListPage=[] ;
  List<ProductModel> productCategory=[] ;
  List<ProductModel> cars=[] ;
  List<ProductModel> estate=[] ;
  List<ProductModel> coins=[] ;
  List<ProductModel> plates=[] ;
  List<ProductModel> other=[] ;


  List<ProductModel> getProducts(){
    return productmodel;
  }
  List<ProductModel> getcats(String category){
    if(category == "Cars"){
      return  cars;

    }else if(category == "Plates"){
      return  plates;

    }else if(category == "Estates"){
      return  estate;

    }else if(category == "Coins"){
      return  coins;

    }else if(category == "Other"){
      return  other;

    }
  }
  Future<List<ProductModel>> getcatss(String category) async{
     if(category == "Cars"){
       return await cars;

     }else if(category == "Plates"){
       return await plates;

     }else if(category == "Estates"){
       return await estate;

     }else if(category == "Coins"){
       return await coins;

     }else if(category == "Other"){
       return await other;

     }
  }

  Future<List<ProductModel>> getProductss() async{
    return await productmodel;
  }
  Future<void> getProduct(context){
    productmodel.clear();
    ProductService proServices = Provider.of<ProductService>(context,listen: false);
    proServices.getData();
  }

  CollectionReference _collectionRef = FirebaseFirestore.instance.collection('Products');

  Future<List<ProductModel>> getProductCategory(String category) async {
    cars.clear();
    plates.clear();
    coins.clear();
    estate.clear();
    other.clear();

    if(category == "Cars"){
      QuerySnapshot query = await _collectionRef
          .where("category", isEqualTo: category)
          .get();

      if(query.docs.isNotEmpty){
        query.docs.forEach((element) {
          cars.add(ProductModel.fromJson(element.data()));

        });
      }
      return await cars;
    }else if(category == "Plates"){
      QuerySnapshot query = await _collectionRef
          .where("category", isEqualTo: category)
          .get();

      if(query.docs.isNotEmpty){
        query.docs.forEach((element) {
          plates.add(ProductModel.fromJson(element.data()));
        });
      }
      return plates;
    }else if(category == "Estates"){
      QuerySnapshot query = await _collectionRef
          .where("category", isEqualTo: category)
          .get();

      if(query.docs.isNotEmpty){
        query.docs.forEach((element) {
          estate.add(ProductModel.fromJson(element.data()));
        });
      }
      return estate;
    }else if(category == "Coins"){
      QuerySnapshot query = await _collectionRef
          .where("category", isEqualTo: category)
          .get();

      if(query.docs.isNotEmpty){
        query.docs.forEach((element) {
          coins.add(ProductModel.fromJson(element.data()));
        });
      }
      return coins;
    }else if(category == "Other"){
      QuerySnapshot query = await _collectionRef
          .where("category", isEqualTo: category)
          .get();

      if(query.docs.isNotEmpty){
        query.docs.forEach((element) {
          other.add(ProductModel.fromJson(element.data()));
        });
      }
      return other;
    }
  }

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    allData.forEach((json) {
      final data = ProductModel.fromJson(json);
      productmodel.add(data);
    });
  }

    Future<void> getWishListData() async {
    await wishListPage.clear();
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('WishList').doc(FirebaseAuth.instance.currentUser.uid).collection('WishList').get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    allData.forEach((json) {
      final data = ProductModel.fromJson(json);
      wishListPage.add(data);

    });

  }

  void removeByName(String name) async {
    var docref =FirebaseFirestore.instance.collection('WishList');
    var snapshot= await docref.doc(FirebaseAuth.instance.currentUser.uid).collection('WishList').where('name', isEqualTo:name).get();
    await snapshot.docs.last.reference.delete();
    await snapshot.docs.first.reference.delete();
    await snapshot.docs.single.reference.delete();
  }
  Future<bool> findByName(String name) async {

    var docref =FirebaseFirestore.instance.collection('WishList');
    var snapshot= await docref.doc(FirebaseAuth.instance.currentUser.uid).collection('WishList').doc(name).get();
    return snapshot.exists;

  }



  List<ProductModel> getWishList() {
    return wishListPage  ;
  }
  Future<List<ProductModel>> getWishLists() async {
    return await wishListPage  ;
  }




  List<String> userinfo =[] ;


  Future<List<String>> getUserDoc() async {
String userName;
String address;
String phonenumber;

    var docSnapshot = await FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser.uid).get();

    Map<String, dynamic> data = docSnapshot.data();

    userName = '${data['firstname']} ${data['lastname']}';
address = '${data['address']}';
phonenumber = '${data['phonenumber']}';

userinfo.add(userName);
userinfo.add(address);
userinfo.add(phonenumber);
print(await userinfo[0]);
    return await userinfo;
  }




  }