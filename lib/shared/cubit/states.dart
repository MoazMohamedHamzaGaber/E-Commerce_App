import 'package:chat_app/model/add_cart_model.dart';
import 'package:chat_app/model/add_favorite_model.dart';
import 'package:chat_app/model/login_model.dart';

abstract class AppStates{}

class AppInitialStates extends AppStates{}

class ChangeObscureTextStates extends AppStates{}

class AppChangeBottomStates extends AppStates{}

class PlusStates extends AppStates{}

class MinusStates extends AppStates{}

class LoginSuccessStates extends AppStates{
  final AppModel appModel;

  LoginSuccessStates(this.appModel);
}

class LoginLoadingStates extends AppStates{}

class LoginErrorStates extends AppStates{
  final String error;

  LoginErrorStates(this.error);
}

class RegisterSuccessStates extends AppStates{
  final AppModel appModel;

  RegisterSuccessStates(this.appModel);
}

class RegisterLoadingStates extends AppStates{}

class RegisterErrorStates extends AppStates{
  final String error;

  RegisterErrorStates(this.error);
}

class HomeDataSuccessStates extends AppStates{}

class HomeDataLoadingStates extends AppStates{}

class HomeDataErrorStates extends AppStates{
  final String error;

  HomeDataErrorStates(this.error);
}

class CategorySuccessStates extends AppStates{}

class CategoryLoadingStates extends AppStates{}

class CategoryErrorStates extends AppStates{
  final String error;

  CategoryErrorStates(this.error);
}

class AddFavoriteSuccessStates extends AppStates{
  final AddFavoriteModel addFavoriteModel;

  AddFavoriteSuccessStates(this.addFavoriteModel);
}
class AddFavoriteStates extends AppStates{}

class AddFavoriteLoadingStates extends AppStates{}

class AddFavoriteErrorStates extends AppStates{
  final String error;

  AddFavoriteErrorStates(this.error);
}

class AddCartSuccessStates extends AppStates{
  final AddCartModel addCartModel;

  AddCartSuccessStates(this.addCartModel);
}

class AddCartLoadingStates extends AppStates{}

class AddCartStates extends AppStates{}

class AddCartErrorStates extends AppStates{
  final String error;

  AddCartErrorStates(this.error);
}

class CartSuccessStates extends AppStates{}

class CartLoadingStates extends AppStates{}

class CartErrorStates extends AppStates{
  final String error;

  CartErrorStates(this.error);
}

class FavoriteSuccessStates extends AppStates{}

class FavoriteLoadingStates extends AppStates{}

class FavoriteErrorStates extends AppStates{
  final String error;

  FavoriteErrorStates(this.error);
}

class SearchSuccessStates extends AppStates{}

class SearchLoadingStates extends AppStates{}

class SearchErrorStates extends AppStates{
  final String error;

  SearchErrorStates(this.error);
}

class ProfileSuccessStates extends AppStates{}

class ProfileLoadingStates extends AppStates{}

class ProfileErrorStates extends AppStates{
  final String error;

  ProfileErrorStates(this.error);
}

class UpdateProfileSuccessStates extends AppStates{}

class UpdateProfileLoadingStates extends AppStates{}

class UpdateProfileErrorStates extends AppStates{
  final String error;

  UpdateProfileErrorStates(this.error);
}