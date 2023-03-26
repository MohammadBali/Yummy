import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummy/layout/cubit/cubit.dart';
import 'package:yummy/models/LoginModel/LoginModel.dart';
import 'package:yummy/modules/Login/cubit/loginStates.dart';
import 'package:yummy/shared/components/components.dart';
import 'package:yummy/shared/network/end_points.dart';
import 'package:yummy/shared/network/remote/main_dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit():super(LoginInitialState());

  static LoginCubit get(context) =>BlocProvider.of(context);


  bool isPassVisible=true;

  void changePassVisibility()
  {
    isPassVisible=!isPassVisible;
    emit(LoginChangePassVisibilityState());
  }


  LoginModel? loginModel;
  void userLogin(String number, String password)
  {
    print('in UserLogin...');
    emit(LoginLoadingState());

    MainDioHelper.postData(
      url: login,
      data: {
        'number':number,
        'password':password,
      },
    ).then((value)
    {
      print('Got Login Data, ${value.data}');

      loginModel=LoginModel.fromJson(value.data);
      AppCubit().getUserData(loginModel?.token);

      emit(LoginSuccessState(loginModel!));
    }).catchError((error)
    {
      print('ERROR WHILE LOGGING IN, ${error.toString()}');
      emit(LoginErrorState(error.toString()));
    });
  }

}