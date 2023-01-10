import 'package:flutter/material.dart';

import '../models/drink_model.dart';

class DrinksList extends StatelessWidget {
  final List<DrinkModel> drinks;

  const DrinksList({
    required this.drinks,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: drinks.length,
        itemBuilder: (context, index) {
          final drink = drinks[index];
          return ListTile(
            key: Key('drink_$index'),
            title: Text(
              drink.name,
              style: theme.textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
              ),
            ),
            subtitle: Text(
              drink.timestamp.split('.')[0],
              style: theme.textTheme.subtitle2,
            ),
            trailing: Text(
              '${drink.amount} ml',
              style: theme.textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
              ),
            ),
          );
        },
      ),
    );
  }
}
