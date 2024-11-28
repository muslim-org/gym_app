import 'package:flutter/material.dart';
import 'package:gym_app/Model/Exercise.dart';
import 'package:gym_app/Model/Set.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({required this.exercise, required this.onTap, Key? key})
      : super(key: key);

  final TestExercise exercise;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Replace FutureBuilder with StreamBuilder to listen to sets
    return StreamBuilder<List<TestSet>>(
      stream: exercise.setsStream(),  // A stream that provides updates for sets
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingCard();
        }

        if (snapshot.hasError) {
          return _buildErrorCard(snapshot.error.toString());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _buildNoSetsCard();
        }

        return _buildExerciseCard(snapshot.data!); // Pass sets data to UI
      },
    );
  }

  Widget _buildLoadingCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget _buildExerciseCard(List<TestSet> sets) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exercise.name,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              // List the sets using the data from the stream
              if (sets.isNotEmpty)
                ...sets.map((set) => ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      title: Text(
                        "${set.reps} Reps of ${set.weight.toStringAsFixed(1)} kg",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      trailing:
                          const Icon(Icons.fitness_center, color: Colors.white),
                    )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorCard(String error) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(child: Text('Error: $error')),
        ),
      ),
    );
  }

  Widget _buildNoSetsCard() {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exercise.name,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const Center(child: Text("tap tp add sets"),)
            ],
          ),
        ),
      ),
    );
  }
}
