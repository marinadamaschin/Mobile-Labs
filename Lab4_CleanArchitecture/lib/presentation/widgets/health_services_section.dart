import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/medical_entities.dart';
import '../cubit/medical_cubit.dart';
import '../cubit/medical_state.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HealthServicesSection extends StatelessWidget {
  final List<HealthService> services;
  const HealthServicesSection({super.key, required this.services});



  @override
  Widget build(BuildContext context) => BlocBuilder<MedicalCubit, MedicalState>(
        builder: (context, state) => Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Health Services',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary)),
            TextButton(
                onPressed: () => context.read<MedicalCubit>().setCategory(null),
                child: const Text('All',
                    style:
                        TextStyle(fontSize: 12, color: AppColors.coralGreen))),
          ]),
          const SizedBox(height: 12),
          Row(
              children: services.map((service) {
            final active = state.category == service.id;
            return Expanded(
                child: InkWell(
              onTap: () => context
                  .read<MedicalCubit>()
                  .setCategory(active ? null : service.id),
              borderRadius: BorderRadius.circular(10),
              child: Column(children: [
                Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                        color: active
                            ? AppColors.iconCircleBg
                            : AppColors.serviceCardBackground,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: active
                                ? AppColors.coralGreen
                                : Colors.transparent)),
                    child: Center(
                      child: SvgPicture.network(
                        service.iconUrl,
                        width: 29,
                        height: 29,
                        colorFilter: ColorFilter.mode(
                          active
                              ? AppColors.coralGreen
                              : AppColors.textSecondary,
                          BlendMode.srcIn,
                        ),
                        placeholderBuilder: (context) => const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image_outlined),
                      ),
                    )),
                const SizedBox(height: 8),
                Text(service.name,
                    style: TextStyle(
                        fontSize: 12,
                        color: active
                            ? AppColors.coralGreen
                            : AppColors.textSecondary)),
              ]),
            ));
          }).toList()),
        ]),
      );
}
