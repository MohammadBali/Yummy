class BankingLoginModel
{
  int? success;
  String? message;
  String? token;
  UserBankingModel? userData;

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
  double? amount;

  UserBankingModel.fromJason(Map<String,dynamic>json)
  {
    name=json['name'];
    amount=json['amount'];
    id=json['id'];
  }

}