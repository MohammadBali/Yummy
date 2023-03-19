import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummy/layout/cubit/states.dart';
import 'package:yummy/modules/Profile/profile_page.dart';

import '../../modules/Home/home_page.dart';
import '../../modules/Restaurants/restaurants_page.dart';
import '../../shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit(): super(AppInitialState());

  static AppCubit get(context) =>BlocProvider.of(context);

  List<Widget> bottomBarWidgets=
  [
    const HomePage(),
    const RestaurantsPage(),
    const ProfilePage(),
  ];

  int currentBottomBarIndex=0;

  void changeBottomNavBar(int index)
  {
    currentBottomBarIndex=index;

    emit(AppChangeBottomNavBar());
  }

  bool isDarkTheme=false; //Check if the theme is Dark.

  void changeTheme({bool? themeFromState})
  {
    if(themeFromState !=null)  //if a value is sent from main, then use it.. we didn't use CacheHelper because the value has already came from cache, then there is no need to..
    {
      isDarkTheme=themeFromState;
      emit(AppChangeThemeModeState());
    }
    else                      // else which means that the button of changing the theme has been pressed.
    {
      isDarkTheme= !isDarkTheme;
      CacheHelper.putBoolean(key: 'isDarkTheme', value: isDarkTheme).then((value)  //Put the data in the sharedPref and then emit the change.
      {
        emit(AppChangeThemeModeState());
      });
    }

  }


  List<String> itemsList=[
    'Main Meals',
    'Chicken Meals',
    'Steaks',
    'Desserts',
    'Appetizers',
    'Beverages',
  ];

  int currentItemListIndex=0;

  void changeCurrentItemList(int index)
  {
    currentItemListIndex=index;
    emit(AppChangeItemListState());
  }

  bool isCurrentItemList(int index)
  {
    if (currentItemListIndex==index)
    {
      // emit(AppCheckItemListState());
      return true;

    }
    // emit(AppCheckItemListState());
    return false;
  }





}