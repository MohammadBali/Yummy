
import '../../models/BankingModels/BankingLoginModel/BankingLoginModel.dart';

abstract class AppStates{}

class AppInitialState extends AppStates{}

class AppChangeBottomNavBar extends AppStates{}

class AppChangeThemeModeState extends AppStates{}

class AppChangeItemListState extends AppStates{}

class AppCheckItemListState extends AppStates{}

//MAPS STATES:

class AppChangeMapCoordinatesFromAddressLoadingState extends AppStates{}

class AppChangeMapCoordinatesFromAddressErrorState extends AppStates{}

class AppChangeMapCoordinatesSuccessState extends AppStates{}

class AppChangeIsMapLoadedState extends AppStates{}

class AppSetMarkerState extends AppStates{}


class AppGetAddressFromCoordinatesLoadingState extends AppStates{}

class AppGetAddressFromCoordinatesSuccessState extends AppStates{}

class AppGetAddressFromCoordinatesErrorState extends AppStates{}


//-------------------------------------------------------\\

//GET USER DATA...

class AppGetUserDataLoadingState extends AppStates{}

class AppGetUserDataSuccessState extends AppStates{}

class AppGetUserDataErrorState extends AppStates{}



//----------------------------------------------------\\

// GET ALL RESTAURANTS:

class AppGetAllRestaurantsLoadingState extends AppStates{}

class AppGetAllRestaurantsSuccessState extends AppStates{}

class AppGetAllRestaurantsErrorState extends AppStates{}


//----------------------------------------------------\\

// SEARCH FOR A RESTAURANTS:

class AppSearchForRestaurantLoadingState extends AppStates{}

class AppSearchForRestaurantSuccessState extends AppStates {}

class AppSearchForRestaurantErrorState extends AppStates{}



//----------------------------------------------------\\

// GET A RESTAURANT THROUGH ID:

class AppGetRestaurantByIDLoadingState extends AppStates{}

class AppGetRestaurantByIDSuccessState extends AppStates {}

class AppGetRestaurantByIDErrorState extends AppStates{}




//----------------------------------------------------\\

// GET ALL MEALS:

class AppGetAllMealsLoadingState extends AppStates{}

class AppGetAllMealsSuccessState extends AppStates{}

class AppGetAllMealsErrorState extends AppStates{}



//----------------------------------------------------\\

// GET A MEAL:

class AppGetMealLoadingState extends AppStates{}

class AppGetMealSuccessState extends AppStates{}

class AppGetMealErrorState extends AppStates{}

//----------------------------------------------------\\


// Search A MEAL:

class AppSearchMealLoadingState extends AppStates{}

class AppSearchMealSuccessState extends AppStates{
  final int success;

  AppSearchMealSuccessState(this.success);
}

class AppSearchMealErrorState extends AppStates{}

//----------------------------------------------------\\


// GET TRENDY MEALS:

class AppGetTrendyMealsLoadingState extends AppStates{}

class AppGetTrendyMealsSuccessState extends AppStates{}

class AppGetTrendyMealsErrorState extends AppStates{}


//----------------------------------------------------\\


// GET OFFERS:

class AppGetOffersLoadingState extends AppStates{}

class AppGetOffersSuccessState extends AppStates{}

class AppGetOffersErrorState extends AppStates{}


//----------------------------------------------------\\


// GET RESTAURANT MEALS:

class AppGetRestaurantMealsLoadingState extends AppStates{}

class AppGetRestaurantMealsSuccessState extends AppStates{}

class AppGetRestaurantMealsErrorState extends AppStates{}


//----------------------------------------------------\\


// GET RESTAURANT MENU:

class AppGetRestaurantMenuLoadingState extends AppStates{}

class AppGetRestaurantMenuSuccessState extends AppStates{}

class AppGetRestaurantMenuErrorState extends AppStates{}


//----------------------------------------------------\\



// GET PREVIOUS ORDERS:

class AppGetPreviousOrdersLoadingState extends AppStates{}

class AppGetPreviousOrdersSuccessState extends AppStates{}

class AppGetPreviousOrdersErrorState extends AppStates{}



//----------------------------------------------------\\



// GET ORDER DETAILS:

class AppGetOrderDetailsLoadingState extends AppStates{}

class AppGetOrderDetailsSuccessState extends AppStates{}

class AppGetOrderDetailsErrorState extends AppStates{}


//----------------------------------------------------\\



// CART STATES :

class AppAddToCartState extends AppStates{}

class AppCartIsShownState extends AppStates{}

class AppChangeQuantityInCartState extends AppStates{}

class AppRemoveItemFromCartState extends AppStates{}

class AppChangeCartCostState extends AppStates{}

class AppSubmitCartLoadingState extends AppStates{}

class AppSubmitCartSuccessState extends AppStates{
  final int success;

  AppSubmitCartSuccessState(this.success);
}

class AppSubmitCartErrorState extends AppStates{}

class AppCartItemIsFoundState extends AppStates{}


//--------------------------------------------------\\

class AppCreditCardLoadingState extends AppStates{}

class AppCreditCardSuccessState extends AppStates{
  final int success;

  AppCreditCardSuccessState(this.success);
}

class AppCreditCardErrorState extends AppStates{}



//-------------------------------------------------------\\

//Delivery Cost

class AppSetDeliveryCostState extends AppStates{}


//----------------------------------------------------\\

//BANKING

class AppBankingChangePassVisibilityState extends AppStates{}

class AppBankingLoginLoadingState extends AppStates{}

class AppBankingLoginSuccessState extends AppStates{
  final BankingLoginModel model;

  AppBankingLoginSuccessState(this.model);
}

class AppBankingLoginErrorState extends AppStates{
  final String error;

  AppBankingLoginErrorState(this.error);
}

//----------------------------------------------------

//Change Password

class AppBankingChangePasswordLoadingState extends AppStates{}

class AppBankingChangePasswordSuccessState extends AppStates{}

class AppBankingChangePasswordErrorState extends AppStates{}

//----------------------------------------------------

// GET USER DATA

class AppBankingGetUserDataLoadingState extends AppStates{}

class AppBankingGetUserDataSuccessState extends AppStates{}

class AppBankingGetUserDataErrorState extends AppStates{}

//----------------------------------------------------

// BANKING LOGOUT

class AppBankingLogoutState extends AppStates{}

class AppBankingClearCartState extends AppStates{}