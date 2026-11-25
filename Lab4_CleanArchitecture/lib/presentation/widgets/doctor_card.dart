import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/medical_entities.dart';
import '../screens/appointment_details/appointment_details_screen.dart';
import '../cubit/medical_cubit.dart';
import '../cubit/medical_state.dart';
import 'portrait.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AppointmentDetailsScreen(),
            )),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Portrait(url: doctor.avatarUrl),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(doctor.name,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 2),
                  Text(doctor.specialty,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textSecondary)),
                  const SizedBox(height: 8),
                  Row(children: [
                    const Icon(Icons.location_on_rounded,
                        size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Expanded(
                        child: Text(doctor.distance,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.textPrimary))),
                  ]),
                ])),
            BlocSelector<MedicalCubit, MedicalState, bool>(
              selector: (state) => state.isFavorite(doctor),
              builder: (context, isFav) => IconButton(
                tooltip: isFav ? 'Remove favorite' : 'Add favorite',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minHeight: 34, minWidth: 34),
                icon: Icon(
                    isFav
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    size: 22,
                    color:
                        isFav ? AppColors.badgeRed : AppColors.textSecondary),
                onPressed: () =>
                    context.read<MedicalCubit>().toggleFavorite(doctor.id),
              ),
            ),
          ]),
        ),
      );
}
