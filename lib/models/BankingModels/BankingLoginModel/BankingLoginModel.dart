class BankingLoginModel
{
  int? success;
  String? message;
  String? token;

  BankingLoginModel.fromJson(Map<String,dynamic>json)
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

class UserBankingModel
{
  String? name;
  int? id;
  dynamic balance;

  UserBankingModel.fromJson(Map<String,dynamic>json)
  {
    name=json['user_name'];
    balance=json['balance'];
    id=json['id'];
  }

}