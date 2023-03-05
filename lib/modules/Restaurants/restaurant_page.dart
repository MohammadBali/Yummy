import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yummy/layout/cubit/cubit.dart';
import 'package:yummy/layout/cubit/states.dart';
import 'package:yummy/shared/styles/styles.dart';

import '../../shared/styles/colors.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {

  PageController pageController = PageController();

  @override
  void initState()
  {
    super.initState();
  }

  @override
  void dispose()
  {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},

        builder: (context,state)
        {
          var cubit= AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions:
              [
                IconButton(
                    onPressed: ()
                    {
                      cubit.changeTheme();
                    },
                    icon: const Icon(Icons.sunny)
                ),
              ],
            ),

            body: Column(
              children:
              [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Center(
                      child: Text(
                        'Roadhouse Diner',
                        style: defaultRestaurantNameTextStyle,
                      )
                  ),
                ),

                const SizedBox(height: 5,),

                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect:  ExpandingDotsEffect
                    (
                    dotColor: Colors.grey,
                    activeDotColor: AppCubit.get(context).isDarkTheme ? defaultDarkColor : defaultColor,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 3,
                    spacing: 5,
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: pageController,
                    itemCount: 3,
                    itemBuilder: (context,index)=> itemBuilder(),
                  ),
                ),
              ],
            ),
          );
        },
    );
  }

  Widget itemBuilder()
  {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:const
        [
          SizedBox(height: 20,),

          Text(
            'Main Meals',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }
}
