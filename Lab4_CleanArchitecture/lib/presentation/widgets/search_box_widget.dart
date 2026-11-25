import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../cubit/medical_cubit.dart';
import '../cubit/medical_state.dart';

class SearchBoxWidget extends StatefulWidget {
  final String hint;
  const SearchBoxWidget({super.key, required this.hint});
  @override
  State<SearchBoxWidget> createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  final controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<MedicalCubit, MedicalState>(
        listenWhen: (a, b) => a.query != b.query && b.query.isEmpty,
        listener: (_, __) {
          if (controller.text.isNotEmpty) controller.clear();
        },
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.searchBackground,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.searchBorder),
          ),
          child: Row(children: [
            const SizedBox(width: 16),
            const Icon(Icons.search_rounded, color: AppColors.searchHintText),
            const SizedBox(width: 12),
            Expanded(
                child: TextField(
              controller: controller,
              onChanged: context.read<MedicalCubit>().search,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: const TextStyle(
                    fontSize: 14, color: AppColors.searchHintText),
                border: InputBorder.none,
                isDense: true,
              ),
            )),
            PopupMenuButton<DoctorSort>(
              icon: const Icon(Icons.tune_rounded,
                  size: 20, color: AppColors.searchHintText),
              tooltip: 'Sort doctors',
              onSelected: context.read<MedicalCubit>().setSort,
              itemBuilder: (_) => const [
                PopupMenuItem(
                    value: DoctorSort.original, child: Text('Original order')),
                PopupMenuItem(
                    value: DoctorSort.nameAZ, child: Text('Name A-Z')),
                PopupMenuItem(
                    value: DoctorSort.nearestFirst,
                    child: Text('Nearest first')),
                PopupMenuItem(
                    value: DoctorSort.farthestFirst,
                    child: Text('Farthest first')),
              ],
            ),
            const SizedBox(width: 4),
          ]),
        ),
      );
}
