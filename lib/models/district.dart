class District {
  int id;
  String name;
  double priceDelivery;

  District({
    required this.id,
    required this.name,
    required this.priceDelivery,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'],
      name: json['name'],
      priceDelivery: json['priceDelivery'].toDouble(), // Ensure it's a double
    );
  }

   factory District.fromMap(Map<String, dynamic> map) {
    return District(
      id: map['id'],
      name: map['name'],
      priceDelivery: map['priceDelivery'].toDouble(), // Ensure it's a double
    );
  }

  // Convert a District object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'priceDelivery': priceDelivery,
    };
  }
}
