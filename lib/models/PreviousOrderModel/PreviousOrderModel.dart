import 'package:intl/intl.dart';

class PreviousOrderModel
{
  int? success;
  String? message;
  List<OrderData?> data=[];

  PreviousOrderModel.fromJson(Map<String,dynamic>json)
  {
    success=json['success'];
    message=json['message'];
    json['data'].forEach((value)
    {
      data.add(OrderData.fromJson(value));
    });
  }
}


class OrderData
{
  int? id;
  int? userId;
  int? resId;
  int? capId;
  String? purchaseDate;
  dynamic totalCost;
  String? paymentMethod;
  String? status;

  OrderData.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    userId=json['user_id'];
    resId=json['res_id'];
    capId=json['captin_Id'];
    purchaseDate=DateFormat('yMMMMd').format(DateTime.parse(json['purchase_date']));
    totalCost=json['total_cost'];
    paymentMethod=json['payment_method'];
    status=json['status'];

  }
}