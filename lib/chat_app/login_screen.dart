import 'package:chat_app/chat_app/layout_screen.dart';
import 'package:chat_app/chat_app/register_screen.dart';
import 'package:chat_app/shared/constant.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/shared/dio/cache_helper.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is LoginSuccessStates)
          {
            if(state.appModel.status!)
              {
                print(state.appModel.message);
                print(state.appModel.data!.token);
                Fluttertoast.showToast(
                    msg: state.appModel.message!,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                );
                CacheHelper.saveData(
                  key: 'token',
                  value: state.appModel.data!.token,
                ).then((value)
                {
                  token=state.appModel.data!.token!;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LayoutScreen()),
                          (route) => false);
                }
                );
              }
            else
              {
                print(state.appModel.message);
                Fluttertoast.showToast(
                    msg: state.appModel.message!,
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
          body: Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/scholar.png'),
                  const Text(
                    'Scholar Chat',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Email';
                            }
                            return null;
                          },
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            label: Text('Email'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.mail,color: Colors.white,),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Password';
                            }
                            return null;
                          },
                          obscureText: cubit.obscureText,
                          onFieldSubmitted: (value){
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                              print(emailController.text);
                              print(passwordController.text);
                            }
                          },
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration:  InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            label: Text('Password'),
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: (){
                                cubit.changeObscure();
                              },
                                icon:cubit.obscureText? Icon(Icons.visibility):Icon(Icons.visibility_off),
                            ),
                            prefixIcon: Icon(Icons.lock,color: Colors.white,),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingStates,
                          builder: (context) => Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  print(emailController.text);
                                  print(passwordController.text);
                                }
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff2B475E),
                                ),
                              ),
                            ),
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t Have an account? ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChatRegisterScreen()),
                                    (route) => false);
                              },
                              child: const Text(
                                'Sign Up ',
                                style: TextStyle(
                                  fontSize: 20,
                                  // color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
}
