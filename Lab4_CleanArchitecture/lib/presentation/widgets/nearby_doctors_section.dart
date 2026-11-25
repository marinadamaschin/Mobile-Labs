import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../cubit/medical_cubit.dart';
import '../cubit/medical_state.dart';
import 'doctor_card.dart';
import 'status_panel.dart';

class NearbyDoctorsSection extends StatelessWidget {
  const NearbyDoctorsSection({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<MedicalCubit, MedicalState>(
        builder: (context, state) {
          final all = state.filteredDoctors;
          final visible = state.visibleDoctors;
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  const Expanded(
                      child: Text('Nearby Doctor',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary))),
                  TextButton(
                    onPressed: () =>
                        context.read<MedicalCubit>().toggleShowAll(),
                    child: Text(state.showAll ? 'Show Less' : 'See All',
                        style: const TextStyle(
                            color: AppColors.coralGreen, fontSize: 12)),
                  ),
                ]),
                Row(children: [
                  FilterChip(
                    label: const Text('Favorites only'),
                    selected: state.onlyFavorites,
                    onSelected: (_) =>
                        context.read<MedicalCubit>().toggleOnlyFavorites(),
                    selectedColor: AppColors.iconCircleBg,
                  ),
                  const Spacer(),
                  Text('${all.length} doctors',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textSecondary)),
                ]),
                if (state.status == LoadStatus.empty)
                  StatusPanel(
                    icon: Icons.search_off_outlined,
                    title: 'No doctors found',
                    message: 'Change your search or filters.',
                    actionLabel: 'Clear filters',
                    onRetry: () => context.read<MedicalCubit>().clearFilters(),
                  )
                else
                  ...visible.map((doctor) =>
                      DoctorCard(key: ValueKey(doctor.id), doctor: doctor)),
              ]);
        },
      );
}
