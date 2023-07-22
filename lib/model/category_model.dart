class CategoryModel
{
  dynamic status;
  CategoryDataModel? data;
  CategoryModel.fromJson(dynamic json)
  {
    status = json['status'];
    data=CategoryDataModel.fromJson(json['data']);
  }
}
class CategoryDataModel
{
  dynamic current_page;
  List<DataModel>data=[];

  CategoryDataModel.fromJson(dynamic json)
  {
    current_page = json['current_page'];

    json['data'].forEach((element)
    {
      data.add(DataModel.fromJson(element));
    }
    );
  }

}
class DataModel
{
  dynamic id;
  dynamic name;
  dynamic image;

  DataModel.fromJson(dynamic json)
  {
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}