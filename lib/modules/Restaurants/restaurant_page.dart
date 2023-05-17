import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:yummy/layout/cubit/cubit.dart';
import 'package:yummy/layout/cubit/states.dart';
import 'package:yummy/models/RestaurantsModel/Restaurant_Model.dart';
import 'package:yummy/shared/components/components.dart';
import 'package:yummy/shared/styles/styles.dart';
import 'package:latlong2/latlong.dart';
import '../../models/MealModel/meal_model.dart';
import '../../shared/styles/colors.dart';
import '../Cart/cart.dart';

class RestaurantPage extends StatefulWidget {
   const RestaurantPage({Key? key, required this.restaurant,}) : super(key: key);

   final Restaurant? restaurant;

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {

  PageController pageController = PageController();

  ScrollController scrollController= ScrollController();

  final ItemScrollController itemScrollController = ItemScrollController();

  //late double deliveryCost=0; //Delivery Cost


  void scrollToIndex(int index)
  {
    itemScrollController.scrollTo(
        index: index,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCubic);
  }

  @override
  void initState()
  {
    super.initState();

    double distance= calculateDistance( LatLng(widget.restaurant!.latitude!, widget.restaurant!.longitude!), LatLng(AppCubit.userModel!.result!.latitude!, AppCubit.userModel!.result!.longitude!) );

    //deliveryCost= deliveryCostCalculator(distance).roundToDouble();

    AppCubit.setDeliveryCost(distance);

    if(widget.restaurant?.menu !=null)
      {
        print("MENU ITEMS ARE: ${widget.restaurant?.menu}");
      }
  }

  @override
  void dispose()
  {
    pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},

        builder: (context,state)
        {
          Restaurant? restaurant= widget.restaurant;
          var cubit= AppCubit.get(context);
          return WillPopScope(
            child: Scaffold(
              appBar: AppBar(
                actions:
                [
                  Visibility(
                    visible: cubit.cartMeals.isNotEmpty,
                    child: IconButton(
                        onPressed: ()
                        {
                          navigateTo(context, const Cart() );
                        },
                        icon: const Icon(Icons.shopping_cart_rounded)
                    ),
                  ),
                ],
              ),

              body: ConditionalBuilder(
                condition: cubit.restaurantMeals !=null && restaurant!=null,
                fallback: (context)=>Center(child: defaultProgressIndicator(context)),
                builder: (context)=>Column(
                  children:
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                      child: Container(
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          image:DecorationImage(
                            // image: AssetImage('assets/images/american_diner.jpg'),
                            image: NetworkImage(restaurant!.photo!),
                            fit: BoxFit.fitWidth,
                            opacity: 0.35,

                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Center(
                                  child: Text(
                                    restaurant!.name!.capitalize!,
                                    style: defaultRestaurantNameTextStyle,
                                  )
                              ),

                              const SizedBox(height: 8,),

                              Align(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  'Delivery Cost: ${AppCubit.deliveryCost} SYP',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: ScrollablePositionedList.separated(
                            scrollDirection: Axis.horizontal,
                            itemScrollController: itemScrollController,
                            shrinkWrap: true,
                            itemBuilder: (context,index)
                            {
                              return GestureDetector(
                                onTap: ()
                                {
                                  cubit.changeCurrentItemList(index);
                                  pageController.jumpToPage(index);
                                  scrollToIndex(index);
                                },
                                child: Text(
                                  "${restaurant!.menu[index]!.name} ",
                                  style:TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20,
                                      color: cubit.isCurrentItemList(index)? defaultColor : null
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context,index)=>  SizedBox(width: 10, child: Text('|', style:  TextStyle(fontSize: 20, color: steelTealColor, fontWeight: FontWeight.w500),),),
                            itemCount: restaurant!.menu.length
                        ),
                      ),
                    ),

                    Expanded(
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: pageController,
                        itemCount: restaurant!.menu.length,
                        itemBuilder: (context,index)=> restaurantMealsItemBuilder(context,cubit, cubit.mealsForMenuId(restaurant!.menu[index]!.id! ) ),   //cubit.restaurantMeals!.data!),
                        onPageChanged: (int index)
                        {
                          scrollToIndex(index);
                          cubit.changeCurrentItemList(index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            onWillPop: ()async
            {
              cubit.restaurantMeals=null;
              restaurant=null;
              cubit.cartMeals.clear();
              cubit.changeCurrentItemList(0);
              return true;
            },
          );
        },
    );
  }

  Widget restaurantMealsItemBuilder(BuildContext context, AppCubit cubit, List<Meal> meals)
  {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context,index)=> mealItemBuilder(context,cubit, meals[index], isFromRest: true),
                separatorBuilder: (context,index)=> myDivider(),
                itemCount: meals.length
            )
          ],
        ),
      ),
    );
  }
}
