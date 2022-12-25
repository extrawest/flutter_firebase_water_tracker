class Drink {
  final String name;
  final int amount;
  final String timestamp;

  Drink({
    required this.name,
    required this.amount,
    required this.timestamp,
  });

  Drink.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        amount = map['amount'],
        timestamp = map['timestamp'];
}