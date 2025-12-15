// lib/core/api_client/endpoints/wger_api_endpoints.dart

class WgerApiEndpoints {
  // Base URL for the Wger API. You will need to define this in your HttpClient.
  // const String BASE_URL = 'https://wger.de/api/v2';

  // --- 1. Workout/Exercise Data Endpoints ---

  /// GET /api/v2/exercisecategory/
  /// Used to fetch the list of workout categories (e.g., 'Yoga', 'Cardio').
  /// This helps populate the horizontal scrollbar on the "My Training Plan" screen.
  static const String exerciseCategories = '/exercisecategory/';

  /// GET /api/v2/exercise/
  /// Used to fetch a list of all exercises. Can be filtered by category ID (e.g., ?category=3).
  static const String exercises = '/exercise/';

  /// GET /api/v2/exercise/{id}/
  /// Used to fetch detailed information about a single exercise by its ID.
  /// This response will contain links to associated images.
  static String exerciseDetail(int id) => '/exercise/$id/';

  /// GET /api/v2/exerciseimage/
  /// Used to fetch a list of all exercise images.
  /// You might use this if you want to preload or search images separately, but the detail endpoint is usually sufficient.
  static const String exerciseImages = '/exerciseimage/';

  /// GET /api/v2/equipment/
  /// Used to fetch the list of necessary equipment (e.g., 'Dumbbell', 'Barbell', 'None').
  /// Useful for filtering.
  static const String equipment = '/equipment/';

  /// GET /api/v2/exercise-translation/
  /// Provides translations for exercise names and descriptions.
  static const String exerciseTranslations = '/exercise-translation/';

  // --- 2. Meal/Nutrition Data Endpoints ---

  /// GET /api/v2/meal/
  /// Used to fetch a list of all meals or meal plans.
  static const String meals = '/meal/';

  /// GET /api/v2/meal/{id}/
  /// Used to fetch detailed information about a single meal/meal plan.
  static String mealDetail(int id) => '/meal/$id/';

  /// GET /api/v2/meal/{id}/nutritional_values/
  /// Used to get the nutrition breakdown for a specific meal.
  static String mealNutritionalValues(int id) =>
      '/meal/$id/nutritional_values/';

  /// GET /api/v2/mealitem/
  /// Used to fetch items within a meal (e.g., specific ingredients or recipes).
  static const String mealItems = '/mealitem/';

  /// GET /api/v2/ingredient/
  /// Used to fetch a list of raw ingredients for building recipes or tracking.
  static const String ingredients = '/ingredient/';

  /// GET /api/v2/ingredient-image/
  /// Used to fetch images for ingredients.
  static const String ingredientImages = '/ingredient-image/';
}
