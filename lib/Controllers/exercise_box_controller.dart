import 'package:get/get.dart';
import 'package:gym_app/Model/Exercise.dart';
import 'package:gym_app/Model/Set.dart';
import 'package:gym_app/Model/app_database.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Assuming you're using Supabase

class ExerciseController extends GetxController {


  var exercises = <TestExercise>[].obs;

  // Method to add a set to a specific exercise
  void addSetToExercise(TestExercise exercise, TestSet newSet) {
    exercise.sets.add(newSet);  // Add the new set to the exercise
    update();  // Notify listeners to rebuild
  }

  // Optionally, fetch the exercises from Supabase if not already fetched
  Future<void> fetchExercises() async {
    // Fetch your exercises, either from Supabase or local DB
    // Example: exercises.value = await fetchFromDatabase();
    update();  // Notify listeners to rebuild
  }





  // Add new set to the exercise and update the database
  Future<void> addSetToExercise2(
      String exerciseId, int reps, double weight) async {
    
      // Add the set to the database (Supabase example)
      final response = await Supabase.instance.client
          .from('sets') // The 'sets' table in your database
          .insert({
        'exercise_id': exerciseId,
        'reps': reps,
        'weight': weight,
      });

      if (response.error != null) {
        throw response.error!;
      }

      // After adding the set, fetch the updated sets for that exercise
    //   await fetchSetsForExercise(exerciseId);
    // } catch (e) {
    //   print("Error adding set: $e");
    
    update();
  }

  deleteExercise(TestExercise thisExercise) {
    ExerciseDatabase().deleteExercise(thisExercise);
    update();
  }

  // Fetch the sets for a given exercise from the database
  // Future<void> fetchSetsForExercise(String exerciseId) async {
  //   try {
  //     final response = await Supabase.instance.client
  //         .from('sets')
  //         .select()
  //         .eq('exercise_id', exerciseId);

  //     // Assuming the data is a List of sets, map it to your exercise's sets
  //     final List<dynamic> fetchedData = response;
  //     // final fetchedSets =
  //     //     fetchedData.map((setData) => TestSet.fromJson(setData)).toList();

  //     // Update the exercise's sets
  //     // exercises[exerciseId]?.sets.value = fetchedSets;
  //   } catch (e) {
  //     print("Error fetching sets for exercise: $e");
  //   }
  // }
}
