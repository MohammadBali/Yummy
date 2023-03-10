import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummy/layout/cubit/cubit.dart';
import 'package:yummy/layout/cubit/states.dart';

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
            title: const Text('Yummy'),
            actions:
            [
              IconButton(
                  onPressed: ()
                  {
                    cubit.changeTheme();
                  },
                  icon: const Icon(Icons.sunny),
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
