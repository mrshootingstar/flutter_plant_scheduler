import 'package:flutter/widgets.dart';
import 'package:local_storage_plants_api/local_storage_plants_api.dart';
import 'package:plantly/bootstrap.dart';
import 'package:plants_api/plants_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final PlantsApi plantsApi = LocalStoragePlantsApi(
    plugin: await SharedPreferences.getInstance(),
  );

  bootstrap(plantsApi: plantsApi);
}
