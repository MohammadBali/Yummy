import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummy/layout/cubit/cubit.dart';
import 'package:yummy/layout/cubit/states.dart';
import 'package:yummy/modules/Search/Search.dart';
import 'package:yummy/shared/components/components.dart';
import 'package:yummy/shared/components/imports.dart';

import '../modules/Map/mapPage.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},

      builder: (context,state)
      {
        var cubit= AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Yummy',
              style: TextStyle(
                letterSpacing: 1,
                fontFamily: 'MagistralHonesty',
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            actions:
            [
              IconButton(
                onPressed: ()
                {
                  navigateTo(context, const MapPage() );
                },
                icon: Icon(Icons.map_rounded, color: defaultColor,)
              ),

              IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, Search() );
                  },
                  icon: Icon(Icons.search_rounded, color: defaultColor,)
              ),
            ],
          ),

          body: cubit.bottomBarWidgets[cubit.currentBottomBarIndex],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentBottomBarIndex,

            onTap: (int index)
            {
              cubit.changeBottomNavBar(index);
            },

            items: const
            [
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded),label: 'Home'),

              BottomNavigationBarItem(icon: Icon(Icons.restaurant_rounded),label: 'Restaurants'),

              BottomNavigationBarItem(icon: Icon(Icons.person_rounded),label: 'Profile'),
            ],
          ),
        );
      },
    );
  }
}
