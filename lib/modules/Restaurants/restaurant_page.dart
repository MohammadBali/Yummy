import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:yummy/layout/cubit/cubit.dart';
import 'package:yummy/layout/cubit/states.dart';
import 'package:yummy/shared/components/components.dart';
import 'package:yummy/shared/styles/styles.dart';

import '../../shared/styles/colors.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {

  PageController pageController = PageController();

  ScrollController scrollController= ScrollController();

  final ItemScrollController itemScrollController = ItemScrollController();


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
          var cubit= AppCubit.get(context);
          return WillPopScope(
            child: Scaffold(
              appBar: AppBar(
                actions:
                [
                  // IconButton(
                  //     onPressed: ()
                  //     {
                  //       cubit.changeTheme();
                  //     },
                  //     icon: const Icon(Icons.sunny)
                  // ),
                ],
              ),

              body: Column(
                children:
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                    child: Container(
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/american_diner.jpg'),
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
                                  'Roadhouse Diner',
                                  style: defaultRestaurantNameTextStyle,
                                )
                            ),

                            const SizedBox(height: 5,),

                            const Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: Text(
                                'Delivery Cost: 2000 SYP',
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
                              "${cubit.itemsList[index]} ",
                              style:TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                                color: cubit.isCurrentItemList(index)? defaultColor : null
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context,index)=>  SizedBox(width: 10, child: Text('|', style:  TextStyle(fontSize: 20, color: steelTealColor, fontWeight: FontWeight.w500),),),
                        itemCount: cubit.itemsList.length
                      ),
                    ),
                  ),

                  Expanded(
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: pageController,
                      itemCount: cubit.itemsList.length,
                      itemBuilder: (context,index)=> restaurantMealsItemBuilder(context,cubit,index+1),
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

            onWillPop: ()async
            {
              cubit.changeCurrentItemList(0);
              return true;
            },
          );
        },
    );
  }

  Widget restaurantMealsItemBuilder(BuildContext context, AppCubit cubit, int itemsNumber)
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
                itemBuilder: (context,index)=>mealItemBuilder(context,cubit),
                separatorBuilder: (context,index)=> myDivider(),
                itemCount: itemsNumber
            )
          ],
        ),
      ),
    );
  }
}
