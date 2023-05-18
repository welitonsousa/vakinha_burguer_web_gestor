class OrderProductModel {
  final int id;
  final int amount;
  final double totalPrice;

  OrderProductModel(
      {required this.id, required this.amount, required this.totalPrice});

  factory OrderProductModel.fromMap(Map<String, dynamic> map) {
    return OrderProductModel(
      id: map['id']?.toInt() ?? 0,
      amount: map['amount']?.toInt() ?? 0,
      totalPrice: map['total_price']?.toDouble() ?? 0.0,
    );
  }
}
