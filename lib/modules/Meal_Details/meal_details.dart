import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:yummy/layout/cubit/cubit.dart';
import 'package:yummy/layout/cubit/states.dart';
import 'package:yummy/models/MealModel/meal_model.dart';
import 'package:yummy/modules/Restaurants/restaurant_page.dart';
import 'package:yummy/shared/components/components.dart';
import 'package:yummy/shared/styles/styles.dart';

import '../../shared/styles/colors.dart';

class MealDetails extends StatelessWidget {

  const MealDetails({Key? key, required this.meal}) : super(key: key);

  final Meal meal;
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
            [],
          ),

          body: Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('assets/images/sketch.jpg',),
            //     repeat: ImageRepeat.repeatY,
            //     opacity: 0.1,
            //     fit: BoxFit.contain
            //   )
            // ),
            child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children:
                    [
                      mealItemBuilder(context, cubit, meal),
                    ],
                  ),
                )
            ),
          ),

        );
      },
    );
  }


  Widget mealItemBuilder(BuildContext context,AppCubit cubit, Meal meal)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children:
      [
        Text(
          meal.name!.capitalize!,
          style: defaultMealNameTextStyle,
        ),

        const SizedBox(height: 10,),

        GestureDetector(

          onTap: ()
          {
            cubit.getRestaurantMeals(meal.restaurantId!);
            cubit.getRestaurant(meal.restaurantId!);
            navigateTo(context,  RestaurantPage(restaurant: cubit.restaurantModel?.data?[0],));
          },

          child: Row(
            children: [
              const Spacer(),

              const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/american_diner.jpg')
              ),

              const SizedBox(width: 15,),

              Text(
                meal.restaurantName!.capitalize!,
                style: defaultRestaurantNameInMealTextStyle,
              ),
            ],
          ),
        ),

        const SizedBox(height: 20,),

        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image(
                  // image: const AssetImage('assets/images/lasagna.jpg'),
                  image: NetworkImage(meal.photo!),
                  fit: BoxFit.cover,
                  isAntiAlias: true,
                  errorBuilder: (context,object,trace)
                  {
                    print('Error While Getting Image, ${object.toString()}');
                    return const Image(
                      image: AssetImage('assets/images/lasagna.jpg'),
                      fit: BoxFit.cover,
                      isAntiAlias: true,
                    );
                  },
                ),
              ),
            ),

            IconButton(
                onPressed: (){},
                icon: const Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.red,
                ),
                splashRadius: 30,
            ),
          ],
        ),

        const SizedBox(height: 20,),

        Text(
          meal.ingredients!,
          style: defaultDescriptionTextStyle,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 30,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            Text(
              '${meal.price!} SYP',
              style: TextStyle(
                fontSize: meal.discount !=null ? 18 : 22,
                fontWeight: meal.discount !=null ? FontWeight.w300 :FontWeight.bold,  //was bold
                letterSpacing: 1,
                color: Colors.blue,
                decoration: meal.discount !=null ?TextDecoration.lineThrough : TextDecoration.none,
                decorationStyle: TextDecorationStyle.wavy,
                decorationColor: Colors.redAccent
              ),
            ),

            const SizedBox(width: 10,),

            ConditionalBuilder(
                condition: meal.discount !=null,
                builder: (context)=> Text(
                  '${meal.price - (meal.discount * meal.price)/100} SYP',
                  style: defaultPriceTextStyle,
                ),
                fallback: (context)=>const Text(''),
            ),
          ],
        ),

        const SizedBox(height: 30,),

        InkWell(
          highlightColor: Colors.deepOrange.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
          onTap: ()
          {
            //Navigate to Restaurant
          },
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Add To Cart',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: defaultDarkColor
                  ),
                ),
              ),

              const Spacer(),

              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Icon(
                  Icons.shopping_basket_rounded,
                  color: defaultDarkColor,
                ),
              ),
            ],
          ),
        ),
      ],

    );
  }
}
