import 'package:chat_app/model/search_model.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
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
          appBar: AppBar(
            backgroundColor: Color(0xff2B475E),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new),
            ),
            title: const Text(
              'Search',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  TextField(
                    // validator: (v) {
                    //   if (v!.isEmpty) {
                    //     return 'Search Can\'t be Empty';
                    //   }
                    // },
                    controller: searchController,
                    decoration: const InputDecoration(
                      label:Text('Search'),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onTap: (){},
                    onChanged: (value){},
                    onSubmitted: (text) {
                      if (formKey.currentState!.validate()) {
                        AppCubit().get(context).getSearch(text: text);
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (state is SearchLoadingStates) LinearProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  if (state is SearchSuccessStates)
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index)=>buildView(cubit.searchModel.data!.data[index],context,inSearch: false),
                        itemCount: cubit.searchModel.data!.data.length,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildView(Product model, context,{bool inSearch=true}) => Stack(
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
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      model.image!,
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
                      model.name!,
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
                  Text(
                    '\$${model.price!.round()}',
                    style: TextStyle(color: Colors.grey,fontSize: 18),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 133,
                          height: 40,
                          padding: EdgeInsets.all(8),
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppCubit().get(context).cart[model.id!]!? Colors.orange:Colors.blueGrey,
                          ),
                          child: MaterialButton(
                            onPressed: (){
                              AppCubit().get(context).addCart(produc_id: model.id!);
                              // print(productsModel.id);
                            },
                            child: AppCubit().get(context).cart[model.id!]!? const Text('Remove From Cart',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ): const Text('Add To Cart',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        //Spacer(),
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                            child: IconButton(
                              onPressed: (){
                                AppCubit().get(context).addFavorite(product_id: model.id!);
                              },
                              icon: Icon(
                                AppCubit().get(context).favorite[model.id!]! ? Icons.favorite:Icons.favorite_border,
                                color:AppCubit().get(context).favorite[model.id!]! ? Colors.blueAccent[300]: Colors.white,
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
    ],
  );
}
