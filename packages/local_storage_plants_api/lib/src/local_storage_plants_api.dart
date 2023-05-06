import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:plants_api/plants_api.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template local_storage_todos_api}
/// A Flutter implementation of the [PlantsApi] that uses local storage.
/// {@endtemplate}
class LocalStoragePlantsApi extends PlantsApi {
  /// {@macro local_storage_todos_api}
  LocalStoragePlantsApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _plantStreamController = BehaviorSubject<List<Plant>>.seeded(const []);

  /// The key used for storing the todos locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kPlantsCollectionKey = '__plants_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final plantsJson = _getValue(kPlantsCollectionKey);
    if (plantsJson != null) {
      final plants = List<Map<dynamic, dynamic>>.from(
        json.decode(plantsJson) as List,
      )
          .map((jsonMap) => Plant.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _plantStreamController.add(plants);
    } else {
      _plantStreamController.add(const []);
    }
  }

  @override
  Stream<List<Plant>> getPlants() => _plantStreamController.asBroadcastStream();

  @override
  Future<void> savePlant(Plant plant) {
    final plants = [..._plantStreamController.value];
    final plantIndex = plants.indexWhere((t) => t.id == plant.id);
    if (plantIndex >= 0) {
      plants[plantIndex] = plant;
    } else {
      plants.add(plant);
    }

    _plantStreamController.add(plants);
    return _setValue(kPlantsCollectionKey, json.encode(plants));
  }

  @override
  Future<void> deletePlant(String id) async {
    final plants = [..._plantStreamController.value];
    final plantIndex = plants.indexWhere((t) => t.id == id);
    if (plantIndex == -1) {
      throw PlantNotFoundException();
    } else {
      plants.removeAt(plantIndex);
      _plantStreamController.add(plants);
      return _setValue(kPlantsCollectionKey, json.encode(plants));
    }
  }

  @override
  Future<int> clearCompleted() async {
    final plants = [..._plantStreamController.value];
    final completedTodosAmount = plants.where((t) => t.isCompleted).length;
    plants.removeWhere((t) => t.isCompleted);
    _plantStreamController.add(plants);
    await _setValue(kPlantsCollectionKey, json.encode(plants));
    return completedTodosAmount;
  }

  @override
  Future<int> completeAll({required bool isCompleted}) async {
    final plants = [..._plantStreamController.value];
    final changedTodosAmount =
        plants.where((t) => t.isCompleted != isCompleted).length;
    final newPlants = [
      for (final plant in plants) plant.copyWith(isCompleted: isCompleted)
    ];
    _plantStreamController.add(newPlants);
    await _setValue(kPlantsCollectionKey, json.encode(newPlants));
    return changedTodosAmount;
  }
}
