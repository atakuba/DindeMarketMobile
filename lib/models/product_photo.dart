class ProductPhoto {
  final int id;
  final String url;

  ProductPhoto({required this.id, required this.url});

  factory ProductPhoto.fromJson(Map<String, dynamic> json) {
    return ProductPhoto(
      id: json['id'],
      url: json['url'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
    };
  }
}