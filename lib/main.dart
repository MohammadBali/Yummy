import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:yummy/layout/cubit/cubit.dart';
import 'package:yummy/layout/home_layout.dart';
import 'package:yummy/modules/Login/login.dart';
import 'package:yummy/shared/bloc_observer.dart';
import 'package:yummy/shared/components/constants.dart';
import 'package:yummy/shared/network/local/cache_helper.dart';
import 'package:yummy/shared/network/remote/main_dio_helper.dart';
import 'package:yummy/shared/styles/themes.dart';

import 'layout/cubit/states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Makes sure that all the await and initializer get done before runApp

  Bloc.observer = MyBlocObserver(); //Running Bloc Observer which prints change in states and errors etc...  in console

  MainDioHelper.init();

  await CacheHelper.init(); //Starting CacheHelper, await for it since there is async,await in .init().

  bool? isDark = CacheHelper.getData(key: 'isDarkTheme'); //Getting the last Cached ThemeMode
  isDark ??= false;

  if (CacheHelper.getData(key: 'token') != null)
  {
    token = CacheHelper.getData(key: 'token'); // Get User Token

    if(JwtDecoder.isExpired(token)==true) //Check if token is expired or not
    {
      print('Token is expired');
      token='';
    }
  }

  Widget widget; //to figure out which widget to send (login, onBoarding or HomePage) we use a widget and set the value in it depending on the token.

  if (token.isNotEmpty) //Token is there, so Logged in before
  {
    widget = const HomeLayout(); //Straight to Home Page.
  }
  else  //OnBoarding has been shown before but the token is empty => Login is required.
  {
    widget =  Login(); //Should be Login
  }

  runApp( MyApp(isDark: isDark, homeWidget: widget,));
}

class MyApp extends StatelessWidget {

  final bool isDark;        //If the app last theme was dark or light
  final Widget homeWidget;  // Passing the widget to be loaded.

  const MyApp({super.key, required this.isDark, required this.homeWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (BuildContext context)=> AppCubit()..changeTheme(themeFromState: isDark)..getUserData(token)..getTrendy()..getRestaurants() ),
      ],

      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme(context),
            darkTheme: darkTheme(context),
            themeMode: AppCubit.get(context).isDarkTheme   //If the boolean says last used is dark (from Cache Helper) => Then load dark theme
                ? ThemeMode.dark
                : ThemeMode.light,
            home: homeWidget,
          );
        },
      ),
    );
  }
}
