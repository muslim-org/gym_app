import 'package:flutter_searchable_dropdown/flutter_searchable_dropdown.dart';
import 'package:gym_app/Controllers/exercise_box_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gym_app/Components/bottom_sheet_3.dart';
import 'package:gym_app/Components/exercise_card.dart';
import 'package:gym_app/Model/app_database.dart';
import 'package:gym_app/Model/Exercise.dart';
import 'package:gym_app/Model/Workout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key, required this.workout});

  final TestWorkout workout;
  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final exerciseStream = Supabase.instance.client
        .from('exercises')
        .stream(primaryKey: ['id']).eq('workout_id', widget.workout.workoutId);

    return Scaffold(
        appBar: _buildAppBar(context),
        floatingActionButton: _buildFloatingActionButton(context),
        body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: exerciseStream, // Stream of exercises from Supabase
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            return GetBuilder<ExerciseController>(
              init: ExerciseController(), // Initialize the controller
              builder: (controller) {
                final exercises = snapshot.data!
                    .map((json) => TestExercise.fromJson(json))
                    .toList();

                return ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];

                    return GestureDetector(
                      onTap: () async {
                        await exercise.fetchSets();
                      },
                      child: ExerciseCard(
                          exercise: exercise,
                          onTap: () => _showBottomSheet(context, exercise)),
                          // showDialog(context: context, builder: (context)=> AlertDialog())
                    );
                  },
                );
              },
            );
          },
        ));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
          "${DateFormat.MMMd().format(widget.workout.date)} (${widget.workout.name})"),
      // backgroundColor: Colors.teal,
      actions: [
        IconButton(
          icon: Icon(Icons.delete_outline, color: Colors.red.shade400,),
          onPressed: () => _confirmDeleteWorkout(context),
        ),
      ],
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 0, 255, 213),
      onPressed: () => _showAddExerciseDialog(context),
        child: const Icon(Icons.add, color: Colors.black),
    );
  }

  // create exercise from dropdown
  String? selectedExercise;
  final List<String> exerciseNames = [
    "Bench Press",
    "Pull Ups",
    "Lat pull Down",
    "T-Bar Rows",
    "Deadlift",
    "Squat",
    // Add more exercise names here
  ];

  Future<void> createExercise(TestWorkout workout) async {
    final newExercise = TestExercise(name: selectedExercise!);
    await ExerciseDatabase().creatExercise(newExercise, workout.workoutId);
    // Get.back();
  }

  void _showAddExerciseDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add Exercise"),
            content: SizedBox(
              height: 70,
              child: SearchableDropdown.single(
                items: exerciseNames.map((exercise) {
                  return DropdownMenuItem<String>(
                    value: exercise,
                    child: Text(exercise),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedExercise = value;
                  });
                },
                hint: const Text('Choose Exercise'),
                isExpanded: true,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  // Optionally clear selection if needed
                  setState(() {
                    selectedExercise = null;
                  });
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  if (selectedExercise != null) {
                    await createExercise(widget.workout);
                  Navigator.of(context).pop();
                  }
                },
                child: const Text("Save"),
              ),
            ],
          );
        });
  }

  void _confirmDeleteWorkout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Workout"),
          content: const Text("This action is not reversible!"),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                WorkoutDatabase().deleteWorkout(widget.workout);
                Get.back(); // Close dialog
                Get.back(); // Go back to previous screen
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context, TestExercise exercise) {
    showModalBottomSheet(
      context: context,
      builder: (context) => CustomBottomSheet3(exercise: exercise),
    );
  }
}
