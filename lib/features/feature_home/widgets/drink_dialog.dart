import 'package:flutter/material.dart';
import 'package:water_tracker_app/features/feature_home/models/drink_model.dart';
import 'package:water_tracker_app/features/feature_home/widgets/drink_selection_button.dart';

import 'drink_amount_input.dart';

class DrinkDialog extends StatefulWidget {
  const DrinkDialog({Key? key}) : super(key: key);

  @override
  State<DrinkDialog> createState() => _DrinkDialogState();
}

class _DrinkDialogState extends State<DrinkDialog> {
  String selectedDrink = 'Water';
  int drinkAmount = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.only(left: 16, top: 16),
        child: Text('Add a drink'),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What did you drink?',
              style: TextStyle(color: Colors.black87),
            ),
            DrinkSelectionButton(
              onChanged: (drink) {
                setState(() {
                  selectedDrink = drink!;
                });
              },
              drink: selectedDrink,
            ),
            DrinkAmountInput(
              onChanged: (amount) {
                setState(() {
                  drinkAmount = int.parse(amount.isEmpty ? '0' : amount);
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          key: const Key('drink_dialog_cancel_button'),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          key: const Key('drink_dialog_add_button'),
          onPressed: () {
            Navigator.of(context).pop(
              DrinkModel(
                name: selectedDrink,
                amount: drinkAmount,
                timestamp: DateTime.now().toString(),
              ),
            );
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
