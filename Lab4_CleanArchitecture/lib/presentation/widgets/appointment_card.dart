import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/medical_entities.dart';
import '../screens/appointment_details/appointment_details_screen.dart';
import 'portrait.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentSummary appointment;
  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AppointmentDetailsScreen(),
            )),
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: double.infinity,
          height: 200,
          child: Stack(clipBehavior: Clip.none, children: [
            Container(
              width: double.infinity,
              height: 173,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                  color: AppColors.coralGreen,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(appointment.title,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                          const Icon(Icons.arrow_forward_ios_rounded,
                              size: 14, color: Colors.white),
                        ]),
                    const SizedBox(height: 12),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Row(children: [
                                  const Icon(Icons.calendar_today_outlined,
                                      color: Colors.white, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                      child: Text(appointment.date,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14)))
                                ]),
                                const SizedBox(height: 8),
                                Row(children: [
                                  const Icon(Icons.access_time_rounded,
                                      color: Colors.white, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                      child: Text(appointment.time,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14)))
                                ]),
                              ])),
                          const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.edit_outlined,
                                  color: AppColors.coralGreen)),
                        ]),
                  ]),
            ),
            Positioned(
                left: 12,
                right: 12,
                bottom: 0,
                child: Container(
                  height: 67,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withAlpha(28),
                            blurRadius: 25,
                            offset: const Offset(0, 8))
                      ]),
                  child: Row(children: [
                    Portrait(
                        url: appointment.doctorAvatar, size: 43, radius: 8),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(appointment.doctorName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary)),
                          const SizedBox(height: 2),
                          Text(appointment.doctorSpecialty,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.doctorFunction)),
                        ])),
                    const Icon(Icons.chat_bubble_outline_rounded,
                        color: AppColors.textPrimary),
                  ]),
                )),
          ]),
        ),
      );
}
