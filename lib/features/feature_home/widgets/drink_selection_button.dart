import 'package:flutter/material.dart';

final _drinks = [
  'Water',
  'Tea',
  'Coffee',
  'Juice',
  'Milk',
  'Beer',
  'Wine',
  'Soda',
];

class DrinkSelectionButton extends StatelessWidget {
  final void Function(String?) onChanged;
  final String drink;

  const DrinkSelectionButton({
    required this.drink,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      key: const Key('drink_selection_button'),
      borderRadius: BorderRadius.circular(12),
      menuMaxHeight: 300,
      value: drink,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black87),
      onChanged: onChanged,
      items: _drinks.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          key: Key(value),
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
