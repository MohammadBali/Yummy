import 'package:yummy/shared/components/components.dart';

import '../../shared/components/imports.dart';

class Order extends StatelessWidget {
  const Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},

      builder: (context,state)
      {
        var cubit= AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Center(
                    child: Text(
                      'Roadhouse',
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
                      '23/5/2021',
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
                      itemBuilder: (context,index)=>itemBuilder(context: context, cubit: cubit),
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
                      itemCount: 4,
                  ),

                  const SizedBox(height: 25,),

                  Text(
                    'TOTAL PRICE: 35,000 SYP',
                    style: defaultPriceTextStyle,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget itemBuilder({
  required BuildContext context,
  required AppCubit cubit,
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
            const Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Hamburger',
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
                  '2000 SYP',
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

            const Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Quantity: 3',
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
