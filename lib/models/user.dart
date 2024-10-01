import 'dart:convert';

import 'package:dinde_market/models/district.dart';

class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final District region;
  final String address;
  final String? token;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.region,
    required this.address,
    required this.username,
    this.token
  });

  // The copyWith method to update specific fields
  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    District? region,
    String? username,
    String? addresss
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      region: region ?? this.region,
      username: username ?? this.username,
      address: addresss ?? this.address,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      region: json['region'],
      address: json['address'],
      token: json['token']
    );
  }

  // Convert a JSON string back to User
  factory User.fromJsonString(String jsonString) {
    return User.fromJson(jsonDecode(jsonString));
  }
}
