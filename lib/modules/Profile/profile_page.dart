import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                        'assets/images/fries.jpg'),
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

                settingsItemBuilder(itemName: 'Settings', icon: Icons.settings_rounded, mainColor: Colors.grey.withOpacity(0.5)),

                const SizedBox(height: 35,),

                settingsItemBuilder(itemName: 'Old Orders', icon: Icons.shopping_basket_rounded, mainColor: Colors.indigoAccent.withOpacity(0.5)),

                const SizedBox(height: 35,),

                settingsItemBuilder(itemName: 'Favourite Items', icon: Icons.favorite_rounded, mainColor: Colors.redAccent.withOpacity(0.5)),
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
  Color mainColor=Colors.grey,})
  {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      highlightColor: Colors.grey.withOpacity(0.5),
      onTap: ()
      {
      },
      child: Container(
        width: double.infinity,
        height: 75,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(10),
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
