class UpdateProfileModel
{
  bool? status;
  String? message;
  UpdateProfileDataModel? data;

  UpdateProfileModel.fromJson(dynamic json)
  {
    status=json['status'];
    message=json['message'];
    data=json['data']!=null?UpdateProfileDataModel.fromJson(json['data']):null;
  }
}
class UpdateProfileDataModel
{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  UpdateProfileDataModel.fromJson(dynamic json)
  {
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    token=json['token'];
  }
}