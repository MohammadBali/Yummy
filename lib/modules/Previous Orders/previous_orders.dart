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
        return Scaffold(
          appBar: AppBar(),

          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
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

                    children:
                    [
                      orderItemBuilder(title: 'RoadHouse', date: '11/2/2023', cubit: cubit, onTap: (){}, context: context, ),

                      orderItemBuilder(title: 'Steak House', date: '5/2/2023', cubit: cubit, onTap: (){}, context: context),

                      orderItemBuilder(title: 'Burger King', date: '10/12/2022', cubit: cubit, onTap: (){}, context: context),

                      orderItemBuilder(title: 'Dominos Pizza', date: '27/9/2022', cubit: cubit, onTap: (){}, context: context),

                      orderItemBuilder(title: 'Chinese Rest', date: '10/12/2021', cubit: cubit, onTap: (){}, context: context),

                      orderItemBuilder(title: 'Al Samah', date: '1/11/2021', cubit: cubit, onTap: (){}, context: context),

                      orderItemBuilder(title: 'Steak House', date: '20/10/2021', cubit: cubit, onTap: (){}, context: context),

                      orderItemBuilder(title: 'Burger King', date: '10/10/2020', cubit: cubit, onTap: (){}, context: context),
                    ],
                  ),

                ],
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
      onTap: ()
      {
        navigateTo(context, const Order() );
      }, //onTap,
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
