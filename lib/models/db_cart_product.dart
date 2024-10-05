class DbCartProduct {
  final int id;
  final int amount;

  DbCartProduct({required this.id, required this.amount});

  factory DbCartProduct.fromCartMap(Map<String, dynamic> map) {
    return DbCartProduct(
      id: map['id'],
      amount: map['amount'] = 0,
    );
  }
}