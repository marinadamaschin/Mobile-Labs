import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/app_repository.dart';
import 'screens/home/home_screen.dart';
import 'state/medical_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    BlocProvider(
      create: (_) => MedicalCubit(const AppRepository())..load(),
      child: const MedicalApp(),
    ),
  );
}

class MedicalApp extends StatelessWidget {
  const MedicalApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Medical App - Lab 3',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF0B8FAC),
      scaffoldBackgroundColor: Colors.white,
    ),
    home: const HomeScreen(),
  );
}
