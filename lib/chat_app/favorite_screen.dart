import 'package:chat_app/model/favorite_model.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit=AppCubit().get(context);
        if(AppCubit().get(context).favoriteModel!.data!.data.length >0)
        {
          return Scaffold(
            backgroundColor: Color(0xff2B475E),
            body: ConditionalBuilder(
              condition: cubit.favoriteModel !=null ,
              builder: (context)=>ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index)=>buildFavorite(cubit.favoriteModel!.data!.data[index],context),
                itemCount: cubit.favoriteModel!.data!.data.length,
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator()),
            ),
          );
        }
        if(cubit.favoriteModel ==null)
          {
            return Center(child: CircularProgressIndicator());
          }
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image(image: NetworkImage('https://thumbs.dreamstime.com/b/beautiful-happy-woman-showing-love-sign-near-eyes-healthy-vision-portrait-holding-heart-shaped-hands-closeup-smiling-83939671.jpg'))),
                SizedBox(
                  height: 10,
                ),
                Text('Your Favorite Is Empty',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Sorry, the keyword you entered cannot be found,  please check again or search with another keyword.',
                  style: TextStyle(
                    fontSize: 16,
                    //fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}
Widget buildFavorite(DataModel model,context)=>Padding(
  padding: const EdgeInsets.all(8.0),
  child: Stack(
    alignment: AlignmentDirectional.topEnd,
    children: [
      Card(
        color: Colors.transparent,
        shadowColor: Colors.grey,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            //color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                //color: Color.fromARGB(255, 228, 228, 228),
                color: Colors.transparent,
                offset: Offset(2, 3),
                blurRadius: 5,
                spreadRadius: 0.1,
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Container(
                width: 120,
                height: 110,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    //fit: BoxFit.cover,
                    image: NetworkImage(
                      model.product!.image!,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 160,
                    child: Text(
                      model.product!.name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '\$${model.product!.price!.round()}',
                        style: TextStyle(color: Colors.grey,fontSize: 18),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if(model.product!.discount !=0)
                        Text(
                          '\$${model.product!.oldPrice!.round()}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      // Spacer(),
                      SizedBox(
                        width: 50,
                      ),

                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 134,
                          height: 40,
                          padding: EdgeInsets.all(8),
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppCubit().get(context).cart[model.product!.id!]!? Colors.orange:Colors.blueGrey,
                          ),
                          child: MaterialButton(
                            onPressed: (){
                              AppCubit().get(context).addCart(produc_id: model.product!.id!);
                              // print(productsModel.id);
                            },
                            child: AppCubit().get(context).cart[model.product!.id!]!? const Text('Remove From Cart',
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
                        //Spacer(),
                        SizedBox(
                          width: 15,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                            child: IconButton(
                              onPressed: (){
                                AppCubit().get(context).addFavorite(product_id: model.product!.id!);
                              },
                              icon: Icon(
                                AppCubit().get(context).favorite[model.product!.id!]! ? Icons.favorite:Icons.favorite_border,
                                color:AppCubit().get(context).favorite[model.product!.id!]! ? Colors.blueAccent[300]: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      if(model.product!.discount !=0)
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
          margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          child: Text('DISCOUNT',
            style: TextStyle(
                color: Colors.white
            ),
          ),
        )
    ],
  ),
);
















// import 'package:chat_app/model/favorite_model.dart';
// import 'package:chat_app/shared/cubit/cubit.dart';
// import 'package:chat_app/shared/cubit/states.dart';
// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class FavoriteScreen extends StatelessWidget {
//   const FavoriteScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit,AppStates>(
//       listener: (context,state){},
//       builder: (context,state)
//       {
//         var cubit=AppCubit().get(context);
//         if(AppCubit().get(context).favoriteModel!.data!.data.length >0)
//         {
//           return Scaffold(
//             backgroundColor: Color(0xff2B475E),
//             body: ConditionalBuilder(
//               condition: cubit.favoriteModel !=null ,
//               builder: (context)=>ListView.builder(
//                 physics: BouncingScrollPhysics(),
//                 itemBuilder: (context,index)=>buildFavorite(cubit.favoriteModel!.data!.data[index],context),
//                 itemCount: cubit.favoriteModel!.data!.data.length,
//               ),
//               fallback: (context)=>Center(child: CircularProgressIndicator()),
//             ),
//           );
//         }
//         return Center(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Card(
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                     child: Image(image: NetworkImage('https://thumbs.dreamstime.com/b/beautiful-happy-woman-showing-love-sign-near-eyes-healthy-vision-portrait-holding-heart-shaped-hands-closeup-smiling-83939671.jpg'))),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text('Your Favorite Is Empty',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text('Sorry, the keyword you entered cannot be found,  please check again or search with another keyword.',
//                   style: TextStyle(
//                     fontSize: 16,
//                     //fontWeight: FontWeight.bold,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//
// }
