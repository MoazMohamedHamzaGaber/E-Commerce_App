import 'package:chat_app/model/home_model.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is AddCartSuccessStates)
          {
            if(state.addCartModel.status!)
              {
                Fluttertoast.showToast(
                    msg: state.addCartModel.message!,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
            else
              {
                Fluttertoast.showToast(
                    msg: state.addCartModel.message!,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
          }
        if(state is AddFavoriteSuccessStates)
        {
          if(state.addFavoriteModel.status!)
          {
            Fluttertoast.showToast(
                msg: state.addFavoriteModel.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          else
          {
            Fluttertoast.showToast(
                msg: state.addFavoriteModel.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = AppCubit().get(context);
        return Scaffold(
          backgroundColor: Color(0xff2B475E),
          body: Padding(
            padding: EdgeInsets.only(top: 50),
            child: ConditionalBuilder(
              condition: cubit.homeModel !=null,
              builder: (context)=>GridView.builder(
                physics: BouncingScrollPhysics(),
                clipBehavior: Clip.none,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.36,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) =>
                    buildGridView(cubit.homeModel!.data!.products[index],context),
                itemCount: cubit.homeModel!.data!.products.length,
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}

Widget buildGridView(ProductsModel productsModel,context) => Column(
  children: [
    Stack(
      //alignment: Alignment.topRight,
      alignment: AlignmentDirectional.topStart,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 200,
          width: 180,
          child: Card(
            color: Colors.transparent,
            shadowColor: Colors.grey,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productsModel.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Row(
                    children: [
                      Text(
                        '\$${productsModel.price.round()}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (productsModel.discount != 0)
                        Text(
                          '\$${productsModel.old_price.round()}',
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                        child: IconButton(
                          onPressed: (){
                            AppCubit().get(context).addFavorite(product_id: productsModel.id);
                          },
                          icon: Icon(
                            AppCubit().get(context).favorite[productsModel.id]!? Icons.favorite: Icons.favorite_border,
                            color:AppCubit().get(context).favorite[productsModel.id]! ? Colors.blueAccent:Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    padding: EdgeInsets.all(8),
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                        color: AppCubit().get(context).cart[productsModel.id]!? Colors.orange:Colors.blueGrey,
                    ),
                    child: MaterialButton(
                        onPressed: (){
                          AppCubit().get(context).addCart(produc_id: productsModel.id);
                          print(productsModel.id);
                        },
                      child: AppCubit().get(context).cart[productsModel.id]!? const Text('Remove From Cart',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ): const Text('Add To Cart',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 20,
          bottom: 130,
          child: Image(
            image: NetworkImage(productsModel.image),
            height: 100,
            width: 80,
          ),
        ),
        if(productsModel.discount!=0)
          Container(
            padding: EdgeInsets.symmetric(vertical: 3,horizontal: 4),
            decoration: const BoxDecoration(
                color: Colors.red
            ),
            child: const Text('DISCOUNT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
      ],
    ),
  ],
);
