import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'data/datasources/medical_remote_data_source.dart';
import 'data/repositories/medical_repository_impl.dart';
import 'domain/usecases/get_appointment_details.dart';
import 'domain/usecases/get_home_data.dart';
import 'presentation/cubit/medical_cubit.dart';
import 'presentation/screens/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final client = http.Client();
  final remote = MedicalRemoteDataSource(client);
  final repository = MedicalRepositoryImpl(remote);
  runApp(MedicalApp(
    createCubit: () => MedicalCubit(
      GetHomeData(repository),
      GetAppointmentDetails(repository),
    )..loadHome(),
  ));
}

class MedicalApp extends StatelessWidget {
  final MedicalCubit Function() createCubit;
  const MedicalApp({super.key, required this.createCubit});

  @override
  Widget build(BuildContext context) => BlocProvider<MedicalCubit>(
        create: (_) => createCubit(),
        child: MaterialApp(
          title: 'Medical App - Lab 4',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: const Color(0xFF0B8FAC),
            scaffoldBackgroundColor: Colors.white,
          ),
          home: const HomeScreen(),
        ),
      );
}
