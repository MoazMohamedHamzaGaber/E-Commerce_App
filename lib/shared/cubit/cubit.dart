import 'package:bloc/bloc.dart';
import 'package:chat_app/chat_app/category_screen.dart';
import 'package:chat_app/chat_app/favorite_screen.dart';
import 'package:chat_app/chat_app/home_screen.dart';
import 'package:chat_app/chat_app/setting_screen.dart';
import 'package:chat_app/model/add_cart_model.dart';
import 'package:chat_app/model/add_favorite_model.dart';
import 'package:chat_app/model/cart_Model.dart';
import 'package:chat_app/model/category_model.dart';
import 'package:chat_app/model/favorite_model.dart';
import 'package:chat_app/model/home_model.dart';
import 'package:chat_app/model/login_model.dart';
import 'package:chat_app/model/profile_model.dart';
import 'package:chat_app/model/search_model.dart';
import 'package:chat_app/model/update_profile.dart';
import 'package:chat_app/shared/constant.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/shared/dio/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit():super(AppInitialStates());

  AppCubit get(context)=>BlocProvider.of(context);


  CartItemModel? cartItemModel;

  bool obscureText=true;

  void changeObscure()
  {
    obscureText=!obscureText;
    emit(ChangeObscureTextStates());
  }

  int currentIndex=0;

  List<Widget>screens=[
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  List<String>titles=[
    'Home',
    'Categories',
    'Favorite',
    'Setting'
  ];

  void changeBottomNav(index)
  {
    currentIndex=index;
    emit(AppChangeBottomStates());
  }

  AppModel? appModel;

  void userLogin({
  required String email,
  required String password,
})
  {
    emit(LoginLoadingStates());
    DioHelper.postData(
        url: 'login',
        //token: token,
        data: {
          'email':email,
          'password':password,
        },
    ).then((value)
    {
      appModel=AppModel.fromJson(value.data);
      //print(value.data);
      //print(appModel!.status);
      //print(appModel!.message);
      emit(LoginSuccessStates(appModel!));
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(LoginErrorStates(error.toString()));
    }
    );
  }

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  })
  {
    emit(RegisterLoadingStates());
    DioHelper.postData(
      url: 'register',
      data: {
        'email':email,
        'password':password,
        'name':name,
        'phone':phone,
      },
    ).then((value)
    {
      appModel=AppModel.fromJson(value.data);
      //print(value.data);
      //print(appModel!.status);
      //print(appModel!.message);
      emit(RegisterSuccessStates(appModel!));
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(RegisterErrorStates(error.toString()));
    }
    );
  }


  HomeModel? homeModel;

  Map<int,bool>favorite={};
  Map<int,bool>cart={};
  void getDataHome()
  {
    emit(HomeDataLoadingStates());
    DioHelper.getData(
        url: 'home',
      token: token,
    ).then((value)
    {
      homeModel=HomeModel.fromJson(value.data);
      //print(value.data);
      //print(homeModel!.data!.products[0].name);
      homeModel!.data!.products.forEach((element) {
        favorite.addAll({
          element.id:element.in_favorites,
        });
      });
      homeModel!.data!.products.forEach((element) {
        cart.addAll({
          element.id:element.in_cart,
        });
      });
      //print(favorite.toString());
      //print(cart.toString());
      emit(HomeDataSuccessStates());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(HomeDataErrorStates(error.toString()));
    }
    );
  }

  CategoryModel? categoryModel;
  void getCategory()
  {
    emit(CategoryLoadingStates());
    DioHelper.getData(
      url: 'categories',
      token: token,
    ).then((value)
    {
      categoryModel=CategoryModel.fromJson(value.data);
      //print(value.data);
      //print(categoryModel!.data!.data[0].name);
      emit(CategorySuccessStates());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(CategoryErrorStates(error.toString()));
    }
    );
  }

  AddFavoriteModel? addFavoriteModel;

  void addFavorite({
  required int product_id,
})
  {
    favorite[product_id]=! favorite[product_id]!;
    emit(AddFavoriteStates());
    DioHelper.postData(
        url: 'favorites',
        data: {
          'product_id':product_id
        },
      token: token,
    ).then((value)
    {
      addFavoriteModel=AddFavoriteModel.fromJson(value.data);
      //print(value.data);
      //print(addFavoriteModel!.message);
      if(!addFavoriteModel!.status!)
        {
          favorite[product_id]=! favorite[product_id]!;
        }
      else
        {
          getFavorite();
        }
      emit(AddFavoriteSuccessStates(addFavoriteModel!));
    }
    ).catchError((error)
    {
      favorite[product_id]=! favorite[product_id]!;
      emit(AddFavoriteErrorStates(error.toString()));
    }
    );
  }

  FavoriteModel? favoriteModel;
  void getFavorite()
  {
    emit(FavoriteLoadingStates());
    DioHelper.getData(
      url: 'favorites',
      token: token,
    ).then((value)
    {
      favoriteModel=FavoriteModel.fromJson(value.data);
      //print(value.data);
      //print(favoriteModel!.data!.data[0].product!.name);
      emit(FavoriteSuccessStates());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(FavoriteErrorStates(error.toString()));
    }
    );
  }

  AddCartModel? addCartModel;

  void addCart({
    required int produc_id,
  })
  {
    cart[produc_id]=! cart[produc_id]!;
    emit(AddCartStates());
    DioHelper.postData(
      url: 'carts',
      data: {
        'product_id':produc_id
      },
      token: token,
    ).then((value)
    {
      addCartModel=AddCartModel.fromJson(value.data);
      //print(value.data);
      //print(addCartModel!.message);
       if(!addCartModel!.status!)
       {
         cart[produc_id]=! cart[produc_id]!;
       }
       else
         {
           getCart();
         }
      emit(AddCartSuccessStates(addCartModel!));
    }
    ).catchError((error)
    {
      cart[produc_id]=! cart[produc_id]!;
      emit(AddCartErrorStates(error.toString()));
    }
    );
  }

  CartModel? cartModel;
  void getCart()
  {
    //cart[produc_id]=! cart[produc_id]!;
    emit(CartLoadingStates());
    DioHelper.getData(
      url: 'carts',
      token: token,
    ).then((value)
    {
      cartModel=CartModel.fromJson(value.data);
      //print(value.data);
     // print(cartModel!.data!.cart_items[0].product!.name);
      emit(CartSuccessStates());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(CartErrorStates(error.toString()));
    }
    );
  }

  late SearchModel searchModel;

  void getSearch({
    required String text,
  })
  {
    emit(SearchLoadingStates());
    DioHelper.postData(
      url: 'products/search',
      data: {
        'text':text
      },
      token: token,
    ).then((value)
    {
      searchModel=SearchModel.fromJson(value.data);
      //print(value.data);
      //print(searchModel.data!.data[0].name);
      emit(SearchSuccessStates());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorStates(error.toString()));
    }
    );
  }

  ProfileModel? profileModel;
  void getProfile()
  {
    emit(ProfileLoadingStates());
    DioHelper.getData(
      url: 'profile',
      token: token,
    ).then((value)
    {
      profileModel=ProfileModel.fromJson(value.data);
      print(value.data);
      print(profileModel!.data!.name);
      emit(ProfileSuccessStates());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(ProfileErrorStates(error.toString()));
    }
    );
  }

  UpdateProfileModel? updateProfileModel;

  void updateUserData({
  required String name,
  required String email,
  required String phone,
})
  {
    emit(UpdateProfileLoadingStates());
    DioHelper.putData(
        url: 'update-profile',
        token: token,
        data: {
          'name':name,
          'email':email,
          'phone':phone,
    }).then((value)
  {
    updateProfileModel=UpdateProfileModel.fromJson(value.data);
    print(updateProfileModel!.data!.email);
    emit(UpdateProfileSuccessStates());
  }
  ).catchError((error)
  {
   print(error.toString());
   emit(UpdateProfileErrorStates(error.toString()));
  }
  );
}
}