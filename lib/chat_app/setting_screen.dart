import 'package:chat_app/chat_app/login_screen.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/shared/dio/cache_helper.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is UpdateProfileSuccessStates)
          {
            Fluttertoast.showToast(
              msg: 'User Information Updated Successfully',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        if(state is UpdateProfileErrorStates)
        {
          Fluttertoast.showToast(
            msg: 'User Information don\'t Updated',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (context, state) {
        var cubit = AppCubit().get(context).profileModel;

        if(cubit !=null)
          {
            nameController.text = cubit.data!.name!;
            emailController.text = cubit.data!.email!;
            phoneController.text = cubit.data!.phone!;
          }

        return Scaffold(
          backgroundColor: Color(0xff2B475E),
          body: Form(
            key: formKey,
            child: ConditionalBuilder(
              condition:  AppCubit().get(context).profileModel !=null,
              builder: (context)
              {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      if (state is UpdateProfileLoadingStates)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Name';
                          }
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          label: Text('Name'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Email';
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          label: Text('Email'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          prefixIcon: Icon(Icons.mail),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: phoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Phone';
                          }
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          label: Text('Phone'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          prefixIcon: Icon(Icons.phone),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blueGrey,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            if(formKey.currentState!.validate())
                              {
                                AppCubit().get(context).updateUserData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                );
                              }
                          },
                          child: Text(
                            'Update Profile',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blueGrey,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            CacheHelper.removeData(key: 'token').then((value) {
                              if (value) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatLoginScreen()),
                                        (route) => false);
                              }
                            });
                          },
                          child: Text(
                            'Sign Out',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              fallback: (context)=>Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}
