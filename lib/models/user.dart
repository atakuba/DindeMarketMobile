class User {
  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String region;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.region,
  });

  // The copyWith method to update specific fields
  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? region,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      region: region ?? this.region,
    );
  }
}
