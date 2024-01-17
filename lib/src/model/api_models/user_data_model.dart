class UserDataModel {

  String? id;
  String? name;
  String? email;
  String? password;

  UserDataModel({required this.id, required this.name, required this.email, required this.password});

  UserDataModel.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];

  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    return data;

  }

}