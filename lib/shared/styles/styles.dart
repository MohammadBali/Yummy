import 'package:flutter/material.dart';

TextStyle defaultHeadlineTextStyle= const TextStyle(

  fontSize: 25,
  fontWeight: FontWeight.w600,  //was bold
  letterSpacing: 1,

); //A Style for Headlines.


TextStyle defaultMealNameTextStyle= TextStyle(

  fontSize: 25,
  fontWeight: FontWeight.w600,  //was bold
  letterSpacing: 1,
  color: Colors.redAccent.withOpacity(0.8)
);


TextStyle defaultRestaurantNameInMealTextStyle= const TextStyle(
    fontStyle: FontStyle.italic,
    fontSize: 18,
    fontWeight: FontWeight.w400,  //was bold
    letterSpacing: 1,
);


TextStyle defaultDescriptionTextStyle= const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,  //was bold
    letterSpacing: 1,
);


TextStyle defaultPriceTextStyle= const TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,  //was bold
  letterSpacing: 1,
  color: Colors.blue
);

TextStyle defaultRestaurantNameTextStyle= TextStyle(

    fontSize: 25,
    fontWeight: FontWeight.w600,  //was bold
    letterSpacing: 1,
    color: Colors.redAccent.withOpacity(0.8)
);