class PaymentModel {
  int? id;
  String name;
  String acronym;
  bool enabled;
  PaymentModel({
    required this.id,
    required this.name,
    required this.acronym,
    required this.enabled,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'acronym': acronym,
      'enabled': enabled,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      acronym: map['acronym'] ?? '',
      enabled: map['enabled'] ?? false,
    );
  }

  PaymentModel copyWith({
    int? id,
    String? name,
    String? acronym,
    bool? enabled,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      acronym: acronym ?? this.acronym,
      enabled: enabled ?? this.enabled,
    );
  }
}
