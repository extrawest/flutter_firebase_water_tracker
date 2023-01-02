import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:water_tracker_app/common/routes.dart';

import '../bloc/home_bloc.dart';

class DailyGoalView extends StatelessWidget {
  const DailyGoalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Container(
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                StreamBuilder(
                  stream: context.read<HomeBloc>().userStream,
                  builder: (context, snapshot) {
                    return StreamBuilder(
                      stream: context.read<HomeBloc>().drinksStream,
                      builder: (context, drinkSnapshot) {
                        final overallVolume = context
                            .read<HomeBloc>()
                            .calculateOverallVolume(drinkSnapshot.data?.toList() ?? []);
                        if(snapshot.hasData) {
                          return CircularPercentIndicator(
                            animation: true,
                            animateFromLastPercent: true,
                            radius: MediaQuery.of(context).size.width * 0.35,
                            lineWidth: 50.0,
                            backgroundColor: theme.colorScheme.background,
                            rotateLinearGradient: true,
                            linearGradient: LinearGradient(
                              colors: [
                                theme.colorScheme.primary,
                                theme.colorScheme.secondary,
                              ],
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            percent: context
                                .read<HomeBloc>()
                                .calculateProgress(
                              overallVolume,
                              snapshot.data!['daily_goal'],
                            )
                                .toDouble(),
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'done',
                                  style: theme.textTheme.subtitle2,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$overallVolume',
                                  style: theme.textTheme.headline6,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'of ${snapshot.data?['daily_goal']} ml',
                                  style: theme.textTheme.subtitle2,
                                ),
                              ],
                            ),
                          );
                        }
                        else {
                          return const CircularProgressIndicator();
                        }
                      },
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(drinksListScreenRoute);
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.blueGrey),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Todays drinks'),
                      Icon(Icons.arrow_right)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}