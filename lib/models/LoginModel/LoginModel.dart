class LoginModel
{
  int? code;
  String? message;
  String? token;
  UserData? userData;

  LoginModel.fromJson(Map<String,dynamic>json)
  {
    if(json['code']!=null)
      {
        code=json['code'];
      }
    if(json['message']!=null)
      {
        message=json['message'];
      }

    if(json['token']!=null)
    {
      token=json['token'];
    }

    if(json['userData']!=null)
    {
      userData=UserData.fromJson(json['userData']);
    }
  }

}


class UserData
{
  String? name;
  String? photo;

  UserData.fromJson(Map<String,dynamic>json)
  {
    if(json['name']!=null)
      {
        name=json['name'];
      }

    if(json['photo']!=null)
    {
      photo=json['photo'];
    }
  }
}