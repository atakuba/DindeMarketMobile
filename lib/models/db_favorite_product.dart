class DbFavoriteProduct {
  final int id;
  final bool favorite;

  DbFavoriteProduct({required this.id, required this.favorite});

  factory DbFavoriteProduct.fromFavoriteMap(Map<String, dynamic> map) {
    return DbFavoriteProduct(
      id: map['id'],
      favorite: map['favorite'] == 1,
    );
  }
}