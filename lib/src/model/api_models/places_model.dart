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

  PlacesModel(
      {this.id,
        this.category,
        this.city,
        this.country,
        this.description,
        this.imgUrl,
        this.place,
        this.price,
        this.title});

  PlacesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    city = json['city'];
    country = json['country'];
    description = json['description'];
    imgUrl = json['img_url'];
    place = json['place'];
    price = json['price'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['city'] = this.city;
    data['country'] = this.country;
    data['description'] = this.description;
    data['img_url'] = this.imgUrl;
    data['place'] = this.place;
    data['price'] = this.price;
    data['title'] = this.title;
    return data;
  }
}
