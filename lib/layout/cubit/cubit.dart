import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:yummy/layout/cubit/states.dart';
import 'package:yummy/models/MealModel/meal_model.dart';
import 'package:yummy/models/UserDataModel/UserDataModel.dart';
import 'package:yummy/modules/Profile/profile_page.dart';
import 'package:yummy/shared/components/components.dart';
import 'package:yummy/shared/network/remote/main_dio_helper.dart';
import '../../models/BankingModels/BankingLoginModel/BankingLoginModel.dart';
import '../../models/PreviousOrderDetailsModel/PreviousOrderDetailsModel.dart';
import '../../models/PreviousOrderModel/PreviousOrderModel.dart';
import '../../models/RestaurantsModel/Restaurant_Model.dart';
import '../../modules/Home/home_page.dart';
import '../../modules/Restaurants/restaurants_page.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/local/cache_helper.dart';
import 'package:latlong2/latlong.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> bottomBarWidgets = [
    const HomePage(),
    const RestaurantsPage(),
    const ProfilePage(),
  ];

  int currentBottomBarIndex = 0;

  void changeBottomNavBar(int index) {
    currentBottomBarIndex = index;

    emit(AppChangeBottomNavBar());
  }

  bool isDarkTheme = false; //Check if the theme is Dark.

  void changeTheme({bool? themeFromState}) {
    if (themeFromState !=
        null) //if a value is sent from main, then use it.. we didn't use CacheHelper because the value has already came from cache, then there is no need to..
    {
      isDarkTheme = themeFromState;
      emit(AppChangeThemeModeState());
    } else // else which means that the button of changing the theme has been pressed.
    {
      isDarkTheme = !isDarkTheme;
      CacheHelper.putBoolean(key: 'isDarkTheme', value: isDarkTheme).then(
          (value) //Put the data in the sharedPref and then emit the change.
          {
        emit(AppChangeThemeModeState());
      });
    }
  }

  List<String> itemsList = [
    'Main Meals',
    'Chicken Meals',
    'Steaks',
    'Desserts',
    'Appetizers',
    'Beverages',
  ];

  int currentItemListIndex = 0;

  void changeCurrentItemList(int index) {
    currentItemListIndex = index;
    emit(AppChangeItemListState());
  }

  bool isCurrentItemList(int index) {
    if (currentItemListIndex == index) {
      // emit(AppCheckItemListState());
      return true;
    }
    // emit(AppCheckItemListState());
    return false;
  }

  //GET USER DATA...

  static UserModel? userModel;

  void getUserData(String? token) //Decode the Token and get the data of it, then store it in userModel
  {
    if (token != '') {
      emit(AppGetUserDataLoadingState());
      try {
        Map<String, dynamic> dToken =
            JwtDecoder.decode(token!); //Decode the Token to get Data
        print('Decoded User Data Successfully in AppCubit, $dToken');
        userModel = UserModel.fromJson(dToken);

        emit(AppGetUserDataSuccessState());
      } catch (error) {
        print('ERROR WHILE DECODING JWT, ${error.toString()}');
        emit(AppGetUserDataErrorState());
      }
    }
  }

  //REST API METHODS...

  //----------------------------------------------\\

  //GET RESTAURANTS...

  RestaurantModel? allRestaurantsModel;

  void getRestaurants() {
    print('Getting Restaurants...');
    emit(AppGetAllRestaurantsLoadingState());

    MainDioHelper.getData(
      url: getAllRestaurants,
    ).then((value) {
      print('Got All Restaurants Data,${value.data}');
      allRestaurantsModel = RestaurantModel.fromJson(value.data);
      emit(AppGetAllRestaurantsSuccessState());
      mappingRestaurantNamesToId(); //Mapping each restaurant to it's id in a Map;
      getRestaurantMenu(); //Add Menus for each restaurant.

    }).catchError((error) {
      print('ERROR WHILE GETTING ALL RESTAURANTS, ${error.toString()}');

      emit(AppGetAllRestaurantsErrorState());
    });
  }

  //---------------------

  //Search for a restaurant.
  void searchRestaurants(String data) {
    print('in Searching For a Restaurant...');
    emit(AppSearchForRestaurantLoadingState());

    MainDioHelper.getData(
      url: '$searchForRestaurants/$data',
    ).then((value) {
      print('Got Search for a restaurants data, ${value.data}');

      emit(AppSearchForRestaurantSuccessState());
    }).catchError((error) {
      print('ERROR WHILE GETTING SEARCH FOR A RESTAURANT, ${error.toString()}');
      emit(AppSearchForRestaurantErrorState());
    });
  }


  Map<int,String> restaurantsMap={};
  void mappingRestaurantNamesToId()
  {
    for (var element in allRestaurantsModel!.data!)
    {
      restaurantsMap.addEntries({element!.id!:element.name! }.entries);
    }

    print('All RestaurantMap: $restaurantsMap');
  }

  //-------------------------

  //Get Meal Details.
  void getMealDetailsById(int id) {
    print('In Get Meal..');
    emit(AppGetMealLoadingState());

    MainDioHelper.getData(
      url: '$getAMeal/$id/',
    ).then((value) {
      print('Got Meals Details, ${value.data}');

      emit(AppGetMealSuccessState());
    }).catchError((error) {
      print('ERROR WHILE GETTING MEAL BY ID, ${error.toString()}');
      emit(AppGetMealErrorState());
    });
  }


  //--------------------------------------------------------------\\

  //Get all meals provided by a specified restaurant.
  MealModel? restaurantMeals;

  void getRestaurantMeals(int id) {
    print('In Getting Restaurant Meals...');
    emit(AppGetRestaurantMealsLoadingState());

    MainDioHelper.getData(url: '$allRestaurantMeals/$id/').then((value) {
      print('Got Restaurant meals data, ${value.data}');

      restaurantMeals = MealModel.fromJson(value.data);

      emit(AppGetRestaurantMealsSuccessState());
    }).catchError((error) {
      print('ERROR WHILE GETTING RESTAURANT MEALS, ${error.toString()}');
      emit(AppGetRestaurantMealsErrorState());
    });
  }

  RestaurantModel? restaurantModel;

  void getRestaurant(int id) {
    print('In Getting a restaurant thorugh ID...');
    emit(AppGetRestaurantByIDLoadingState());

    MainDioHelper.getData(url: '$getRestaurantById/$id/').then((value) {
      print('Got Restaurant details, ${value.data}');

      restaurantModel = RestaurantModel.fromJson(value.data);
      emit(AppGetRestaurantByIDSuccessState());
    }).catchError((error) {
      print('ERROR WHILE GETTING A RESTAURANT BY ID, ${error.toString()}');

      emit(AppGetRestaurantByIDErrorState());
    });
  }


  //Get Menu for each Restaurant.
  void getRestaurantMenu()
  {
    print('Getting Restaurant Menus');
    
    for (var element in allRestaurantsModel!.data!)
    {
      print('Getting Restaurant ${element!.id} Menu...');
      emit(AppGetRestaurantMenuLoadingState());
      
      MainDioHelper.getData(
        url: '$menus/${element.id}/',
      ).then((value)
      {
        print('Got Menu for ${element.name}..., ${value.data}');

        List<MenuModel>items=[];

        value.data['data'].forEach((item)
        {
          items.add( MenuModel.addMenuValues(item['name'], item['id']) );
        });

        // element=Restaurant.addMenu(items);

        element.menu=items;

        emit(AppGetRestaurantMenuSuccessState());
      }).catchError((error)
      {
        print('ERROR WHILE GETTING RESTAURANT ${element.name} MENU, ${error.toString()}');
        emit(AppGetRestaurantMenuErrorState());
      });
    }
  }


  //----------------------------------

  //Will Return all the meals having this menu-Id.

  List<Meal> mealsForMenuId(int id)
  {
    List<Meal> list=[];
    for(var element in restaurantMeals!.data!)
      {
        if(element.menuId==id)
          {
            list.add(element);
          }
      }
    return list;
  }

  //------------------------

  MealModel? searchMealModel;

  //Search for a Meal
  void searchMeal(String data) {
    print('in Search for a Meal...');

    emit(AppSearchMealLoadingState());

    MainDioHelper.getData(url: '$searchForMeal/$data').then((value) {
      print('Got Search for a Meal Data, ${value.data}');

      searchMealModel = MealModel.fromJson(value.data);

      emit(AppSearchMealSuccessState(searchMealModel!.success!));
    }).catchError((error) {
      print('ERROR WHILE SEARCHING FOR A MEAL, ${error.toString()}');
      defaultToast(msg: "Couldn't Find Any results");
      emit(AppSearchMealErrorState());
    });
  }

  //-------------------


  MealModel? allMealsModel;
  //GET ALL Meals
  void getAllMeals()
  {
    emit(AppGetAllMealsLoadingState());

    MainDioHelper.getData(
      url: allMeals,
    ).then((value)
    {
      print('Got All Meals, ${value.data}');
      allMealsModel=MealModel.fromJson(value.data);
      emit(AppGetAllMealsSuccessState());
      mappingMealsNamesToId();
    }).catchError((error)
    {
      print('ERROR WHILE GETTING ALL MEALS, ${error.toString()}');
      emit(AppGetAllMealsErrorState());
    });
  }



  Map<int,String> mealsMap={};
  void mappingMealsNamesToId()
  {
    for (var element in allMealsModel!.data!)
    {
      mealsMap.addEntries({element.id!:element.name! }.entries);
    }

    print('All RestaurantMap: $mealsMap');
  }


  //------------------------------------------------

  MealModel? trendyMeals;

  //Get Trendy Meals
  void getTrendy() {
    print('in GetTrendy Meals...');
    emit(AppGetTrendyMealsLoadingState());

    MainDioHelper.getData(
      url: getTrendyMeals,
    ).then((value) {
      print('Got Trendy Meals, ${value.data}');

      trendyMeals = MealModel.fromJson(value.data);

      emit(AppGetTrendyMealsSuccessState());
    }).catchError((error) {
      print('ERROR WHILE GETTING TRENDY MEALS, ${error.toString()}');
      emit(AppGetTrendyMealsErrorState());
    });
  }

  //-----------------

  MealModel? offersModel;

  //Get Meals Offers
  void getOffers() {
    print('In Getting Offers...');
    emit(AppGetOffersLoadingState());

    MainDioHelper.getData(url: mealsOffers).then((value) {
      print('Got Offers Data, ${value.data}');

      offersModel = MealModel.fromJson(value.data);
      emit(AppGetOffersSuccessState());
    }).catchError((error) {
      print('ERROR WHILE GETTING OFFERS, ${error.toString()}');
      emit(AppGetOffersErrorState());
    });
  }




  //----------------------------------------------------------------------\\

  //MAP LONGITUDE AND LATITUDE for mapPage

  MapController mapController = MapController();

  double mapLongitude = 0.0;
  double mapLatitude = 0.0;
  bool isMapLoaded = false;

  String areaName = ''; //to Show Area Name

  // Change current location to a desired Coordinates, if isLoaded is passed as true, then we will update the Controller Area and change the state that the map is loaded.
  void changeMapCoordinates(double long, double lat, bool isLoaded,
      {double zoom = 15.2}) {
    mapLatitude = lat;
    mapLongitude = long;
    if (isLoaded == true) {
      mapController.move(LatLng(lat, long), zoom);
    }

    if (isMapLoaded == false) {
      print('change isMapLoaded to true');
      changeIsMapLoaded(true);
    }

    emit(AppChangeMapCoordinatesSuccessState());

    getAddressFromCoordinates(long, lat);
  }

  void changeIsMapLoaded(bool isLoaded) {
    isMapLoaded = isLoaded;
    emit(AppChangeIsMapLoadedState());
  }

  //Get Coordinates from and Address
  Future<void> getCoordinatesFromAddress(String add) async {
    emit(AppChangeMapCoordinatesFromAddressLoadingState());
    print('Getting Address Details from Query...');

    try {
      List<Address> address = await Geocoder.local.findAddressesFromQuery(add);
      print(
          'The Address Details Are, Longitude: ${address[0].coordinates.longitude}, Latitude:${address[0].coordinates.latitude}, Address Line: ${address[0].addressLine}');

      changeMapCoordinates(address[0].coordinates.longitude!,
          address[0].coordinates.latitude!, true);
    } catch (error) {
      defaultToast(msg: "Couldn't get coordinates.");
      print(
          'ERROR WHILE GETTING COORDINATES FROM ADDRESS, ${error.toString()}');
      emit(AppChangeMapCoordinatesFromAddressErrorState());
    }
  }

  Future<void> getAddressFromCoordinates(double long, double lat) async {
    print('Getting Address From Coordinates');

    emit(AppGetAddressFromCoordinatesLoadingState());

    final coordinates = Coordinates(lat, long);

    try {
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print("Address Details are: ${first.adminArea} : ${first.addressLine}");
      areaName = (first.adminArea ?? 'Not Assigned');
      emit(AppGetAddressFromCoordinatesSuccessState());
    } catch (error) {
      print(
          'ERROR WHILE GETTING ADDRESS FROM COORDINATES, ${error.toString()}');
      defaultToast(msg: 'Could not get Address from Coordinates');
      emit(AppGetAddressFromCoordinatesErrorState());
    }
  }

  //Markers .
  double markerLongitude = 0.0;
  double markerLatitude = 0.0;

  void setMarker(double long, double lat) {
    markerLongitude = long;
    markerLatitude = lat;

    emit(AppSetMarkerState());
  }



  //-------------------------------------------------------------------------\\





  // USER CART....

  bool isCartShown = false;

  double cartCost = 0;

  List<Meal> cartMeals = [];

  void addToCart(Meal meal) {
    print('Adding a meal to cart..., number of elements before adding is: ${cartMeals.length}');
    print('Current meal id is: ${meal.id}');

    if (isCartShown == false) {
      isCartShown = true;
      emit(AppCartIsShownState());
    }

    bool isFound = false;
    for (var element in cartMeals)
    {
      if (element.id == meal.id)
      {
        print('Element was here before, increasing quantity now...');
        element.quantity++;
        isFound = true;
        emit(AppCartItemIsFoundState());
        totalCartCost();
        break;
      }
    }

    if (isFound == false) {
      print('Element wasnt here before, adding new element to the list');
      meal.quantity = 1;
      cartMeals.add(meal);
      totalCartCost();
    }
    emit(AppAddToCartState());
  }

  void changeQuantityInCart({required int index, required bool increase}) {
    if (increase == true) {
      cartMeals.elementAt(index).quantity++;
      totalCartCost();
      emit(AppChangeQuantityInCartState());
    } else {
      if (cartMeals.elementAt(index).quantity == 1) {
        cartMeals.removeAt(index);
        totalCartCost();
        emit(AppRemoveItemFromCartState());
      } else {
        cartMeals.elementAt(index).quantity--;
        totalCartCost();
        emit(AppChangeQuantityInCartState());
      }
    }
  }

  void totalCartCost() {
    cartCost = 0;
    for (var element in cartMeals) {
      if (element.discount != null) {
        cartCost = cartCost +
            (element.quantity *
                (element.price - (element.discount * element.price) / 100));
      } else {
        cartCost = cartCost + (element.quantity * element.price!);
      }
    }
    cartCost=cartCost+deliveryCost;

    emit(AppChangeCartCostState());
  }

  void submitOrder()
  {
    print('Submitting order...');

    emit(AppSubmitCartLoadingState());

    MainDioHelper.postData(
        url: orderSubmit,
        data:
        {
          'user_id':userModel!.result!.id!,
          'res_id':cartMeals[0].restaurantId,
          'purchase_date':DateFormat('yyyy-MM-dd').format(DateTime.now()) ,
          'total_cost':cartCost,
          'payment_method':'cash',
          'order_items':formattedCartItems(),
        },
    ).then((value)
    {
      print('Submitted Order successfully, ${value.data}');
      defaultToast(msg: value.data['message']);

      emit(AppSubmitCartSuccessState(value.data['success']));


    }).catchError((error)
    {
      print('ERROR WHILE SUBMITTING ORDER, ${error.toString()}');

      emit(AppSubmitCartErrorState());


    });


  }

  //FormatCartItems into a list of product_id and quantity
  List<Map<String,int> > formattedCartItems()
  {
    List<Map<String,int> >formulatedList=[];

    for(var item in cartMeals)
    {
      formulatedList.add({
        'pro_id':item.id!,
        'quantity':item.quantity,
      });
    }

    return formulatedList;
  }

  //-------------------------------------


  //Get Previous Orders by a userId.
  PreviousOrderModel? previousOrderModel;
  void getPreviousOrders(int id)
  {
    print('Getting Previous Orders..');
    emit(AppGetPreviousOrdersLoadingState());

    MainDioHelper.getData(
      url: '$previousOrders/$id/',
    ).then((value)
    {
      print('Got Previous Orders successfully, ${value.data}');
      previousOrderModel=PreviousOrderModel.fromJson(value.data);

      //Sorting Array
      previousOrderModel!.data.sort((a,b)
      {
        var adate= DateTime.parse(a!.purchaseDate!);
        var bdate= DateTime.parse(b!.purchaseDate!);
        return -bdate.compareTo(adate);
      });

      emit(AppGetPreviousOrdersSuccessState());
    }).catchError((error)
    {
      print('ERROR WHILE GETTING PREVIOUS ORDERS, ${error.toString()}');
      emit(AppGetPreviousOrdersErrorState());
    });
  }


  //-----------------------------


  //Get Products in an order.

  PreviousOrderDetailsModel? previousOrderDetailsModel;

  void getOrderDetails(int orderId)
  {
    print('Getting Order Details...');
    emit(AppGetOrderDetailsLoadingState());

    MainDioHelper.getData(
      url: '$orderProducts/$orderId/',
    ).then((value)
    {
      print('Got Order details, ${value.data}');

      previousOrderDetailsModel=PreviousOrderDetailsModel.fromJson(value.data);

      emit(AppGetOrderDetailsSuccessState());
    }).catchError((error)
    {
      print('ERROR WHILE GETTING ORDER DETAILS, ${error.toString()}');
      emit(AppGetOrderDetailsErrorState());
    });
  }

  static double deliveryCost=0;

  static void setDeliveryCost(double distance)
  {
    deliveryCost=0;
    deliveryCost= deliveryCostCalculator(distance).roundToDouble();
    //emit(AppSetDeliveryCostState());
  }


  //--------------------------------------------------------------------\\

  //BANKING

  bool isBankPassVisible=true;

  void changeBankingPassVisibility()
  {
    isBankPassVisible=!isBankPassVisible;
    emit(AppBankingChangePassVisibilityState());
  }


  BankingLoginModel? bankingLoginModel;
  void bankingUserLogin(String number, String password)
  {
    print('in BankingLogin...');
    emit(AppBankingLoginLoadingState());

    MainDioHelper.postData(
      url: login,
      data: {
        'number':number,
        'password':password,
      },
    ).then((value)
    {
      print('Got Banking Login Data, ${value.data}');

      bankingLoginModel=BankingLoginModel.fromJson(value.data);

      // AppCubit().getUserData(bankingLoginModel?.token);

      emit(AppBankingLoginSuccessState(bankingLoginModel!));
    }).catchError((error)
    {
      print('ERROR WHILE LOGGING IN, ${error.toString()}');
      emit(AppBankingLoginErrorState(error.toString()));
    });
  }

  //Change User Password
  void bankingChangePassword(String password)
  {
    print('in BankingChangePassword');
    emit(AppBankingChangePasswordLoadingState());

    MainDioHelper.patchData(
        url: '',
        data:
        {
          'user_id':bankingLoginModel?.userData?.id,
          'password':password
        },
    ).then((value)
    {
      print('Got BankingChangePassword Data, ${value.data}');

      emit(AppBankingChangePasswordSuccessState());
    }).catchError((error)
    {
      print('ERROR WHILE CHANGING BANKING PASSWORD, ${error.toString()}');

      emit(AppBankingChangePasswordErrorState());
    });
  }
}
