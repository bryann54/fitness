// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealModel _$MealModelFromJson(Map<String, dynamic> json) => MealModel(
      id: json['id'] as String,
      category: json['category'] as String,
      uiTitle: json['uiTitle'] as String,
      dietTag: json['dietTag'] as String,
      imageUrl: json['imageUrl'] as String,
      howToPrepare: json['howToPrepare'] as String,
      loseWeightPortion: json['loseWeightPortion'] as String,
      gainMusclePortion: json['gainMusclePortion'] as String,
      caloriesLoseWeight: (json['caloriesLoseWeight'] as num).toInt(),
      caloriesGainMuscle: (json['caloriesGainMuscle'] as num).toInt(),
      proteinLoseWeight: (json['proteinLoseWeight'] as num).toInt(),
      proteinGainMuscle: (json['proteinGainMuscle'] as num).toInt(),
      isKeto: json['isKeto'] as bool,
      isVegan: json['isVegan'] as bool,
      isTraditional: json['isTraditional'] as bool,
    );

Map<String, dynamic> _$MealModelToJson(MealModel instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'uiTitle': instance.uiTitle,
      'dietTag': instance.dietTag,
      'imageUrl': instance.imageUrl,
      'howToPrepare': instance.howToPrepare,
      'loseWeightPortion': instance.loseWeightPortion,
      'gainMusclePortion': instance.gainMusclePortion,
      'caloriesLoseWeight': instance.caloriesLoseWeight,
      'caloriesGainMuscle': instance.caloriesGainMuscle,
      'proteinLoseWeight': instance.proteinLoseWeight,
      'proteinGainMuscle': instance.proteinGainMuscle,
      'isKeto': instance.isKeto,
      'isVegan': instance.isVegan,
      'isTraditional': instance.isTraditional,
    };
