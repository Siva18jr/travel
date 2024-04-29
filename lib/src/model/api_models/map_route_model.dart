class MapRouteModel {

  String? userLatitude;
  String? userLongitude;
  String? placeLatitude;
  String? placeLongitude;

  MapRouteModel(
      {this.userLatitude,
        this.userLongitude,
        this.placeLatitude,
        this.placeLongitude});

  MapRouteModel.fromJson(Map<String, dynamic> json) {

    userLatitude = json['user_latitude'];
    userLongitude = json['user_longitude'];
    placeLatitude = json['place_latitude'];
    placeLongitude = json['place_longitude'];

  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_latitude'] = userLatitude;
    data['user_longitude'] = userLongitude;
    data['place_latitude'] = placeLatitude;
    data['place_longitude'] = placeLongitude;
    return data;

  }

}