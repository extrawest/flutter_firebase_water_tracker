import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:water_tracker_app/common/routes.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class DailyGoalView extends StatelessWidget {
  const DailyGoalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.status == HomeStatus.success) {
                      return state.progressIndicatorType == 'linear'
                          ? _buildLinearProgressIndicator(context)
                          : _buildCircularProgressIndicator(context);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
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

  Widget _buildCircularProgressIndicator(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<HomeBloc>();
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
      percent: bloc.overallVolumePercentage,
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
            '${bloc.overallVolume.toInt()}',
            style: theme.textTheme.headline6,
          ),
          const SizedBox(height: 4),
          Text(
            'of ${bloc.state.user?.dailyGoal} ml',
            style: theme.textTheme.subtitle2,
          ),
        ],
      ),
    );
  }

  Widget _buildLinearProgressIndicator(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<HomeBloc>();
    return LinearPercentIndicator(
      lineHeight: 20,
      animation: true,
      animateFromLastPercent: true,
      backgroundColor: theme.colorScheme.background,
      linearGradient: LinearGradient(
        colors: [
          theme.colorScheme.primary,
          theme.colorScheme.secondary,
        ],
      ),
      percent: bloc.overallVolumePercentage,
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'done',
            style: theme.textTheme.subtitle2,
          ),
          const SizedBox(height: 4),
          Text(
            '${bloc.overallVolume.toInt()}',
            style: theme.textTheme.headline6,
          ),
        ],
      ),
      leading: Text(
        'of ${bloc.state.user?.dailyGoal} ml',
        style: theme.textTheme.subtitle2,
      ),
    );
  }
}
