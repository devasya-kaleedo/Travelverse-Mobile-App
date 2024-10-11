import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserApp {
  final int id;
  final String username;
  final String email;
  final String apiToken;
  final String first_name;
  final String last_name;

  const UserApp({
    this.id = 0,
    this.username = '',
    this.email = '',
    this.apiToken = '',
    this.first_name = '',
    this.last_name = '',
  });

  // From JSON
  factory UserApp.fromJson(Map<String, dynamic> json) =>
      _$UserAppFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$UserAppToJson(this);
}
