import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:yummy/shared/components/components.dart';

import '../../models/PreviousOrderDetailsModel/PreviousOrderDetailsModel.dart';
import '../../models/PreviousOrderModel/PreviousOrderModel.dart';
import '../../shared/components/imports.dart';

class Order extends StatelessWidget {
   Order({Key? key, required this.orderModel}) : super(key: key);

   OrderData orderModel;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},

      builder: (context,state)
      {
        var cubit= AppCubit.get(context);
        var productsModel=cubit.previousOrderDetailsModel;
        return WillPopScope(
          child: Scaffold(
            appBar: AppBar(),

            body: ConditionalBuilder(
              condition: cubit.previousOrderDetailsModel!=null,
              fallback: (context)=>Center(child: defaultProgressIndicator(context)),
              builder: (context)=>SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Center(
                        child: Text(
                          cubit.restaurantsMap[orderModel.resId!] !=null ? cubit.restaurantsMap[orderModel.resId!]! : 'No Data',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,  //was bold
                            letterSpacing: 1,
                            color: Colors.redAccent.withOpacity(0.8),
                            fontFamily: 'MagistralHonesty',
                            shadows: [
                              Shadow(color: Colors.black.withOpacity(0.5), blurRadius: 0.2),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 10,),

                      Center(
                        child: Text(
                          orderModel.purchaseDate!,
                          style: defaultDescriptionTextStyle,
                        ),
                      ),

                      const SizedBox(height: 20,),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
                        child: myDivider(color: cubit.isDarkTheme? defaultDarkColor : defaultColor),
                      ),

                      const SizedBox(height: 20,),

                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index)=>itemBuilder(context: context, cubit: cubit, model: productsModel.data[index]!),
                        separatorBuilder: (context,index)
                        {
                          return Column(
                            children:
                            [
                              const SizedBox(height: 10,),

                              myDivider(
                                  color: cubit.isDarkTheme? goldenColor : defaultDarkColor
                              ),
                            ],
                          );
                        },
                        itemCount: productsModel!.data.length,
                      ),

                      const SizedBox(height: 25,),

                      Text(
                        'TOTAL PRICE: ${orderModel.totalCost} SYP',
                        style: defaultPriceTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          onWillPop: ()async
          {
            cubit.previousOrderDetailsModel=null;
            return true;
          },
        );
      },
    );
  }

  Widget itemBuilder({
  required BuildContext context,
  required AppCubit cubit,
  required PreviousOrderData model,
})
  {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        // color: Colors.blueGrey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          children:
          [
             Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  model.name!,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),

            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${model.price!} SYP',
                  maxLines: 1,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,  //was bold
                        letterSpacing: 1,
                        color: steelTealColor
                    ),
                ),
              ),
            ),

             Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Quantity: ${model.quantity!}',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
