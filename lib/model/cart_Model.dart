class CartModel
{
  dynamic status;
  CartDataModel? data;

  CartModel.fromJson(dynamic json)
  {
    status = json['status'];
    data=CartDataModel.fromJson(json['data']);
  }
}
class CartDataModel
{
  dynamic sub_total;
  dynamic total;
  List<CartItemModel>cart_items=[];
  CartDataModel.fromJson(dynamic json)
  {
    sub_total = json['sub_total'];
    total = json['total'];

    json['cart_items'].forEach((element)
    {
      cart_items.add(CartItemModel.fromJson(element));
    }
    );
  }
}
class CartItemModel
{
  dynamic id;
  dynamic quantity;
  ProductCartItemModel? product;

  CartItemModel.fromJson(dynamic json)
  {
    id = json['id'];
    quantity = json['quantity'];
    product=ProductCartItemModel.fromJson(json['product']);
  }
}
class ProductCartItemModel
{
  dynamic id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  dynamic image;
  dynamic name;
  dynamic description;


  ProductCartItemModel.fromJson(dynamic json)
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