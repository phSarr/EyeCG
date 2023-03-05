import 'dart:core';
import 'package:eyecg/data/model/user_data.dart';
import 'package:eyecg/data/web_services/web_services.dart';
import 'package:retrofit/retrofit.dart';
/*
class UserRepo{
  final WebServices webServices;
  UserRepo(this.webServices);


  Future<UserData> getUserStatusData(int userID)async{
    return await webServices.getUserStatusData(userID); //TODO to be changed to parse 1 user's data
  };

  Future<UserData> sendUserData(UserData userData)async{
    return await webServices.sendUserData(userData, 'Bearer afg65747afgfa7a657afgafa765') ; // search on how to encrypt the token
  };

  Future<HttpResponse> deleteUserData(int userID)async{
    return await webServices.deleteUserData(userID, 'Bearer afg65747afgfa7a657afgafa765');
  };


  //Future<UserData> editUserData()async{};

}
*/