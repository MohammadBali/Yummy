class RegisterModel
{
  int? code;
  String? message;
  String? token;

  RegisterModel.fromJson(Map<String,dynamic>json)
  {
    if(json['code']!=null)
      {
        code=json['code'];
      }

    if(json['message']!=null)
      {
       message= json['message'];
      }

    if(json['token']!=null)
      {
        token=json['token'];
      }

  }
}