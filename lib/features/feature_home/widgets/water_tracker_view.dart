import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/routes.dart';
import '../bloc/home_bloc.dart';

class WaterTrackerView extends StatelessWidget {
  const WaterTrackerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: const Key('water_tracker_view'),
      child: Navigator(
        key: context.read<HomeBloc>().navigatorKey,
        onGenerateRoute: onGenerateRouteNested,
      ),
    );
  }
}
