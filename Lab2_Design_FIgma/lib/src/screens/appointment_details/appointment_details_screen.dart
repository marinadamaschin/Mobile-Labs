import 'package:flutter/material.dart';
import '../../widgets/appointment_detail_header.dart';
import '../../widgets/doctor_detail_card.dart';
import '../../widgets/doctor_details_section.dart';
import '../../widgets/working_hours_section.dart';
import '../../widgets/date_selection_section.dart';
import '../../widgets/book_appointment_button.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  const AppointmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const AppointmentDetailHeader(),
                const SizedBox(height: 28),
                const DoctorDetailCard(),
                const SizedBox(height: 28),
                const DoctorDetailsSection(),
                const SizedBox(height: 28),
                const WorkingHoursSection(),
                const SizedBox(height: 28),
                const DateSelectionSection(),
                const SizedBox(height: 68),
                BookAppointmentButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Appointment booked successfully!'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}