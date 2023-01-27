class DrinkModel {
  final String name;
  final int amount;
  final String timestamp;

  const DrinkModel({
    required this.name,
    required this.amount,
    required this.timestamp,
  });

  factory DrinkModel.fromJson(Map<String, dynamic> json) => DrinkModel(
    name: json['name'],
    amount: json['amount'],
    timestamp: json['timestamp'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'amount': amount,
    'timestamp': timestamp,
  };
}