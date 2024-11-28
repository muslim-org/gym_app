import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/introbage.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVpdGhrd3J1Y3diZ3l2anFyZHd3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE5NDU0MTYsImV4cCI6MjA0NzUyMTQxNn0.SudnKwN2_PH1kJEuDcAsy25sY556ifVDWtFHyJYR3sc", 
    url: "https://eithkwrucwbgyvjqrdww.supabase.co"
    );
  runApp(const Gym());
}

class Gym extends StatelessWidget {
  const Gym({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
    );
  }
}
