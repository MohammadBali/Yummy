import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yummy/layout/cubit/cubit.dart';
import 'package:yummy/shared/styles/colors.dart';

import '../../modules/Meal_Details/meal_details.dart';
import '../../modules/Restaurants/restaurant_page.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyboard,
  required String label,
  required IconData prefix,
  required String? Function(String?)? validate,
  IconData? suffix,
  bool isObscure = false,
  bool isClickable = true,
  void Function(String)? onSubmit,
  void Function()? onPressedSuffixIcon,
  void Function()? onTap,
  void Function(String)? onChanged,
  void Function(String?)? onSaved,
  InputBorder? focusedBorderStyle,
  InputBorder? borderStyle,
  TextStyle? labelStyle,
  Color? prefixIconColor,
  Color? suffixIconColor,
  TextInputAction? inputAction,
  double borderRadius=0,
  bool readOnly=false,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboard,
      onFieldSubmitted: onSubmit,
      textInputAction: inputAction,
      validator: validate,
      enabled: isClickable,
      readOnly: readOnly,
      onTap: onTap,
      onSaved: onSaved,
      onChanged: onChanged,
      decoration: InputDecoration(
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: focusedBorderStyle,
        enabledBorder: borderStyle,
        labelStyle: labelStyle,
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        prefixIcon: Icon(prefix, color: prefixIconColor,),
        suffixIcon: IconButton(
          onPressed: onPressedSuffixIcon,
          icon: Icon(
            suffix,
            color: suffixIconColor,
          ),
        ),
      ),
    );


//--------------------------------------------------------------------------------------------------\\



Widget defaultButton(
{
  String title='Submit',
  AlignmentGeometry childAlignment=Alignment.center,
  double borderRadius=6,
  AlignmentGeometry gradientEndArea= Alignment.topRight,
  AlignmentGeometry gradientStartArea= Alignment.topLeft,
  required void Function()? onTap,
})
{
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: childAlignment,
      width: 185,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          colors:
          [
            Colors.blue.withOpacity(0.8),
            Colors.redAccent.withOpacity(0.8),
          ],
          end: gradientEndArea,
          begin: gradientStartArea,
        ),
      ),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    ),
  );
}


//-------------------------------------------------------------------------------------------------------\\


//DefaultToast message
Future<bool?> defaultToast({
  required String msg,
  ToastStates state=ToastStates.defaultType,
  ToastGravity position = ToastGravity.BOTTOM,
  Color color = Colors.grey,
  Color textColor= Colors.white,
  Toast length = Toast.LENGTH_SHORT,
  int time = 1,
}) =>
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: time,
      toastLength: length,
      backgroundColor: chooseToastColor(state),
      textColor: textColor,
    );

enum ToastStates{success,error,warning, defaultType}

Color chooseToastColor(ToastStates state) {
  switch (state)
  {
    case ToastStates.success:
      return Colors.green;
  // break;

    case ToastStates.error:
      return Colors.red;
  // break;

    case ToastStates.defaultType:
      return Colors.grey;

    case ToastStates.warning:
      return Colors.amber;
  // break;


  }
}

//--------------------------------------------------------------------------------------------------\\


// Navigate to a screen, it takes context and a widget to go to.

void navigateTo( BuildContext context, Widget widget) =>Navigator.push(
  context,
  MaterialPageRoute(builder: (context)=>widget),
);

//--------------------------------------------------------------------------------------------------\\


// Navigate to a screen and destroy the ability to go back
void navigateAndFinish(context,Widget widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context)=>widget),
      (route) => false,  // The Route that you came from, false will destroy the path back..
);


//--------------------------------------------------------------------------------------------------\\

//Default Divider for ListViews ...
Widget myDivider({Color? c=Colors.grey, double padding=0}) => Container(height: 1, width: double.infinity , color:c, padding: EdgeInsets.symmetric(horizontal: padding),);


//------------------------------------------------------------------------\\

//Meal Item Builder
Widget mealItemBuilder(BuildContext context, AppCubit cubit)
{
  return GestureDetector(
    onTap: ()
    {
      // navigateTo(context, ShowItem(model: model,));
      navigateTo(context, const MealDetails());
    },
    child: Column(
      children: [
        const SizedBox(height: 20,),

        Container(
          width: double.infinity,
          height: 100,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: const AssetImage('assets/images/lasagna.jpg'), //model.recipe!.image!
              fit: BoxFit.fitWidth,
              opacity: 0.2,
              onError:(error,stacktrace)
              {
                print('Error in getting image, ${error.toString()}');
              },
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              const Spacer(),

              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Food Name',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),

              const Spacer(),

              Row(
                children:
                [
                  IconButton(
                      onPressed: ()
                      {
                        // cubit.alterFavourites(model.recipe!);
                      },
                      icon: const Icon(
                        Icons.favorite_border_rounded,
                        size: 20,
                        color: Colors.red,
                      )
                  ),

                  const Spacer(),

                   Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        '6500 SYP',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: cubit.isDarkTheme? goldenColor: steelTealColor
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20,),
      ],
    ),
  );
}


//-------------------------------------------------------------------------\\

// Restaurant Item Builder

Widget restaurantItemBuilder(BuildContext context)
{
  return GestureDetector(
    onTap: ()
    {
      navigateTo(context, const RestaurantPage());
    },
    child: Column(
      children: [
        const SizedBox(height: 20,),

        Container(
          width: double.infinity,
          height: 100,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: const AssetImage('assets/images/american_diner.jpg'), //model.recipe!.image!
              fit: BoxFit.fitWidth,
              opacity: 0.2,
              onError:(error,stacktrace)
              {
                print('Error in getting image, ${error.toString()}');
              },
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:const
                    [
                      CircleAvatar(
                        backgroundColor: Colors.greenAccent,
                        radius: 5,
                      ),

                      const SizedBox(width: 5,),

                      const Text(
                        'Burger King',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '10.00 AM - 12.00 PM',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

            ],
          ),
        ),

        const SizedBox(height: 20,),
      ],
    ),
  );
}


//----------------------------------------------------------------------------\\

//Convert a Color to MaterialColor

MaterialColor getMaterialColor(Color color) {
  final Map<int, Color> shades = {
    50:  const Color.fromRGBO(136, 14, 79, .1),
    100: const Color.fromRGBO(136, 14, 79, .2),
    200: const Color.fromRGBO(136, 14, 79, .3),
    300: const Color.fromRGBO(136, 14, 79, .4),
    400: const Color.fromRGBO(136, 14, 79, .5),
    500: const Color.fromRGBO(136, 14, 79, .6),
    600: const Color.fromRGBO(136, 14, 79, .7),
    700: const Color.fromRGBO(136, 14, 79, .8),
    800: const Color.fromRGBO(136, 14, 79, .9),
    900: const Color.fromRGBO(136, 14, 79, 1),
  };
  return MaterialColor(color.value, shades);
}




//----------------------------------------------------------------------------\\

//Check the user permission for Geo-Locator

Future<bool> handleLocationPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location services are disabled. Please enable the services')));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location permissions are permanently denied, we cannot request permissions.')));
    return false;
  }
  return true;
}


//---------------------------------------------------------------------------------\\


Widget defaultLinearProgressIndicator(BuildContext context)
{
  return LinearProgressIndicator(
    backgroundColor: AppCubit.get(context).isDarkTheme? Colors.grey : null,
  );
}


Widget defaultProgressIndicator(BuildContext context)
{
  return CircularProgressIndicator(
    backgroundColor: AppCubit.get(context).isDarkTheme? Colors.grey : null,
  );
}


//---------------------------------------------------------------------------------------\\