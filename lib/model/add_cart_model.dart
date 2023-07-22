class AddCartModel
{
  dynamic status;
  dynamic message;
  AddCartDataModel? data;

  AddCartModel.fromJson(dynamic json)
  {
    status = json['status'];
    message = json['message'];
    data = AddCartDataModel.fromJson(json['data']);
  }
}
class AddCartDataModel
{
  dynamic id;
  dynamic quantity;
  AddCartDataProductModel? product;

  AddCartDataModel.fromJson(dynamic json)
  {
    id = json['id'];
    quantity = json['quantity'];
    product = AddCartDataProductModel.fromJson(json['product']);
  }
}
class AddCartDataProductModel
{
  dynamic id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  dynamic image;
  dynamic name;
  dynamic description;


  AddCartDataProductModel.fromJson(dynamic json)
  {
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
  }
}