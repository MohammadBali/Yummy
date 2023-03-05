import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
Widget mealItemBuilder(BuildContext context)
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

                  const Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Meal Type',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14
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
            children: const
            [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Restaurant Name',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
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
