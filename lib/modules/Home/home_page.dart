import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:yummy/layout/cubit/cubit.dart';
import 'package:yummy/layout/cubit/states.dart';
import 'package:yummy/modules/Meal_Details/meal_details.dart';
import 'package:yummy/shared/components/components.dart';
import '../../models/MealModel/meal_model.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit= AppCubit.get(context);

        return ConditionalBuilder(
            condition: AppCubit.userModel !=null && cubit.trendyMeals !=null &&cubit.offersModel!=null,
            fallback: (context)=>Center(child: defaultProgressIndicator(context)),
            builder: (context)
            {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children:
                    [
                      Text(
                        'New Offers',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: defaultHeadlineTextStyle,
                      ),

                      const SizedBox(height: 10,),

                      myDivider(),

                      const SizedBox(height: 20,),

                      SizedBox(
                        height: 150,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context,index)=>offerItemBuilder(
                                function: () async
                                {
                                  // offersPopupDialog(context, cubit.offersModel!.data![index]);
                                  await showDialog(
                                      context: context,
                                      builder:(context)
                                      {
                                        return defaultAlertDialog(
                                          context: context,
                                          title: cubit.offersModel!.data![index].name!.capitalize!,
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: [

                                                Text(
                                                  cubit.offersModel!.data![index].ingredients!,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:  AppCubit.get(context).isDarkTheme? Colors.white: Colors.black,
                                                  ),
                                                ),

                                                const SizedBox(height: 15,),

                                                Image(
                                                  image: NetworkImage(cubit.offersModel!.data![index].photo!),
                                                  fit: BoxFit.cover,
                                                  height: 250,
                                                  width: 250,
                                                  errorBuilder: (context,error,stacktrace)
                                                  {
                                                    print("Couldn't Get Offer Image, ${error.toString()}");

                                                    return const Image(
                                                      image: AssetImage('assets/images/lasagna.jpg'),
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                ),

                                                const SizedBox(height: 10,),

                                                Row(
                                                  children:
                                                  [
                                                    Text(
                                                      '${cubit.offersModel!.data![index].price} SYP',
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.bold,  //was bold
                                                        letterSpacing: 1,
                                                        color: AppCubit.get(context).isDarkTheme? goldenColor : defaultColor,
                                                      ),
                                                    ),

                                                    const Spacer(),

                                                    TextButton(

                                                      child:const Text(
                                                        'Check Meal',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                        ),
                                                      ),

                                                      onPressed: ()
                                                      {
                                                        navigateTo(context, MealDetails(meal: cubit.offersModel!.data![index], isFromRestaurant: false,));
                                                      },
                                                    ),
                                                  ],
                                                ),

                                                Visibility(
                                                  visible: cubit.offersModel!.data![index].discount!=null,
                                                  child: const SizedBox(height: 5,)
                                                ),

                                                ConditionalBuilder(
                                                    condition: cubit.offersModel!.data![index].discount !=null,
                                                    fallback: (context)=>const Text(''),
                                                    builder: (context)=>Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children:
                                                      [
                                                        Icon(Icons.discount, size: 20, color: defaultDarkColor,),

                                                        const SizedBox(width: 10,),

                                                        Text(
                                                          'Discount is available!',
                                                          style: TextStyle(
                                                              color: defaultDarkColor,
                                                              fontSize: 16
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  );
                                },
                                imageLink:  cubit.offersModel!.data![index].photo!,
                                ),
                            separatorBuilder: (context,index)=> const SizedBox(width: 15,),
                            itemCount: cubit.offersModel!.data!.length
                        ),
                      ),

                      const SizedBox(height: 50,),

                      GradientText(
                        'Trendy Meals',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: defaultHeadlineTextStyle,
                        colors:
                        [
                          HexColor('590D22'),

                          HexColor('800F2F'),

                          HexColor('C9184A'),

                          HexColor('FF4D6D'),

                          HexColor('FF8FA3'),

                        ],
                      ),

                      const SizedBox(height: 10,),

                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index)=>mealItemBuilder(context,cubit, cubit.trendyMeals!.data![index]),
                        separatorBuilder: (context,index)=> myDivider(),
                        itemCount: cubit.trendyMeals!.data!.length,
                      ),

                    ],
                  ),
                ),
              );
            },
        );
      },
    );
  }


  Widget offerItemBuilder({
    required void Function()? function,
    required String imageLink,
  }) =>
      InkWell(
        borderRadius: BorderRadius.circular(20),
        highlightColor: Colors.grey.withOpacity(0.5),
        onTap: function,
        child: Container(
          width: 110,
          height: 150,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                // image: AssetImage('assets/images/lasagna.jpg'),
                image: CachedNetworkImageProvider(imageLink),
                fit: BoxFit.fill,
                opacity: 0.6,
            ),

          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children:const
            [
              Expanded(
                child: Center(
                    child: Text(
                      'Offer Info',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 9,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      );
}
