import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab3_state_management/data/repositories/app_repository.dart';
import 'package:lab3_state_management/main.dart';
import 'package:lab3_state_management/state/medical_cubit.dart';

void main() {
  testWidgets('Home screen renders loading indicator for initial state',
      (tester) async {
    final cubit = MedicalCubit(const AppRepository());
    await tester.pumpWidget(
      BlocProvider.value(value: cubit, child: const MedicalApp()),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await cubit.close();
  });
}
