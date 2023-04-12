import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:yummy/shared/components/components.dart';

import '../../shared/components/imports.dart';
import '../Orders/orders.dart';

class PreviousOrders extends StatelessWidget {
  const PreviousOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit= AppCubit.get(context);
        var model=cubit.previousOrderModel;
        return Scaffold(
          appBar: AppBar(),

          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: ConditionalBuilder(
                condition: cubit.previousOrderModel!=null,
                fallback: (context)=>Center(child: defaultProgressIndicator(context)),
                builder: (context)=>Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Text(
                      'Previous Orders',
                      style: defaultHeadlineTextStyle,
                    ),

                    const SizedBox(height: 50,),

                    GridView.count(
                      crossAxisCount: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      childAspectRatio: 1/1,
                      crossAxisSpacing: 22,
                      mainAxisSpacing: 22,
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),

                      children:List.generate(model!.data.length, (index)
                      {
                        return orderItemBuilder(
                          title: cubit.restaurantsMap[model.data[index]!.resId!] !=null ? cubit.restaurantsMap[model.data[index]!.resId!]! : 'No Data',
                          date: model.data[index]!.purchaseDate!,
                          cubit: cubit,
                          context: context,
                          onTap: ()
                          {
                            cubit.getOrderDetails(model.data[index]!.id!);
                            navigateTo(context, Order(orderModel: model.data[index]!,));
                          },
                        );
                      }),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget orderItemBuilder(
  {
    required String title,
    required String date,
    required AppCubit cubit,
    required BuildContext context,
    required void Function()? onTap,
  })
  {
    return GestureDetector(
      onTap: onTap, //onTap,
      child: Container(
        height: 140,
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          shape: BoxShape.rectangle,
          border: Border.all(
              width: 1,
              color: cubit.isDarkTheme? Colors.white.withOpacity(0.8) : Colors.black
          ),
          image: const DecorationImage(
            image: AssetImage('assets/images/foodSketches2.png'),
            opacity: 0.2,
            fit: BoxFit.fill,

          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: cubit.isDarkTheme? defaultDarkColor: defaultColor,
                  overflow: TextOverflow.fade,

                ),
                maxLines: 1,
              ),
            ),

            const SizedBox(height: 10,),

            Text(
              date,
            ),
          ],
        ),
      ),
    );
  }
}
