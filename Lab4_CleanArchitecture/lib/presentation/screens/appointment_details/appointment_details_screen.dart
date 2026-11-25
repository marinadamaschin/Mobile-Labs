import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/medical_entities.dart';
import '../../cubit/medical_cubit.dart';
import '../../cubit/medical_state.dart';
import '../../widgets/appointment_detail_header.dart';
import '../../widgets/doctor_detail_card.dart';
import '../../widgets/doctor_details_section.dart';
import '../../widgets/slot_selection_section.dart';
import '../../widgets/book_appointment_button.dart';
import '../../widgets/status_panel.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  const AppointmentDetailsScreen({super.key});

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch details from the second API, only when opening this screen.
    context.read<MedicalCubit>().loadDetails();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<MedicalCubit, MedicalState>(
        builder: (context, state) {
          final details = state.details;
          if (state.detailsStatus == LoadStatus.initial ||
              state.detailsStatus == LoadStatus.loading) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
          if (state.detailsStatus == LoadStatus.error || details == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('Appointment')),
              body: StatusPanel(
                icon: Icons.wifi_off_rounded,
                title: 'Could not load appointment',
                message: state.detailsError,
                onRetry: context.read<MedicalCubit>().loadDetails,
              ),
            );
          }
          String labelOf(List<SelectionSlot> slots, String id) {
            for (final item in slots) {
              if (item.id == id) return item.label;
            }
            return '-';
          }

          return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        AppointmentDetailHeader(title: details.title),
                        const SizedBox(height: 28),
                        DoctorDetailCard(
                          name: details.doctorName,
                          clinic: details.clinic,
                          imageUrl: details.avatarUrl,
                          payment: details.amount,
                          currency: details.currency,
                        ),
                        const SizedBox(height: 28),
                        DoctorDetailsSection(description: details.description),
                        const SizedBox(height: 28),
                        SlotSelectionSection(
                            title: 'Working Hours',
                            slots: details.hours,
                            isHour: true),
                        const SizedBox(height: 28),
                        SlotSelectionSection(
                            title: 'Date', slots: details.dates, isHour: false),
                        const SizedBox(height: 48),
                        BookAppointmentButton(
                          label: details.buttonLabel,
                          onPressed: () {
                            if (!details.bookingEnabled) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Booking is unavailable.'),
                              ));
                              return;
                            }
                            final hour =
                                labelOf(details.hours, state.selectedHourId);
                            final date =
                                labelOf(details.dates, state.selectedDateId);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Demo booking: ${details.doctorName}, '
                                  '$date at $hour. No real appointment was created.'),
                            ));
                          },
                        ),
                        const SizedBox(height: 24),
                      ]),
                )),
              ));
        },
      );
}
