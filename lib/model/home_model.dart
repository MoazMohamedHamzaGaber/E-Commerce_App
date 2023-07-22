class HomeModel
{
  dynamic status;
  DataModel? data;

  HomeModel.fromJson(dynamic json)
  {
    status=json['status'];
    data=DataModel.fromJson(json['data']);
  }
}
class DataModel
{
  List<BannerModel>banners=[];
  List<ProductsModel>products=[];


  DataModel.fromJson(dynamic json)
  {
    json['banners'].forEach((element)
    {
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element)
    {
      products.add(ProductsModel.fromJson(element));
    });
  }
}
class BannerModel
{
  dynamic id;
  dynamic image;

  BannerModel.fromJson(dynamic json)
  {
    id=json['id'];
    image=json['image'];
  }
}
class ProductsModel
{
  dynamic id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  dynamic image;
  dynamic name;
  dynamic in_favorites;
  dynamic in_cart;

  ProductsModel.fromJson(dynamic json)
  {
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    in_favorites=json['in_favorites'];
    in_cart=json['in_cart'];
  }
}