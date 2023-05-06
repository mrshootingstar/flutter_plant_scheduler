import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:plantly/app/app.dart';
import 'package:plantly/app/app_bloc_observer.dart';
import 'package:plants_api/plants_api.dart';
import 'package:plants_repository/plants_repository.dart';

void bootstrap({required PlantsApi plantsApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final plantsRepository = PlantsRepository(plantsApi: plantsApi);

  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          App(plantsRepository: plantsRepository),
        ),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
