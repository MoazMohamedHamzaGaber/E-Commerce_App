import 'package:chat_app/model/category_model.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit=AppCubit().get(context);
        return Scaffold(
          backgroundColor: Color(0xff2B475E),
          body: ConditionalBuilder(
            condition: cubit.categoryModel !=null,
            builder: (context)=>ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildCategory(cubit.categoryModel!.data!.data[index]),
              separatorBuilder: (context,index)=>SizedBox(height: 15,),
              itemCount:cubit.categoryModel!.data!.data.length ,
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildCategory(DataModel dataModel)=>Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(
              dataModel.image!,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          dataModel.name!,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
        )
      ],
    ),
  );
}
