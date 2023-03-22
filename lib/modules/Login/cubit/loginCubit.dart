import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummy/modules/Login/cubit/loginStates.dart';
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


  void login(String number, String password)
  {
    print('Sending Login Data');
    emit(LoginSendLoginDataLoadingState());

    MainDioHelper.getData(
      url: 'login',
      query: {
        'phone':number,
        'password':password,
      },
    ).then((value)
    {
      print('Got Login Data, ${value.data}');


      emit(LoginSendLoginDataSuccessState());
    }).catchError((error)
    {
      print('ERROR WHILE LOGGING IN, ${error.toString()}');
      emit(LoginSendLoginDataLErrorState());
    });
  }

}