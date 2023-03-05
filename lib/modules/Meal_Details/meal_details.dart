import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummy/layout/cubit/cubit.dart';
import 'package:yummy/layout/cubit/states.dart';
import 'package:yummy/shared/styles/styles.dart';

import '../../shared/styles/colors.dart';

class MealDetails extends StatelessWidget {
  const MealDetails({Key? key}) : super(key: key);

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
                icon: const Icon(Icons.sunny),
              ),
            ],
          ),

          body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children:
                  [
                    mealItemBuilder(),
                  ],
                ),
              )
          ),
        );
      },
    );
  }


  Widget mealItemBuilder()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children:
      [
        Text(
          'Lasagna Meal',
          style: defaultMealNameTextStyle,
        ),

        const SizedBox(height: 10,),

        Row(
          children: [
            const Spacer(),

            const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/american_diner.jpg')
            ),

            const SizedBox(width: 15,),

            Text(
              'Roadhouse Diner',
              style: defaultRestaurantNameInMealTextStyle,
            ),
          ],
        ),

        const SizedBox(height: 20,),

        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image(
                image: const AssetImage('assets/images/lasagna.jpg'),
                fit: BoxFit.cover,
                errorBuilder: (context,object,trace)
                {
                  print('Error While Getting Image, ${object.toString()}');
                  return const Image(image: AssetImage('assets/images/lasagna.jpg'),);
                },
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
          'This Meal is the famous lasagna meal that contains meat and tomato sauce and other great stuff',
          style: defaultDescriptionTextStyle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 20,),

        Text(
          '6,500 SYP',
          style: defaultPriceTextStyle,
        ),

        const SizedBox(height: 20,),

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
