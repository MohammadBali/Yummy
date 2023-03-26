class UserModel
{
  User? result;

  UserModel.fromJson(Map<String,dynamic>json)
  {
    if(json['result'] !=null)
      {
        result=User.fromJson(json['result']);
      }
  }
}


class User
{

  int? id;
  String? name;
  String? photo;
  String? number;
  String? location;
  double? longitude;
  double? latitude;

  User.fromJson(Map<String,dynamic>json)
  {
    if(json['name']!=null)
    {
      name=json['name'];
    }

    if(json['photo']!=null)
    {
      photo=json['photo'];
    }

    if(json['id']!=null)
    {
      id=json['id'];
    }

    if(json['number']!=null)
    {
      number=json['number'];
    }

    if(json['location']!=null)
    {
      location=json['location'];
    }

    if(json['longitude']!=null)
    {
      longitude=json['longitude'];
    }

    if(json['latitude']!=null)
    {
      latitude=json['latitude'];
    }
  }
}