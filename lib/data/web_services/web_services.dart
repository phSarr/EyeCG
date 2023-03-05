import 'package:dio/dio.dart';
import 'package:eyecg/data/model/user_data.dart';
import 'package:retrofit/retrofit.dart';
part 'web_services.g.dart';

@RestApi(baseUrl: "https://gorest.co.in/public/v2/")  // TODO to be changed (base url for backend api) maybe save in const class
abstract class WebServices{
  factory WebServices(Dio dio, {String baseUrl}) = _WebServices;
  @GET('users/{id}') //TODO edit paths/endpoints to get health condition from API/AI model and verify Json format (list of Obj)
  Future<UserData> getUserStatusData(@Path() int userID); //if backed userID is named differently, change to ... @Path('BackEndUserID') int userID);
  @POST('users/')
  Future<UserData> sendUserData(@Body() UserData newUser, @Header('Authorization') String token);
  @DELETE('users/{id}')
  Future<HttpResponse> deleteUserData(@Path() int userID, @Header('Authorization') String token);
  @PATCH('users/{id}')
  Future<UserData> editUserData(@Path() int userID);
}

/*
class RegistrationWebServices{
  late Dio dio;
  RegistrationWebServices(){
  BaseOptions options=BaseOptions(
    baseUrl: baseURL,
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
  );
  dio = Dio(options);
  }
  Future<dynamic> sendUserData()async{
    try{
      Response response = await dio.post('/users', data: jsonEncode(User_Data) );
      return response.statusCode;  //TODO take action in registration phase according to status code, implement logic to check status/exception + create Repo class for response if needed
    }catch(e){
      return e.toString();
    }
  }

}
*/