import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DrinkAmountInput extends StatelessWidget {
  final void Function(String) onChanged;

  const DrinkAmountInput({required this.onChanged, Key? key,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('drink_amount_input'),
      style: const TextStyle(color: Colors.black87),
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        hintText: 'Enter an amount',
      ),
    );
  }
}
