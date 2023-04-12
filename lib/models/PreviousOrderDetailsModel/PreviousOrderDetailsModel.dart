class PreviousOrderDetailsModel
{
  int? success;
  String? message;
  List<PreviousOrderData?> data=[];

  PreviousOrderDetailsModel.fromJson(Map<String,dynamic>json)
  {
    success=json['success'];
    message=json['message'];
    json['data'].forEach((element)
    {
      data.add(PreviousOrderData.fromJson(element));
    });
  }
}


class PreviousOrderData
{
  int? id;
  String? name;
  dynamic price;
  int? quantity;

  PreviousOrderData.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    name=json['name'];
    price=json['price'];
    quantity=json['quantity'];
  }
}