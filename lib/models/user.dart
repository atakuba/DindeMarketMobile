import 'dart:convert';

import 'package:dinde_market/models/district.dart';

class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final District? region;
  final String? district;
  final String? address;
  final String? token;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.region,
    required this.address,
    required this.username,
    this.token,
    this.district,
  });

  // The copyWith method to update specific fields
  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    District? region,
    String? username,
    String? addresss,
    String? district,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      region: region ?? this.region,
      username: username ?? this.username,
      address: addresss ?? this.address,
      district: district ?? this.district,
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
      district: json['district'],
      address: json['address'],
      token: json['token']
    );
  }

  // Convert a JSON string back to User
  factory User.fromJsonString(String jsonString) {
    return User.fromJson(jsonDecode(jsonString));
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phoneNumber: map['phoneNumber'],
      district: map['district'],
      address: map['address'],
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'district': district,
      'address': address,
    };
  }
}
