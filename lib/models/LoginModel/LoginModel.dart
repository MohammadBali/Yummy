import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:yummy/models/UserDataModel/UserDataModel.dart';

class LoginModel
{
  int? success;
  String? message;
  String? token;
  UserModel? userData;

  LoginModel.fromJson(Map<String,dynamic>json)
  {
    if(json['success']!=null)
      {
        success=json['success'];
      }

    if(json['message']!=null)
      {
        message=json['message'];
      }

    if(json['token']!=null)
    {
      token=json['token'];
    }

  }

}
