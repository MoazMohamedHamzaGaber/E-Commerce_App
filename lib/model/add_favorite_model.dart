class AddFavoriteModel
{
  dynamic status;
  dynamic message;
  AddFavoriteDataModel? data;

  AddFavoriteModel.fromJson(dynamic json)
  {
    status = json['status'];
    message = json['message'];
    data = AddFavoriteDataModel.fromJson(json['data']);
  }
}
class AddFavoriteDataModel
{
  dynamic id;
  AddFavoriteDataProductModel? product;

  AddFavoriteDataModel.fromJson(dynamic json)
  {
    id = json['id'];
    product = AddFavoriteDataProductModel.fromJson(json['product']);
  }
}
class AddFavoriteDataProductModel
{
  dynamic id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  dynamic image;


  AddFavoriteDataProductModel.fromJson(dynamic json)
  {
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
  }
}