import 'package:chat_app/model/cart_Model.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit().get(context);
        if (cubit.cartModel!.data!.cart_items.isNotEmpty) {
          return Scaffold(
            backgroundColor: const Color(0xff2B475E),
            appBar: AppBar(
              backgroundColor: const Color(0xff2B475E),
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              title: const Text(
                'My Cart',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            body: ConditionalBuilder(
              condition: cubit.cartModel != null,
              builder: (context) => Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildCart(
                          cubit.cartModel!.data!.cart_items[index], context),
                      itemCount: cubit.cartModel!.data!.cart_items.length,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "SubTotal",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${cubit.cartModel!.data!.total.round() * cubit.cartModel!.data!.cart_items[0].quantity!} EGP',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          child: MaterialButton(
                            onPressed: () {},
                            child: const Text(
                              'Check Out',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              fallback: (context) => const Center(child: CircularProgressIndicator()),
            ),
          );
        }
        return Scaffold(
          backgroundColor: const Color(0xff2B475E),
          appBar: AppBar(
            backgroundColor: const Color(0xff2B475E),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            title: const Text(
              'My Cart',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image(
                          image: NetworkImage(
                              'https://thumbs.dreamstime.com/b/beautiful-happy-woman-showing-love-sign-near-eyes-healthy-vision-portrait-holding-heart-shaped-hands-closeup-smiling-83939671.jpg'))),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Your Cart Is Empty',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Sorry, the keyword you entered cannot be found,  please check again or search with another keyword.',
                    style: TextStyle(
                      fontSize: 16,
                      //fontWeight: FontWeight.bold,
                      color: Colors.grey,
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

  Widget buildCart(CartItemModel model, context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
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
                        model.product!.image,
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
                        model.product!.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${model.product!.price.round()} EGP',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 243, 243, 243),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (model.quantity <= 1) {
                                        model.quantity = 1;
                                      } else {
                                        model.quantity--;
                                      }
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.blue,
                                      size: 15,
                                    ),
                                  ),
                                ),
                                Text('${model.quantity}'),
                                //Text('${AppCubit().get(context).counter}'),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      model.quantity++;
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.blue,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              child: IconButton(
                                onPressed: () {
                                  AppCubit().get(context).addFavorite(
                                      product_id: model.product!.id!);
                                },
                                icon: Icon(
                                  AppCubit()
                                          .get(context)
                                          .favorite[model.product!.id!]!
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: AppCubit()
                                          .get(context)
                                          .favorite[model.product!.id!]!
                                      ? Colors.blueAccent[300]
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            child: IconButton(
                              onPressed: () {
                                AppCubit()
                                    .get(context)
                                    .addCart(produc_id: model.product!.id!);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: AppCubit()
                                        .get(context)
                                        .cart[model.product!.id!]!
                                    ? Colors.blueAccent[300]
                                    : Colors.blueAccent[300],
                                size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
