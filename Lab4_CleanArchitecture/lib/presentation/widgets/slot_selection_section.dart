import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/medical_entities.dart';
import '../cubit/medical_cubit.dart';
import '../cubit/medical_state.dart';

class SlotSelectionSection extends StatelessWidget {
  final String title;
  final List<SelectionSlot> slots;
  final bool isHour;
  const SlotSelectionSection(
      {super.key,
      required this.title,
      required this.slots,
      required this.isHour});

  @override
  Widget build(BuildContext context) => BlocBuilder<MedicalCubit, MedicalState>(
        buildWhen: (a, b) => isHour
            ? a.selectedHourId != b.selectedHourId
            : a.selectedDateId != b.selectedDateId,
        builder: (context, state) {
          final currentId =
              isHour ? state.selectedHourId : state.selectedDateId;
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary)),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: slots.map((slot) {
                    final selected = currentId == slot.id;
                    return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: InkWell(
                          onTap: () => isHour
                              ? context.read<MedicalCubit>().selectHour(slot.id)
                              : context
                                  .read<MedicalCubit>()
                                  .selectDate(slot.id),
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              height: 56,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              decoration: BoxDecoration(
                                  color: selected
                                      ? AppColors.bookingDetails
                                      : AppColors.serviceCardBackground,
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.center,
                              child: Text(slot.label,
                                  style: TextStyle(
                                      fontSize: isHour ? 16 : 20,
                                      color: selected
                                          ? Colors.white
                                          : AppColors.textPrimary))),
                        ));
                  }).toList()),
                ),
              ]);
        },
      );
}
