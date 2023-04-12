import 'package:yummy/modules/Settings/AccountSettings/accountSettings.dart';
import 'package:yummy/shared/components/components.dart';
import 'package:yummy/shared/components/imports.dart';



class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          var cubit=AppCubit.get(context);
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
                        'Settings',
                        style: defaultHeadlineTextStyle,
                      ),

                      const SizedBox(height: 50,),

                      Row(
                        children:
                        [
                          Icon(
                            cubit.isDarkTheme? Icons.sunny : Icons.brightness_3_rounded,
                            size: 22,
                          ),

                          const SizedBox(width: 10,),

                          const Text(
                            'Dark Mode',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                            ),
                          ),

                          const Spacer(),

                          Switch(
                            value: cubit.isDarkTheme,
                            onChanged: (bool newValue)
                            {
                              cubit.changeTheme();
                            },
                            activeColor: cubit.isDarkTheme? defaultDarkColor : defaultColor,
                            inactiveTrackColor: cubit.isDarkTheme? Colors.white: null,
                            activeTrackColor: cubit.isDarkTheme? defaultDarkColor.withOpacity(0.5) : defaultColor.withOpacity(0.5),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25,),

                      Row(
                        children:
                        [
                          const Icon(
                            Icons.person_rounded,
                            size: 22,
                          ),

                          const SizedBox(width: 1,),

                          TextButton(
                            child: const Text(
                              'Account Settings',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            onPressed: ()
                            {
                              navigateTo(context, const AccountSettings());
                            },
                          ),
                        ],
                      ),
                    ],
                  )
              ),
            ),
          );
        },
    );
  }
}
