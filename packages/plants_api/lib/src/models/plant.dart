import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import 'json_map.dart';

part 'plant.g.dart';

/// {@template plant}
/// A single plant item.
///
/// Contains a [title], [description] and [id], in addition to a [isCompleted]
/// flag.
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [plant]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Plant extends Equatable {
  /// {@macro plant}
  Plant({
    String? id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the plant.
  ///
  /// Cannot be empty.
  final String id;

  /// The title of the plant.
  ///
  /// Note that the title may be empty.
  final String title;

  /// The description of the plant.
  ///
  /// Defaults to an empty string.
  final String description;

  /// Whether the plant is completed.
  ///
  /// Defaults to `false`.
  final bool isCompleted;

  /// Returns a copy of this plant with the given values updated.
  ///
  /// {@macro plant}
  Plant copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Plant(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// Deserializes the given [JsonMap] into a [plant].
  static Plant fromJson(JsonMap json) => _$PlantFromJson(json);

  /// Converts this [plant] into a [JsonMap].
  JsonMap toJson() => _$PlantToJson(this);

  @override
  List<Object> get props => [id, title, description, isCompleted];
}
