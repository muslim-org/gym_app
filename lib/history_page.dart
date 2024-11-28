import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/Model/Workout.dart';
import 'package:gym_app/Model/app_database.dart';
import 'package:gym_app/workout_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final workoutDatabase = WorkoutDatabase();

  final textController = TextEditingController();

  final _workoutStream =
      Supabase.instance.client.from('workout').stream(primaryKey: ['id']);

  _appBar() {
    return AppBar(
      title: const Text("History"),
      // backgroundColor: color,
    );
  }

  Future<TestWorkout> createWorkout() async {
    // Creat new workout
    final newWorkout =
        TestWorkout(name: textController.text, date: DateTime.now());
    workoutDatabase.creatWorkoutTest(newWorkout);
    textController.clear();

    return newWorkout;
  }

  void updateWorkoutName(TestWorkout workout) {
    //prefill the text controller with the existing note
    textController.text = workout.name;
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: const Text("Workout"),
              content: TextField(
                controller: textController,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                      textController.clear();
                    },
                    child: const Text("Cancel")),
                TextButton(
                  onPressed: () {
                    workoutDatabase.updateWorkoutName(
                        workout, textController.text);
                    Navigator.pop(context);
                    textController.clear();
                  },
                  child: const Text("Update"),
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: ((context) => AlertDialog(
                    title: const Text("New Workout"),
                    content: TextField(
                      controller: textController,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Get.back();
                            textController.clear();
                          },
                          child: const Text("Cancel")),
                      TextButton(
                        onPressed: () async {
                          TestWorkout newWorkout = await createWorkout();
                          Get.back();
                          Get.to(() => WorkoutPage(workout: newWorkout));
                        },
                        child: const Text("Save"),
                      )
                    ],
                  )));
        },
        backgroundColor: const Color.fromARGB(255, 0, 255, 213),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _workoutStream,
          builder: ((context, snapshot) {
            // Loading
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // Loaded
            final workouts = snapshot.data;
            // final workouts = TestWorkout.frommap(data);

            return ListView.builder(
                itemCount: workouts!.length,
                itemBuilder: ((context, index) {
                  final workout = TestWorkout.frommap(workouts[index]);

                  final workoutName = workout.name;

                  return GestureDetector(
                    onTap: () {
                      Get.to(WorkoutPage(workout: workout));
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(
                          workoutName,
                          style: const TextStyle(color: Colors.white),
                        ),
                        // subtitle: Text(workout),
                        // trailing: Text(DateFormat.MMMd().format(workout.date))
                      ),
                    ),
                  );
                }));
          })),
    );
  }
}
