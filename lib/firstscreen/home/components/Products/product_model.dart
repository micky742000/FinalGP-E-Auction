
class ProductModel {
  final String name, description, mainPic, location;
  int minBid;
  final List<dynamic> photos;
  String userwinner;
  final String category;
  final String endDate;
  final int id;
   bool isFav;
   List<String> favorite;

  ProductModel({
    this.favorite,
    this.isFav,
    this.name,
    this.description,
    this.mainPic,
    this.photos,
    this.location,
    this.minBid,
    this.userwinner,
    this.category,
    this.endDate,
    this.id, double coins, Function onTap
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'mainPic': mainPic,
        'photos': photos,
        'location': location,
        'minBid': minBid,
        'userwinner': userwinner,
        'category': category,
        'endDate': endDate,
    'id':id,
      };

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        name: json['name'],
        description: json['description'],
        mainPic: json['mainPic'],
        photos: json['photos'],
        location: json['location'],
        minBid: json['minBid'],
        userwinner: json['userwinner'],
        category: json['category'],
        endDate: json['endDate'],
        id: json['id'],
    );
  }
}
