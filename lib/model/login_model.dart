class AppModel
{
  bool? status;
  String? message;
  DataModel? data;

  AppModel.fromJson(dynamic json)
  {
    status=json['status'];
    message=json['message'];
    data=json['data']!=null?DataModel.fromJson(json['data']):null;
  }
}
class DataModel
{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  DataModel.fromJson(dynamic json)
  {
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    token=json['token'];
  }
}