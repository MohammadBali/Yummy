import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:yummy/modules/Previous%20Orders/previous_orders.dart';
import 'package:yummy/modules/Settings/Settings.dart';
import 'package:yummy/shared/components/components.dart';
import 'package:yummy/shared/styles/styles.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,

              children:
              [
                const SizedBox(height: 25,),

                const Align(
                  alignment: AlignmentDirectional.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 55,
                    backgroundImage: AssetImage(
                        'assets/images/pizza.jpg'),
                  ),
                ),

                const SizedBox(height: 25,),

                Text(
                  'Mohammad Bali',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: defaultHeadlineTextStyle,
                ),

                const SizedBox(height: 50,),

                settingsItemBuilder(itemName: 'Settings', icon: Icons.settings_rounded, mainColor: Colors.grey.withOpacity(0.5), lista: [HexColor('ADA996'), HexColor('F2F2F2'), HexColor('DBDBDB') ,HexColor('EAEAEA') ] ,func: (){navigateTo(context, const Settings());}),

                const SizedBox(height: 35,),

                settingsItemBuilder(itemName: 'Previous Orders', icon: Icons.shopping_basket_rounded, lista:[HexColor('3A1C71'), HexColor('D76D77'), HexColor('FFAF7B')],mainColor: Colors.indigoAccent.withOpacity(0.5),func: (){navigateTo(context, const PreviousOrders());}),

                const SizedBox(height: 35,),

                settingsItemBuilder(itemName: 'Favourite Items', icon: Icons.favorite_rounded, lista:[HexColor('EF3B36'), HexColor('FFFFFF')], mainColor: Colors.redAccent.withOpacity(0.5),func: (){}),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget settingsItemBuilder({
  required String itemName,
  required IconData icon,
  required void Function()? func,
  Color mainColor=Colors.grey,
  required List<Color> lista,
  })
  {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      highlightColor: Colors.grey.withOpacity(0.5),
      onTap: func,
      child: Container(
        width: double.infinity,
        height: 75,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(10),

          gradient: LinearGradient(
            colors: lista,
            end: Alignment.topRight,
            begin: Alignment.bottomLeft
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal:  15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children:
            [
              Text(
                itemName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400
                ),
              ),

              const Spacer(),

              Icon(
                icon,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
