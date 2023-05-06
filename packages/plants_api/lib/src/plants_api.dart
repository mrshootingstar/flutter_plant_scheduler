import '../plants_api.dart';

abstract class PlantsApi {
  /// {@macro todos_api}
  const PlantsApi();

  /// Provides a [Stream] of all todos.
  Stream<List<Plant>> getPlants();

  /// Saves a [todo].
  ///
  /// If a [todo] with the same id already exists, it will be replaced.
  Future<void> savePlant(Plant plant);

  /// Deletes the todo with the given id.
  ///
  /// If no todo with the given id exists, a [TodoNotFoundException] error is
  /// thrown.
  Future<void> deletePlant(String id);

  /// Deletes all completed todos.
  ///
  /// Returns the number of deleted todos.
  Future<int> clearCompleted();

  /// Sets the `isCompleted` state of all todos to the given value.
  ///
  /// Returns the number of updated todos.
  Future<int> completeAll({required bool isCompleted});
}

/// Error thrown when a [Todo] with a given id is not found.
class PlantNotFoundException implements Exception {}
