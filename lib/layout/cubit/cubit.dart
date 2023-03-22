import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yummy/layout/cubit/states.dart';
import 'package:yummy/modules/Profile/profile_page.dart';
import 'package:yummy/shared/components/components.dart';

import '../../modules/Home/home_page.dart';
import '../../modules/Restaurants/restaurants_page.dart';
import '../../shared/network/local/cache_helper.dart';
import 'package:latlong2/latlong.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit(): super(AppInitialState());

  static AppCubit get(context) =>BlocProvider.of(context);

  List<Widget> bottomBarWidgets=
  [
    const HomePage(),
    const RestaurantsPage(),
    const ProfilePage(),
  ];

  int currentBottomBarIndex=0;

  void changeBottomNavBar(int index)
  {
    currentBottomBarIndex=index;

    emit(AppChangeBottomNavBar());
  }

  bool isDarkTheme=false; //Check if the theme is Dark.

  void changeTheme({bool? themeFromState})
  {
    if(themeFromState !=null)  //if a value is sent from main, then use it.. we didn't use CacheHelper because the value has already came from cache, then there is no need to..
    {
      isDarkTheme=themeFromState;
      emit(AppChangeThemeModeState());
    }
    else                      // else which means that the button of changing the theme has been pressed.
    {
      isDarkTheme= !isDarkTheme;
      CacheHelper.putBoolean(key: 'isDarkTheme', value: isDarkTheme).then((value)  //Put the data in the sharedPref and then emit the change.
      {
        emit(AppChangeThemeModeState());
      });
    }

  }


  List<String> itemsList=[
    'Main Meals',
    'Chicken Meals',
    'Steaks',
    'Desserts',
    'Appetizers',
    'Beverages',
  ];

  int currentItemListIndex=0;

  void changeCurrentItemList(int index)
  {
    currentItemListIndex=index;
    emit(AppChangeItemListState());
  }

  bool isCurrentItemList(int index)
  {
    if (currentItemListIndex==index)
    {
      // emit(AppCheckItemListState());
      return true;

    }
    // emit(AppCheckItemListState());
    return false;
  }


  //MAP LONGITUDE AND LATITUDE for mapPage

  MapController mapController=MapController();

  double mapLongitude=0.0;
  double mapLatitude=0.0;
  bool isMapLoaded=false;

  String areaName='';  //to Show Area Name

  // Change current location to a desired Coordinates, if isLoaded is passed as true, then we will update the Controller Area and change the state that the map is loaded.
  void changeMapCoordinates(double long, double lat, bool isLoaded, {double zoom=15.2})
  {
    mapLatitude=lat;
    mapLongitude=long;
    if(isLoaded==true)
      {
        mapController.move(LatLng(lat,long), zoom);
      }

    if(isMapLoaded==false)
      {
        print('change isMapLoaded to true');
        changeIsMapLoaded(true);
      }

    emit(AppChangeMapCoordinatesSuccessState());

    getAddressFromCoordinates(long,lat);
  }

  void changeIsMapLoaded(bool isLoaded)
  {
    isMapLoaded=isLoaded;
    emit(AppChangeIsMapLoadedState());
  }

  //Get Coordinates from and Address
  Future<void> getCoordinatesFromAddress(String add) async
  {
    emit(AppChangeMapCoordinatesFromAddressLoadingState());
    print('Getting Address Details from Query...');

    try
    {
      List<Address> address = await Geocoder.local.findAddressesFromQuery(add);
      print('The Address Details Are, Longitude: ${address[0].coordinates.longitude}, Latitude:${address[0].coordinates.latitude}, Address Line: ${address[0].addressLine}');

      changeMapCoordinates(address[0].coordinates.longitude!, address[0].coordinates.latitude!, true);
    }

    catch(error)
    {
      defaultToast(msg: "Couldn't get coordinates.");
      print('ERROR WHILE GETTING COORDINATES FROM ADDRESS, ${error.toString()}');
      emit(AppChangeMapCoordinatesFromAddressErrorState());
    }
  }


  Future<void> getAddressFromCoordinates(double long, double lat) async
  {
   print('Getting Address From Coordinates');

   emit(AppGetAddressFromCoordinatesLoadingState());

    final coordinates = Coordinates(lat, long);

    try
    {
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print("Address Details are: ${first.adminArea} : ${first.addressLine}");
      areaName=(first.adminArea ?? 'Not Assigned');
      emit(AppGetAddressFromCoordinatesSuccessState());
    }
    catch (error)
    {
      print('ERROR WHILE GETTING ADDRESS FROM COORDINATES, ${error.toString()}');
      defaultToast(msg: 'Could not get Address from Coordinates');
      emit(AppGetAddressFromCoordinatesErrorState());
    }
  }

  //Markers .
  double markerLongitude=0.0;
  double markerLatitude=0.0;

  void setMarker(double long, double lat)
  {
    markerLongitude=long;
    markerLatitude=lat;

    emit(AppSetMarkerState());
  }








}