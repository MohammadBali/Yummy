
class RestaurantModel
{
  int? success;
  List<Restaurant?>? data=[];

  RestaurantModel.fromJson(Map<String,dynamic> json)
  {
    if(json['success']!=null)
      {
        success=json['success'];
      }

    json['data'].forEach((element)
    {
      data?.add(Restaurant.fromJson(element));
    });
  }
}


class Restaurant
{

  int? id;
  String? name;
  String? days;
  int? rating;
  String? photo;
  double? longitude;
  double? latitude;
  String? openingTime;
  String? closingTime;

  List<MenuModel?> menu=[];


  Restaurant.fromJson(Map<String,dynamic>json)
  {
    if(json['id']!=null)
    {
      id=json['id'];
    }

    if(json['days']!=null)
      {
        days=json['days'];
      }

    if(json['name']!=null)
    {
      name=json['name'];
    }

    if(json['rating']!=null)
    {
      rating=json['rating'];
    }

    if(json['photo']!=null)
    {
      photo=json['photo'];
    }

    if(json['longitude']!=null)
    {
      longitude=json['longitude'];
    }

    if(json['latitude']!=null)
    {
      latitude=json['latitude'];
    }

    if(json['opening_time']!=null)
    {
      openingTime=json['opening_time'];
    }

    if(json['closing_time']!=null)
    {
      closingTime=json['closing_time'];
    }
  }


  Restaurant.addMenu(List<MenuModel>items)
  {
    menu=items;
  }

}


class MenuModel
{
  String? name;
  int? id;

  MenuModel.addMenuValues(String n, int i)
  {
    name=n;
    id=i;
  }
}