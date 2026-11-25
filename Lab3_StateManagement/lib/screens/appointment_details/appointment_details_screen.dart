import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/app_data.dart';
import '../../state/medical_cubit.dart';
import '../../state/medical_state.dart';
import '../../widgets/appointment_detail_header.dart';
import '../../widgets/doctor_detail_card.dart';
import '../../widgets/doctor_details_section.dart';
import '../../widgets/slot_selection_section.dart';
import '../../widgets/book_appointment_button.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final Doctor? doctor;
  final AppointmentSummary? appointment;
  const AppointmentDetailsScreen({super.key, this.doctor, this.appointment});

  @override
  Widget build(BuildContext context) => BlocBuilder<MedicalCubit, MedicalState>(
    builder: (context, state) {
      final details = state.data?.details;
      if (details == null) {
        return const Scaffold(body: Center(child: Text('No appointment details available')));
      }
      final name = doctor?.name ?? appointment?.doctorName ?? details.fallbackDoctorName;
      final clinic = doctor?.clinic ?? appointment?.doctorSpecialty ?? details.fallbackClinic;
      final image = doctor?.avatarUrl ?? appointment?.doctorAvatar ?? details.fallbackAvatarUrl;
      final payment = doctor?.price ?? details.amount;
      String labelOf(List<SelectionSlot> slots, String id) {
        for (final item in slots) { if (item.id == id) return item.label; }
        return '-';
      }
      return Scaffold(backgroundColor: Colors.white, body: SafeArea(
        child: SingleChildScrollView(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 16),
            AppointmentDetailHeader(title: details.title),
            const SizedBox(height: 28),
            DoctorDetailCard(name: name, clinic: clinic, imageUrl: image,
              payment: payment, currency: details.currency),
            const SizedBox(height: 28),
            DoctorDetailsSection(description: details.description),
            const SizedBox(height: 28),
            SlotSelectionSection(title: 'Working Hours', slots: details.hours, isHour: true),
            const SizedBox(height: 28),
            SlotSelectionSection(title: 'Date', slots: details.dates, isHour: false),
            const SizedBox(height: 48),
            BookAppointmentButton(label: details.buttonLabel, onPressed: () {
              final hour = labelOf(details.hours, state.selectedHourId);
              final date = labelOf(details.dates, state.selectedDateId);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Demo booking: $name, $date at $hour. No real appointment was created.'),
              ));
            }),
            const SizedBox(height: 24),
          ]),
        )),
      ));
    },
  );
}
