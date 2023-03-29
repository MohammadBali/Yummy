
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