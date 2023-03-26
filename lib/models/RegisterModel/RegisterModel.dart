class RegisterModel
{
  int? success;
  String? message;
  String? token;

  RegisterModel.fromJson(Map<String,dynamic>json)
  {
    if(json['success']!=null)
      {
        success=json['success'];
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