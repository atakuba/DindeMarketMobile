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
}
