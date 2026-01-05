// lib/features/meals/data/models/meal_model.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_model.g.dart';

@JsonSerializable()
class MealModel extends Equatable {
  final String id;
  final String category;
  final String uiTitle;
  final String dietTag;
  final String imageUrl;
  final String howToPrepare;
  final String loseWeightPortion;
  final String gainMusclePortion;
  final int caloriesLoseWeight;
  final int caloriesGainMuscle;
  final int proteinLoseWeight;
  final int proteinGainMuscle;
  final bool isKeto;
  final bool isVegan;
  final bool isTraditional;

  const MealModel({
    required this.id,
    required this.category,
    required this.uiTitle,
    required this.dietTag,
    required this.imageUrl,
    required this.howToPrepare,
    required this.loseWeightPortion,
    required this.gainMusclePortion,
    required this.caloriesLoseWeight,
    required this.caloriesGainMuscle,
    required this.proteinLoseWeight,
    required this.proteinGainMuscle,
    required this.isKeto,
    required this.isVegan,
    required this.isTraditional,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) =>
      _$MealModelFromJson(json);
  Map<String, dynamic> toJson() => _$MealModelToJson(this);

  @override
  List<Object?> get props => [id, uiTitle, category];
}
