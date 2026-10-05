import 'package:flutter/material.dart';
import '../../widgets/home_header_section.dart';
import '../../widgets/search_box_widget.dart';
import '../../widgets/appointment_card.dart';
import '../../widgets/health_services_section.dart';
import '../../widgets/nearby_doctors_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                HomeHeaderSection(),
                SizedBox(height: 28),
                SearchBoxWidget(),
                SizedBox(height: 28),
                AppointmentCard(),
                SizedBox(height: 28),
                HealthServicesSection(),
                SizedBox(height: 28),
                NearbyDoctorsSection(),
                SizedBox(height: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}