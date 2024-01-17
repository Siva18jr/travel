class CategoryModel {

  String? id;
  String? imgUrl;
  String? name;

  CategoryModel({this.id, this.imgUrl, this.name});

  CategoryModel.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    imgUrl = json['img_url'];
    name = json['name'];

  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['img_url'] = imgUrl;
    data['name'] = name;
    return data;

  }

}