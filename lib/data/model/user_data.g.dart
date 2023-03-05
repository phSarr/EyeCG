// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      json['name'] as String,
      json['userID'] as String,
      json['phoneNumber'] as String,
      json['mail'] as String,
      json['password'] as String,
      (json['emergencyContact'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList())
          .toList(),
      (json['diseases'] as List<dynamic>).map((e) => e as String).toList(),
      json['userStatus'] as String,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'name': instance.name,
      'userID': instance.userID,
      'phoneNumber': instance.phoneNumber,
      'mail': instance.mail,
      'password': instance.password,
      'userStatus': instance.userStatus,
      'emergencyContact': instance.emergencyContact,
      'diseases': instance.diseases,
    };
