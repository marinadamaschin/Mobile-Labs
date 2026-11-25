import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/medical_cubit.dart';
import '../../cubit/medical_state.dart';
import '../../widgets/home_header_section.dart';
import '../../widgets/search_box_widget.dart';
import '../../widgets/appointment_card.dart';
import '../../widgets/health_services_section.dart';
import '../../widgets/nearby_doctors_section.dart';
import '../../widgets/status_panel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: BlocBuilder<MedicalCubit, MedicalState>(
          builder: (context, state) {
            if (state.status == LoadStatus.initial ||
                state.status == LoadStatus.loading) {
              return const Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                CircularProgressIndicator(),
                SizedBox(height: 12),
                Text('Loading doctors...'),
              ]));
            }
            if (state.status == LoadStatus.error || state.data == null) {
              return StatusPanel(
                icon: Icons.error_outline_rounded,
                title: 'Could not load data',
                message: state.errorMessage,
                onRetry: context.read<MedicalCubit>().loadHome,
              );
            }
            final data = state.data!;
            return SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    HomeHeaderSection(
                        user: data.user,
                        hasUnread: data.hasUnreadNotifications),
                    const SizedBox(height: 28),
                    SearchBoxWidget(hint: data.searchHint),
                    const SizedBox(height: 28),
                    AppointmentCard(appointment: data.appointment),
                    const SizedBox(height: 28),
                    HealthServicesSection(services: data.services),
                    const SizedBox(height: 28),
                    const NearbyDoctorsSection(),
                    const SizedBox(height: 28),
                  ]),
            ));
          },
        )),
      );
}
