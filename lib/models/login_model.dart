class LoginModel {
  String? message;

  bool? status;
  UserData? data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
    //if data ==null return null else return UserData.fromJson(json['data'])
  }
}

class UserData {
  int? id;
  String? name;
  String? password;
  String? phone;
  String? image;
  String? token;
  int? points;
  int? credit;

/*  UserData({
    required this.password,
    required this.phone,
    required this.points,
    required  this.image,
    required this.name,
    required this.token,
    this.credit,

    required this.id,
});*/
  // /named constructor
  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    phone = json['phone'];
    points = json['points'];
    image = json['image'];
    name = json['name'];
    token = json['token'];
    credit = json['credit'];
  }
}
