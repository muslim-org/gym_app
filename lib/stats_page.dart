import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Progress"),
      ),
      body: ListView(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white10,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Bar Chart"),
                    Text(""),
                    Text("(Comparing data of this month with)"),
                    Text("previous months"),
                  ],
                ),
          ),
          Row(children: [
            Expanded(
              child: Container(
                height: 200,
                // width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white10,
                ),
                margin: const EdgeInsets.only(left: 12, top: 6, right: 6),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Line Chart"),
                    Text(""),
                    Text("(Wight progress over time)"),
                  ],
                ),
              ),
            ),
            Container(
              height: 200,
              width: MediaQuery.sizeOf(context).width / 4.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white10,
              ),
              margin: const EdgeInsets.only(right: 12, top: 6, left: 6),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Muscle"),
                  Text("Picker"),
                ],
              ),
            ),
          ])
        ],
      ),
    );
  }
}
