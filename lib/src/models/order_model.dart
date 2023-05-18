import 'package:dw10/src/models/enums/order_status.dart';

import 'order_product_model.dart';

class OrderModel {
  final int id;
  final int userId;
  final DateTime date;
  final EnumOrderStatus status;
  final List<OrderProductModel> products;
  final String address;
  final int cpf;
  final int paymentMethodId;

  OrderModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.status,
    required this.products,
    required this.address,
    required this.cpf,
    required this.paymentMethodId,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id']?.toInt() ?? 0,
      userId: map['user_id']?.toInt() ?? 0,
      date: DateTime.parse(map['date']),
      status: EnumOrderStatus.fromAcronym(map['status']),
      products: List<OrderProductModel>.from(
          map['products']?.map((x) => OrderProductModel.fromMap(x))),
      address: map['address'] ?? '',
      cpf: map['cpf']?.toInt() ?? 0,
      paymentMethodId: map['payment_method_id']?.toInt() ?? 0,
    );
  }

  OrderModel copyWith({
    int? id,
    int? userId,
    DateTime? date,
    EnumOrderStatus? status,
    List<OrderProductModel>? products,
    String? address,
    int? cpf,
    int? paymentMethodId,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      status: status ?? this.status,
      products: products ?? this.products,
      address: address ?? this.address,
      cpf: cpf ?? this.cpf,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
    );
  }
}
