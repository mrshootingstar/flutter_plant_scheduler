import 'package:plants_api/plants_api.dart';

/// {@template todos_repository}
/// A repository that handles todo related requests.
/// {@endtemplate}
class PlantsRepository {
  /// {@macro todos_repository}
  const PlantsRepository({
    required PlantsApi plantsApi,
  }) : _plantsApi = plantsApi;

  final PlantsApi _plantsApi;

  /// Provides a [Stream] of all todos.
  Stream<List<Plant>> getTodos() => _plantsApi.getPlants();

  /// Saves a [todo].
  ///
  /// If a [todo] with the same id already exists, it will be replaced.
  Future<void> saveTodo(Plant plant) => _plantsApi.savePlant(plant);

  /// Deletes the todo with the given id.
  ///
  /// If no todo with the given id exists, a [TodoNotFoundException] error is
  /// thrown.
  Future<void> deleteTodo(String id) => _plantsApi.deletePlant(id);

  /// Deletes all completed todos.
  ///
  /// Returns the number of deleted todos.
  Future<int> clearCompleted() => _plantsApi.clearCompleted();

  /// Sets the `isCompleted` state of all todos to the given value.
  ///
  /// Returns the number of updated todos.
  Future<int> completeAll({required bool isCompleted}) =>
      _plantsApi.completeAll(isCompleted: isCompleted);
}
