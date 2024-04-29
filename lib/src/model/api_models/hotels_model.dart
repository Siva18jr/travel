class HotelsModel {

  String? district;
  List<Hotels>? hotels;
  String? place;

  HotelsModel({this.district, this.hotels, this.place});

  HotelsModel.fromJson(Map<String, dynamic> json) {

    district = json['district'];

    if (json['hotels'] != null) {

      hotels = <Hotels>[];

      json['hotels'].forEach((v) {

        hotels!.add(Hotels.fromJson(v));

      });

    }

    place = json['place'];

  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = <String, dynamic>{};

    data['district'] = district;

    if (hotels != null) {

      data['hotels'] = hotels!.map((v) => v.toJson()).toList();

    }

    data['place'] = place;
    return data;

  }

}

class Hotels {

  String? name;
  String? price;

  Hotels({this.name, this.price});

  Hotels.fromJson(Map<String, dynamic> json) {

    name = json['name'];
    price = json['price'];

  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    return data;

  }

}