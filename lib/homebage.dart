import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/Model/Workout.dart';
import 'package:gym_app/workout_page.dart';
import 'package:gym_app/profile.dart';

class Homebage extends StatelessWidget {
  const Homebage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 27, 27),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SafeArea(
          child: ListView(
            children: [
              welcomeprofilepic(context),
              graphcontainer(),
              trainingcenter(),
              _workoutBox(
                  imagePath: "assets/Rectangle 39_m_vertical.png",
                  workoutName: "Full Body",
                  description: "Back, Chest, Core, Legs",
                  index: 0),
              _workoutBox(
                  imagePath: "assets/Rectangle 39_m_vertical-2.png",
                  workoutName: "Cardio",
                  description: "Treadmill, Elliptical, Rope jumping",
                  index: 1),
              _workoutBox(
                  imagePath: "assets/Rectangle 20-2.png",
                  workoutName: "Arm Day",
                  description: "Biceps, Triceps, Shoulders",
                  index: 2),
              _workoutBox(
                  imagePath: "assets/Rectangle3.png",
                  workoutName: "Leg Day",
                  description: "Quads, Hamstrings, Calfs",
                  index: 3),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Explor",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Text(
                      "New Exercises For Today",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget welcomeprofilepic(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 8, right: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome, Ziad",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Text(
                "Mon, 18 Aug 2005",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
            child: const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("assets/20221023_152100.jpg"),
            ),
          ),
        ],
      ),
    );
  }

  Widget graphcontainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black,
      ),
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Current Status",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 150),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Day 1", style: TextStyle(color: Colors.white)),
              Text("Day 2", style: TextStyle(color: Colors.white)),
              Text("Day 3", style: TextStyle(color: Colors.white)),
              Text("Day 4", style: TextStyle(color: Colors.white)),
              Text("Day 5", style: TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetric("78", "BPM"),
              _buildMetric("340", "KKAL"),
              _buildMetric("120", "Weight"),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildMetric(String value, String unit) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          unit,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget trainingcenter() {
    return const Padding(
      padding: EdgeInsets.only(top: 20, left: 8, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Training",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          Text(
            "Choose Your Work Out",
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _workoutBox(
      {required String imagePath,
      required String workoutName,
      required String description,
      required int index}) {
    List<TestWorkout> defultWorkouts = [
      TestWorkout(
          name: "Full Body",
          date: DateTime.now(),
          workoutId: '6ec67f50-e0a7-484a-837c-c60fe6a01a03',
          id: '0ace0199-db3f-4d39-99dd-b70aa023b632'),
      TestWorkout(
          name: "Cardio",
          date: DateTime.now(),
          workoutId: '9732dbfd-448a-496a-955c-ba1aa2f6cf19',
          id: 'bd338922-7521-4f27-a1dd-331bc2f7cd02'),
      TestWorkout(
          name: "Arm Day",
          date: DateTime.now(),
          workoutId: '608818e9-f59a-4a2d-a0e1-65465e626470',
          id: '1758d355-2be9-4649-b227-1bee9afde1b0'),
      TestWorkout(
          name: "Leg Day",
          date: DateTime.now(),
          workoutId: '608818e9-f59a-4a2d-a0e1-65465e626470',
          id: 'e2baf113-cb19-42cb-aa0e-86dcd3777890'),
    ];

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => WorkoutPage(workout: defultWorkouts[index]));
          },
          child: Stack(
            children: [
              SizedBox(
                // decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                height: 160,
                width: double.infinity,
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 107),
                // color: Colors.white24,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: <Color>[
                      Colors.black,
                      Colors.black87,
                      Colors.black38,
                      Colors.transparent
                    ])),
                width: double.infinity,
                height: 53,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workoutName,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      description,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
