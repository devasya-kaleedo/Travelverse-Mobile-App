// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApp _$UserAppFromJson(Map<String, dynamic> json) => UserApp(
      id: (json['id'] as num?)?.toInt() ?? 0,
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      apiToken: json['apiToken'] as String? ?? '',
      first_name: json['first_name'] as String? ?? '',
      last_name: json['last_name'] as String? ?? '',
    );

Map<String, dynamic> _$UserAppToJson(UserApp instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'apiToken': instance.apiToken,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
    };
