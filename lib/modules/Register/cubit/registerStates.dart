import 'package:yummy/models/RegisterModel/RegisterModel.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class UserRegisterLoadingState extends RegisterStates{}

class UserRegisterSuccessState extends RegisterStates
{
  final RegisterModel registerModel;

  UserRegisterSuccessState(this.registerModel);
}

class UserRegisterErrorState extends RegisterStates
{
  final String error;

  UserRegisterErrorState(this.error);
}

class RegisterPasswordVisibilityChangeState extends RegisterStates{}

class RegisterChangePassVisibilityState extends RegisterStates{}

// LOCATION STATES

class RegisterChangeAutoLocationControllerState extends RegisterStates{}


class RegisterGetCoordinatesLoadingState extends RegisterStates{}

class RegisterGetCoordinatesSuccessState extends RegisterStates{}

class RegisterGetCoordinatesErrorState extends RegisterStates{}


class RegisterGetAddressFromCoordinatesLoadingState extends RegisterStates{}

class RegisterGetAddressFromCoordinatesSuccessState extends RegisterStates{}

class RegisterGetAddressFromCoordinatesErrorState extends RegisterStates{}


