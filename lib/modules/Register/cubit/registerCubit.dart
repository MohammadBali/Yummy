import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummy/modules/Register/cubit/registerStates.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit(): super(RegisterInitialState());

  RegisterCubit get(context)=> BlocProvider.of(context);

}