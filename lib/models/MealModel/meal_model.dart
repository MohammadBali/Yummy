class MealModel
{
  int? success;
  List<Meal>? data=[];

  MealModel.fromJson(Map<String,dynamic>json)
  {
    if(json['success']!=null)
      {
        success=json['success'];
      }

    if(json['data']!=null)
      {
        json['data'].forEach((element)
        {
          data?.add(Meal.fromJson(element));
        });
      }

  }
}

class Meal
{

  int? id;
  int? restaurantId;
  dynamic price;
  String? name;
  String? ingredients;
  String? photo;
  int? count;
  String? restaurantName;
  dynamic discount;

  int quantity=0; //Quantity of this item to be sent in order.

  Meal()
  {
    quantity=0;
  }

  Meal.fromJson(Map<String,dynamic>json)
  {
    if(json['id'] !=null)
    {
      id=json['id'];
    }

    if(json['restaurant_id'] !=null)
    {
      restaurantId=json['restaurant_id'];
    }

    if(json['price'] !=null)
    {
      price=json['price'];
    }

    if(json['name'] !=null)
    {
      name=json['name'];
    }

    if(json['ingredients'] !=null)
    {
      ingredients=json['ingredients'];
    }

    if(json['photo'] !=null)
    {
      photo=json['photo'];
    }

    if(json['count'] !=null)
    {
      count=json['count'];
    }

    if(json['rest_name'] !=null)
    {
      restaurantName=json['rest_name'];
    }

    if(json['discount'] !=null)
    {
      discount=json['discount'];
    }
  }
}