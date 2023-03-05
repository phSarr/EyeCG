// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vitals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vitals _$VitalsFromJson(Map<String, dynamic> json) => Vitals(
      json['heartRate'] as int,
      json['userID'] as String,
      json['bloodPressure'] as int,
      json['o2'] as int,
      json['sportsMode'] as bool,
    );

Map<String, dynamic> _$VitalsToJson(Vitals instance) => <String, dynamic>{
      'userID': instance.userID,
      'heartRate': instance.heartRate,
      'bloodPressure': instance.bloodPressure,
      'o2': instance.o2,
      'sportsMode': instance.sportsMode,
    };
