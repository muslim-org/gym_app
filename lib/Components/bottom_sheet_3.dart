import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/Controllers/exercise_box_controller.dart';
import 'package:gym_app/Model/Exercise.dart';
import 'package:numberpicker/numberpicker.dart';


class CustomBottomSheet3 extends StatelessWidget {
  final TestExercise exercise;

  const CustomBottomSheet3({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: true,
      showDragHandle: true,
      onClosing: () {},
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExerciseHeader(context),
            _buildDivider(),
            _buildSectionTitle("Reps"),
            const Selector(
              listofint: [9, 10, 11],
              sliderMinValue: 1,
              sliderMaxValue: 100,
              step: 1,
              isReps: true,
            ),
            _buildSectionTitle("Weight"),
            const Selector(
              listofint: [30, 35, 50],
              sliderMinValue: 1,
              sliderMaxValue: 100,
              step: 1,
              isReps: false,
            ),
            const SizedBox(height: 40),
            _buildAddSetButton(context),
          ],
        );
      },
    );
  }

  Widget _buildExerciseHeader(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            exercise.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: IconButton(
                onPressed: () async {
                  // final controller = Get.find<ExerciseController>();
                  // controller.deleteExercise(exercise);
                  // Get.back();
                },
                icon: Icon(
                  Icons.delete_outlined,
                  color: Colors.red.shade400,
                )),
          )
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1.5,
      width: double.infinity,
      color: Colors.white10,
      margin: const EdgeInsets.only(left: 14, right: 14, top: 10),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, bottom: 8, top: 14),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildAddSetButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final controller = Get.find<PickerController>();
        if (controller.repsCount == 0) {
          controller.repsCount = 10;
        }
        if (controller.weight == 0) {
          controller.weight = 10;
        }
        controller.addSetToExercise(exercise.exerciseId);
        Get.back();
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            "Add Set",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

// Selector widget for Reps or Weight
class Selector extends StatefulWidget {
  const Selector({
    super.key,
    required this.listofint,
    required this.sliderMinValue,
    required this.sliderMaxValue,
    required this.step,
    required this.isReps,
  });

  final List<double> listofint;
  final int sliderMinValue;
  final int sliderMaxValue;
  final int step;
  final bool isReps;

  @override
  State<Selector> createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  int selected = 0; // Default to index 0
  int _currentValue = 10;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: SizedBox(
        height: 70,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 4, // Picker + 3 buttons
          itemBuilder: (context, index) {
            final List<double> widths = [140, 60, 60, 60];
            final widgetList = [
              _buildPicker(),
              ...widget.listofint.map(_buildNumber).toList(),
            ];
            return GestureDetector(
              onTap: () {
                setState(() => selected = index);
                if (index > 0) _handleTap(index - 1); // Buttons
              },
              child: _buildCircularSelector(
                width: widths[index],
                child: widgetList[index],
                isSelected: selected == index,
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleTap(int index) {
    final selectedValue = widget.listofint[index];
    Get.find<PickerController>().updateRepsAndWeight(
      isReps: widget.isReps,
      selectedIndex: index,
      selectedValue: selectedValue,
    );
  }

  Widget _buildPicker() {
    return GetBuilder<PickerController>(
      init: PickerController(),
      builder: (controller) {
        return NumberPicker(
          value: _currentValue,
          minValue: widget.sliderMinValue,
          maxValue: widget.sliderMaxValue,
          step: widget.step,
          itemWidth: 40,
          axis: Axis.horizontal,
          itemHeight: 30,
          textStyle: const TextStyle(color: Colors.white12),
          haptics: true,
          onChanged: (value) {
            setState(() => _currentValue = value);
            selected = 0;
            controller.updateRepsAndWeight(
              isReps: widget.isReps,
              selectedIndex: 0,
              selectedValue: _currentValue.toDouble(),
            );
          },
        );
      },
    );
  }

  Widget _buildNumber(double value) {
    return Text(
      value.toString(),
      style: const TextStyle(fontSize: 18),
    );
  }

  Widget _buildCircularSelector({
    required double width,
    required Widget child,
    required bool isSelected,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width / 55,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 62,
            width: width + 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: isSelected ? Colors.tealAccent : Colors.white12,
            ),
          ),
          Container(
            height: 60,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromARGB(255, 36, 35, 42),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class PickerController extends GetxController {
  int repsCount = 0;
  double weight = 0.0;

  void updateRepsAndWeight({
    required bool isReps,
    required int selectedIndex,
    required double selectedValue,
  }) {
    if (isReps) {
      repsCount = selectedValue.toInt();
    } else {
      weight = selectedValue;
    }
    update();
  }

  void addSetToExercise(String exerciseId) {
    final exerciseController = Get.find<ExerciseController>();
    // exerciseController.addSetToExercise(set);
    exerciseController.addSetToExercise2(exerciseId, repsCount, weight);
    update();
  }
}
