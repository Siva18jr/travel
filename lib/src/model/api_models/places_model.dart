class PlacesModel {

  String? id;
  String? category;
  String? city;
  String? country;
  String? description;
  String? imgUrl;
  String? place;
  String? price;
  String? title;
  String? coordinates;

  PlacesModel({
    this.id,
    this.category,
    this.city,
    this.country,
    this.description,
    this.imgUrl,
    this.place,
    this.price,
    this.title,
    this.coordinates
  });

  PlacesModel.fromJson(Map<dynamic, dynamic> json) {

    id = json['id'];
    category = json['category'];
    city = json['city'];
    country = json['country'];
    description = json['description'];
    imgUrl = json['img_url'];
    place = json['place'];
    price = json['price'];
    title = json['title'];
    coordinates = json['coordinates'];

  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['city'] = city;
    data['country'] = country;
    data['description'] = description;
    data['img_url'] = imgUrl;
    data['place'] = place;
    data['price'] = price;
    data['title'] = title;
    data['coordinates'] = coordinates;
    return data;

  }

}