
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yummy/models/RegisterModel/RegisterModel.dart';
import 'package:yummy/modules/Register/cubit/registerStates.dart';
import 'package:yummy/shared/network/remote/main_dio_helper.dart';

import '../../../shared/components/components.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit(): super(RegisterInitialState());

  RegisterCubit get(context)=> BlocProvider.of(context);

  bool isPassVisible=true;

  void changePassVisibility()
  {
    isPassVisible=!isPassVisible;
    emit(RegisterChangePassVisibilityState());
  }

  RegisterModel? registerModel;
  void userRegister(
  {
    required String name,
    required String password,
    required String phoneNumber,
    required String writtenLocation,
    required String autoLocation,
  })
  {
    emit(UserRegisterLoadingState());
    print('in User Register...');

    MainDioHelper.postData(
      url: 'TBD',
      data:
      {
        'name':name,
        'password':password,
        'phoneNumber':phoneNumber,
        'writtenLocation':writtenLocation,
        'autoLocation':autoLocation,
      },
    ).then((value)
    {
      print('Got Register Data, ${value.data}');

      registerModel= RegisterModel.fromJson(value.data);
      emit(UserRegisterSuccessState(registerModel!));
    }).catchError((error)
    {
      print('ERROR WHILE REGISTERING USER, ${error.toString()}');
      emit(UserRegisterErrorState(error.toString()));
    });

  }


  //----------------------------------------------------------\\

  TextEditingController autoLocationController=TextEditingController();
  void changeAutoLocationControllerValue(String val)
  {
    autoLocationController.text=val;
    emit(RegisterChangeAutoLocationControllerState());
  }


  //Get Current Location

  Future<void> getCurrentPosition(BuildContext context) async
  {
    emit(RegisterGetCoordinatesLoadingState());

    final hasPermission = await handleLocationPermission(context); //Check for Permission
    if (!hasPermission) return;
    defaultToast(msg: 'Getting Coordinates, Please wait');
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high).then((Position position)
    {
      print('Your Position is, $position}');
      defaultToast(msg: 'Your Position is, $position}');

      changeAutoLocationControllerValue(position.toString());

      emit(RegisterGetCoordinatesSuccessState());

      getAddressFromCoordinates(position);

    }).catchError((e)
    {
      print('ERROR WHILE GETTING COORDINATES IN REGISTER, ${e.toString()}');
      emit(RegisterGetCoordinatesErrorState());
    });
  }

  Future<void> getAddressFromCoordinates(Position position) async
  {
    emit(RegisterGetAddressFromCoordinatesLoadingState());
    defaultToast(msg: 'Getting Address from Coordinates');

    final coordinates = Coordinates(position.latitude, position.longitude);
    // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // var first = addresses.first;
    // print("${first.featureName} : ${first.addressLine}");
    // changeAutoLocationControllerValue('${first.featureName}, ${first.addressLine}');

    Geocoder.local.findAddressesFromCoordinates(coordinates).then((addresses)
    {
      var first= addresses.first;
      print("${first.featureName} : ${first.addressLine}");
      changeAutoLocationControllerValue('${first.featureName}, ${first.addressLine}');
      emit(RegisterGetAddressFromCoordinatesSuccessState());
    }).catchError((error)
    {
      print('ERROR WHILE TRANSLATING COORDINATES INTO ADDRESS, ${error.toString()}');
      defaultToast(msg: 'Error while translating coordinates into address, enable a VPN');
      emit(RegisterGetAddressFromCoordinatesErrorState());
    });
  }


}