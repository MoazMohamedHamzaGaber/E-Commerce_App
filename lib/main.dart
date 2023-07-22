import 'package:chat_app/chat_app/layout_screen.dart';
import 'package:chat_app/chat_app/login_screen.dart';
import 'package:chat_app/shared/bloc_observer.dart';
import 'package:chat_app/shared/constant.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/shared/dio/cache_helper.dart';
import 'package:chat_app/shared/dio/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
   token=CacheHelper.getData(key: 'token');
  print(token);
  Widget widget;
  if(token != null)
    {
       widget=const LayoutScreen();
    }
  else
    {
      widget=ChatLoginScreen();
    }

  runApp( MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
   MyApp({required this.startWidget});

  final Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>AppCubit()..getDataHome()..getCategory()..getCart()..getFavorite()..getProfile()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home:startWidget,
          );
        },
      ),
    );
  }
}
