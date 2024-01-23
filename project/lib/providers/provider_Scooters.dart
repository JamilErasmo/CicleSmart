class ScootersDataModel {
  int? id;
  String? name;
  String? category;
  String? imageURL;
  double? longitude;
  String? price;

  ScootersDataModel(
      {this.id,
      this.name,
      this.category,
      this.imageURL,
      this.longitude,
      this.price});

  ScootersDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    imageURL = json['imageUrl'];
    longitude = json['longitude'];
    price = json['price'];
  }
}
