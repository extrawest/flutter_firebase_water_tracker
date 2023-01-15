import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tracker_app/features/feature_home/bloc/home_bloc.dart';
import 'package:water_tracker_app/features/feature_home/bloc/home_state.dart';
import 'package:water_tracker_app/features/feature_home/widgets/calendar_bar.dart';

import '../bloc/home_event.dart';
import '../repositories/home_repository.dart';
import '../widgets/bottom_app_bar.dart';
import '../widgets/water_tracker_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(
        RepositoryProvider.of<HomeRepositoryImpl>(context),
      )
        ..add(FetchRemoteConfigEvent())
        ..add(HomeInitUserEvent())
        ..add(HomeInitDrinksEvent())
        ..add(HandleDynamicLinkEvent(
            (intake) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You drank $intake ml'),
                    duration: const Duration(seconds: 2),
                  ),
                ))),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),
                    const CalendarBar(),
                    const SizedBox(height: 24),
                    if (state.status == HomeStatus.loading ||
                        state.status == HomeStatus.initial)
                      const Expanded(
                          child: Center(child: CircularProgressIndicator()))
                    else
                      const WaterTrackerView(),
                    const SizedBox(height: 24),
                    const BottomApplicationBar(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
