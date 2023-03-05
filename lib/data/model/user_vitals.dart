import 'package:json_annotation/json_annotation.dart';
part 'user_vitals.g.dart';

@JsonSerializable()
class Vitals{
  late String userID;
  late int heartRate;
  late int bloodPressure;
  late int o2;
  late bool sportsMode;

  Vitals(this.heartRate, this.userID, this.bloodPressure, this.o2, this.sportsMode);

  factory Vitals.fromJson(Map<String, dynamic> json) => _$VitalsFromJson(json);

  Map<String, dynamic> toJson() => _$VitalsToJson(this);

}


