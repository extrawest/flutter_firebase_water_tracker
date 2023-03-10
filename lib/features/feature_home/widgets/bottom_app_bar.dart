import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tracker_app/common/routes.dart';
import 'package:water_tracker_app/features/feature_home/bloc/home_bloc.dart';
import 'package:water_tracker_app/features/feature_home/models/drink_model.dart';
import 'package:water_tracker_app/features/feature_home/widgets/drink_dialog.dart';

import '../bloc/home_event.dart';

class BottomApplicationBar extends StatelessWidget {
  const BottomApplicationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.stacked_bar_chart,
                      size: 32,
                      color: theme.colorScheme.secondary,
                    ),
                    Text(
                      'Statistics',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                key: const Key('account_button'),
                onPressed: () {
                  Navigator.of(context).pushNamed(accountScreenRoute);
                },
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.account_circle_rounded,
                      size: 32,
                      color: theme.colorScheme.secondary,
                    ),
                    Text(
                      'Account',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.secondary,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.secondary.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            key: const Key('add_drink_button'),
            iconSize: 64,
            onPressed: () async {
              showDialog<DrinkModel>(
                context: context,
                builder: (context) => const DrinkDialog()
              ).then((drink) {
                if (drink != null) {
                  BlocProvider.of<HomeBloc>(context).add(HomeEventAddDrink(drink));
                }
              });
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(14),
              ),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(24),
                  ),
                ),
              ),
            ),
            icon: const Icon(
              Icons.add_rounded,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
