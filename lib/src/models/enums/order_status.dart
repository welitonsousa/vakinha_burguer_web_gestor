import 'package:flutter/material.dart';

enum EnumOrderStatus {
  pendente('Pendente', 'P', Colors.lime),
  finalizado('Finalizado', 'R', Colors.green),
  confirmado('Confirmado', 'C', Colors.blue),
  cancelado('Cancelado', 'D', Colors.red);

  final String name;
  final String acronym;
  final Color color;
  const EnumOrderStatus(this.name, this.acronym, this.color);

  static EnumOrderStatus fromAcronym(String acronym) {
    return EnumOrderStatus.values.firstWhere((e) => e.acronym == acronym);
  }
}
