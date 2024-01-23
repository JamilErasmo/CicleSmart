class BicicletasDataModel {
  int? id;
  String? name;
  double? latitude;
  String? category;
  String? imageURL;
  double? longitude;
  String? price;
  String? battery;

  BicicletasDataModel(
      {this.id,
      this.name,
      this.latitude,
      this.category,
      this.imageURL,
      this.longitude,
      this.price,
      this.battery});

  BicicletasDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    category = json['category'];
    imageURL = json['imageUrl'];
    longitude = json['longitude'];
    price = json['price'];
    battery = json['battery'];
  }
}
