import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:yummy/shared/components/components.dart';

import '../../models/MealModel/meal_model.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/imports.dart';
import '../Banking/BankingHome/bankingHome.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ConditionalBuilder(
              condition: cubit.cartMeals.isNotEmpty,
              fallback: (context) => const Center(
                  child: Text(
                'Wow,Such Empty :(',
                style: TextStyle(fontSize: 20),
              )),
              builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Your Cart',
                      style: defaultHeadlineTextStyle,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: ListView.separated(
                        // shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            itemBuilder(cubit.cartMeals[index], cubit, index),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 25,
                        ),
                        itemCount: cubit.cartMeals.length,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: defaultButton(
                            onTap: () async {
                              if (cubit.cartMeals.isNotEmpty) {
                                // cubit.submitOrder();

                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return defaultAlertDialog(
                                          context: context,
                                          title: 'Choose Payment Method',
                                          content: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children:
                                            [
                                              Expanded(
                                                child: GestureDetector(
                                                  child: Container(
                                                    margin: const EdgeInsets.all(15.0),
                                                    padding: const EdgeInsets.all(10.0),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: goldenColor),
                                                        borderRadius: BorderRadius.circular(6),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children:
                                                      [
                                                        Text(
                                                          'Cash',
                                                          style: TextStyle(
                                                              fontSize: 22,
                                                              color: cubit.isDarkTheme? defaultColor :defaultDarkColor,
                                                          ),
                                                        ),

                                                        const SizedBox(height: 5,),

                                                        Icon(
                                                          Icons.money_rounded,
                                                          size: 40,
                                                          color: cubit.isDarkTheme? defaultDarkColor : defaultColor,
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  onTap: ()
                                                  {
                                                    cubit.submitCashOrder();
                                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                                  },
                                                ),
                                              ),

                                              const SizedBox(width: 5,),

                                              Expanded(
                                                child: GestureDetector(
                                                  onTap:()
                                                  {
                                                    if(bankingToken !='')
                                                      {
                                                        print('Banking Token is :$bankingToken');
                                                        if(JwtDecoder.isExpired(bankingToken) ==false) //Checking if BankingToken is not expired
                                                          {
                                                            defaultToast(msg:'Checking for Banking Credentials');
                                                            cubit.submitCreditCardOrder(
                                                                token: bankingToken,
                                                                restaurantBankId: cubit.getRestaurantBankIdFromId(cubit.cartMeals[0].restaurantId!),
                                                                userBankId: cubit.userBankingModel!.id!);

                                                            Navigator.of(context).popUntil((route) => route.isFirst);
                                                          }
                                                        else
                                                          {
                                                            navigateTo(context, BankingHome(isOrder: true,) );
                                                          }
                                                      }

                                                    else
                                                      {
                                                        defaultToast(msg: 'Enter Banking Credentials');
                                                        navigateTo(context, BankingHome(isOrder: true,) );
                                                      }
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets.all(15.0),
                                                    padding: const EdgeInsets.all(10.0),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: goldenColor),
                                                      borderRadius: BorderRadius.circular(6),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children:
                                                      [
                                                        Text(
                                                          'Credit',
                                                          style: TextStyle(
                                                              fontSize: 22,
                                                              color: cubit.isDarkTheme? defaultColor :defaultDarkColor,
                                                          ),
                                                        ),

                                                        const SizedBox(height: 5,),

                                                        Icon(
                                                          Icons.credit_card_rounded,
                                                          size: 40,
                                                          color: cubit.isDarkTheme? defaultDarkColor : defaultColor,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                      );
                                    });
                              }
                            },
                            title: 'Submit Order')),
                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      'Delivery Cost is : ${AppCubit.deliveryCost} SYP',
                      style: defaultDescriptionTextStyle,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      'TOTAL PRICE: ${cubit.cartCost} SYP',
                      style: defaultPriceTextStyle,
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget itemBuilder(Meal meal, AppCubit cubit, int index) {
    return Container(
      width: double.infinity,
      height: 100,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(
            meal.photo!,
          ),
          fit: BoxFit.fitWidth,
          opacity: 0.19,
          onError: (error, stacktrace) {
            print('Error in getting image, ${error.toString()}');
          },
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Expanded(
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    meal.name!,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  meal.discount == null
                      ? 'Price: ${meal.price! * meal.quantity}'
                      : 'Price: ${meal.quantity * (meal.price - (meal.discount * meal.price) / 100)}',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700, //was bold
                      letterSpacing: 1,
                      color: steelTealColor),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  const Text(
                    'Quantity:',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('${meal.quantity}'),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        cubit.changeQuantityInCart(
                            index: index, increase: true);
                      },
                      child: Icon(
                        Icons.add,
                        size: 25,
                        color:
                            cubit.isDarkTheme ? defaultDarkColor : defaultColor,
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                      onTap: () {
                        cubit.changeQuantityInCart(
                            index: index, increase: false);
                      },
                      child: Icon(
                        Icons.remove,
                        size: 25,
                        color:
                            cubit.isDarkTheme ? defaultDarkColor : defaultColor,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
