import 'dart:convert'; // use jsonEncode() or jsonDecode()
import 'package:json_annotation/json_annotation.dart';
part 'user_data.g.dart';

@JsonSerializable()
class UserData{
  late String name;
  late String userID;
  late String phoneNumber;
  late String mail;
  late String password;
  late String userStatus;
  late List<List<Map>> emergencyContact;
  late List<String> diseases;

  UserData(this.name, this.userID, this.phoneNumber, this.mail, this.password, this.emergencyContact, this.diseases, this.userStatus);

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

}

//TODO needs to be tested and matched with API
