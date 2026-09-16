import 'package:flutter/material.dart' hide StepState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/dv_theme.dart';
import '../../../../core/widgets/dv_widgets.dart';
import '../../../../routes/routes.dart';
import '../../domain/entities/divyaseva_entities.dart';
import '../cubit/async_status.dart';
import '../cubit/booking_detail_cubit.dart';
import '../cubit/bookings_cubit.dart';
import '../cubit/tracking_cubit.dart';

DvStepState _stepState(StepState state) {
  switch (state) {
    case StepState.done:
      return DvStepState.done;
    case StepState.now:
      return DvStepState.now;
    case StepState.idle:
      return DvStepState.idle;
  }
}

class BookingDetailScreen extends StatelessWidget {
  const BookingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingDetailCubit, BookingDetailState>(
      builder: (context, state) {
        final booking = context.watch<BookingsCubit>().state.selected;
        final total = state.checklist.length;
        final ready = state.readyCount;
        final progress = total == 0 ? 0.0 : ready / total;
        return DvScaffold(
          title: booking?.id ?? 'DV-PB-24817',
          backPath: Routes.bookingsPath,
          rightLabel: 'Help',
          onRight: () => context.go(Routes.supportPath),
          tab: 'bookings',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DvCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking?.service ?? 'Griha Pravesh',
                            style: DvText.body(size: 15.5, weight: FontWeight.w700),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            booking?.when ?? 'Sat 12 Sep \u00b7 08:30\u201311:00',
                            style: DvText.mono(size: 11, color: DvColors.ink3),
                          ),
                        ],
                      ),
                    ),
                    const DvPill('Confirmed', tone: DvTone.green),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const DvSectionLabel('Service lifecycle'),
              const SizedBox(height: 10),
              DvCard(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 6),
                child: Column(
                  children: [
                    for (var i = 0; i < state.steps.length; i++)
                      DvStepRow(
                        title: state.steps[i].title,
                        subtitle: state.steps[i].subtitle,
                        state: _stepState(state.steps[i].state),
                        last: i == state.steps.length - 1,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              DvCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const DvAvatar('SJ', size: 38),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pandit Suresh Joshi', style: DvText.body(size: 13.5, weight: FontWeight.w700)),
                              const SizedBox(height: 2),
                              Text('Marathi \u00b7 4.2 km away', style: DvText.body(size: 12, color: DvColors.ink2)),
                            ],
                          ),
                        ),
                        _iconButton(Icons.phone, DvColors.greenSoft, DvColors.green),
                        const SizedBox(width: 8),
                        _iconButton(Icons.chat_bubble_outline, DvColors.line2, DvColors.ink2),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Text(
                      'Calls go through a masked number. Neither of you sees the other\u2019s personal number.',
                      style: DvText.body(size: 12, color: DvColors.ink2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              DvCard(
                onTap: () => context.go(Routes.preparationPath),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Preparation checklist', style: DvText.body(size: 13.5, weight: FontWeight.w700)),
                        Text('$ready / $total', style: DvText.mono(size: 12, color: DvColors.ink3)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    DvProgressBar(value: progress),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              DvCard(
                color: DvColors.line2,
                borderColor: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Samagri kit', style: DvText.body(size: 13, weight: FontWeight.w700)),
                        const SizedBox(height: 2),
                        Text(
                          '34 items \u00b7 reserved \u00b7 out for delivery 11 Sep',
                          style: DvText.body(size: 12, color: DvColors.ink2),
                        ),
                      ],
                    ),
                    const DvPill('On track', tone: DvTone.green),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Expanded(
                    child: DvButton(label: 'Reschedule', variant: DvButtonVariant.ghost, small: true),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: DvButton(
                      label: 'Get help',
                      variant: DvButtonVariant.ghost,
                      small: true,
                      onTap: () => context.go(Routes.supportPath),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Center(
                child: Text(
                  'Cancel booking',
                  style: DvText.body(size: 12, weight: FontWeight.w700, color: DvColors.kum),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _iconButton(IconData icon, Color bg, Color fg) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Icon(icon, size: 17, color: fg),
    );
  }
}

class PreparationScreen extends StatelessWidget {
  const PreparationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingDetailCubit, BookingDetailState>(
      builder: (context, state) {
        final total = state.checklist.length;
        final ready = state.readyCount;
        final progress = total == 0 ? 0.0 : ready / total;
        return DvScaffold(
          title: 'Get ready',
          backPath: Routes.bookingDetailPath,
          rightLabel: 'Print',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DvCard(
                color: DvColors.line2,
                borderColor: Colors.transparent,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('$ready of $total ready', style: DvText.body(size: 13.5, weight: FontWeight.w700)),
                        Text('4 days left', style: DvText.mono(size: 12, color: DvColors.ink3)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    DvProgressBar(value: progress),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const DvSectionLabel('You arrange \u00b7 on the day'),
              const SizedBox(height: 10),
              DvCard(
                child: Column(
                  children: [
                    for (var i = 0; i < state.checklist.length; i++)
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => context.read<BookingDetailCubit>().toggleChecklistItem(i),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                margin: const EdgeInsets.only(top: 1),
                                decoration: BoxDecoration(
                                  color: state.checklist[i].done ? DvColors.green : DvColors.surface,
                                  border: Border.all(
                                    color: state.checklist[i].done ? DvColors.green : DvColors.line,
                                    width: 1.4,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: state.checklist[i].done
                                    ? const Icon(Icons.check, size: 13, color: Colors.white)
                                    : null,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(state.checklist[i].label, style: DvText.body(size: 13)),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const DvSectionLabel('Arriving in your kit \u00b7 Fri 11 Sep'),
              const SizedBox(height: 10),
              DvCard(
                color: DvColors.line2,
                borderColor: Colors.transparent,
                child: Text(
                  'Haldi, kumkum, akshata, supari, copper kalash, nariyal, moli, camphor, ghee, agarbatti, panchamrit set + 23 more. Nothing on this list is your job.',
                  style: DvText.body(size: 12, color: DvColors.ink2),
                ),
              ),
              const SizedBox(height: 16),
              const DvSectionLabel('Pandit Suresh brings'),
              const SizedBox(height: 10),
              DvCard(
                color: DvColors.line2,
                borderColor: Colors.transparent,
                child: Text(
                  'Puja vidhi book, asana, bell, conch and his own dhoti. He will arrive 10 minutes early to set up.',
                  style: DvText.body(size: 12, color: DvColors.ink2),
                ),
              ),
              const SizedBox(height: 14),
              const DvBanner(
                title: 'Two things families often ask',
                body:
                    'Is the milk cow milk? Do we need the whole family present? Send these to Pandit Suresh now rather than on the morning.',
              ),
              const SizedBox(height: 12),
              const DvButton(
                label: 'Ask Pandit Suresh a question',
                variant: DvButtonVariant.ghost,
                small: true,
              ),
            ],
          ),
        );
      },
    );
  }
}

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackingCubit, TrackingState>(
      builder: (context, state) {
        final booking = context.watch<BookingsCubit>().state.selected;
        return DvScaffold(
          title: 'Sat 12 Sep \u00b7 live',
          backPath: Routes.bookingDetailPath,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DvCard(
                color: DvColors.greenSoft,
                borderColor: DvColors.green,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DvPill('\u25cf En route', tone: DvTone.green),
                        const SizedBox(height: 6),
                        Text(
                          'Arriving 08:22',
                          style: DvText.body(size: 16.5, weight: FontWeight.w700, color: DvColors.greenDeep),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '6 minutes ahead of schedule',
                          style: DvText.body(size: 12, color: DvColors.green),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text('6', style: DvText.mono(size: 26, weight: FontWeight.w600, color: DvColors.green)),
                        Text(' min', style: DvText.body(size: 12, color: DvColors.green)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _trackMap(),
              const SizedBox(height: 12),
              DvCard(
                child: Row(
                  children: [
                    const DvAvatar('SJ', size: 38),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pandit ${booking?.pandit ?? 'Suresh Joshi'}',
                            style: DvText.body(size: 13.5, weight: FontWeight.w700),
                          ),
                          const SizedBox(height: 2),
                          Text('Left Majiwada at 08:04', style: DvText.body(size: 12, color: DvColors.ink2)),
                        ],
                      ),
                    ),
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(color: DvColors.green, borderRadius: BorderRadius.circular(13)),
                      child: const Icon(Icons.phone, size: 17, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              DvCard(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 6),
                child: Column(
                  children: [
                    if (state.status == AsyncStatus.loading)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: CircularProgressIndicator(color: DvColors.kum),
                      )
                    else
                      for (var i = 0; i < state.steps.length; i++)
                        DvStepRow(
                          title: state.steps[i].title,
                          subtitle: state.steps[i].subtitle,
                          state: _stepState(state.steps[i].state),
                          last: i == state.steps.length - 1,
                        ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Center(
                child: GestureDetector(
                  onTap: () => context.go(Routes.supportPath),
                  child: Text(
                    'Something is wrong \u2014 get help now',
                    style: DvText.body(size: 12, weight: FontWeight.w700, color: DvColors.kum),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _trackMap() {
    return Container(
      height: 190,
      decoration: BoxDecoration(
        color: const Color(0xFFF0EADC),
        border: Border.all(color: DvColors.line),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _TrackPainter())),
          Positioned(
            left: 44,
            bottom: 26,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: DvColors.kum,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
            ),
          ),
          const Positioned(right: 100, top: 70, child: Icon(Icons.location_on, color: DvColors.kum, size: 26)),
          Positioned(
            right: 12,
            bottom: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(9)),
              child: Text('2.1 km away', style: DvText.body(size: 10.5, weight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

class BackupPanditScreen extends StatelessWidget {
  const BackupPanditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingsCubit>().state.selected;
    return DvScaffold(
      title: booking?.id ?? 'DV-PB-24817',
      backPath: Routes.bookingDetailPath,
      cta: Column(
        children: [
          DvButton(label: 'Accept Pandit Rameshwar', onTap: () => context.go(Routes.trackingPath)),
          const SizedBox(height: 9),
          DvButton(
            label: 'Talk to operations instead',
            variant: DvButtonVariant.ghost,
            small: true,
            onTap: () => context.go(Routes.supportPath),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DvBanner(
            icon: Icons.warning_amber_rounded,
            title: 'Pandit Suresh had a family emergency',
            body: 'He informed us at 06:41 this morning. We did not wait for you to find out.',
          ),
          const SizedBox(height: 14),
          DvCard(
            borderColor: DvColors.green,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'YOUR BACKUP PANDIT IS CONFIRMED',
                      style: DvText.eyebrow(color: DvColors.green),
                    ),
                    const DvPill('06:58', tone: DvTone.green),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const DvAvatar('RD', tone: DvTone.brass),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rameshwar Dixit', style: DvText.body(size: 15, weight: FontWeight.w700)),
                          const SizedBox(height: 2),
                          Text(
                            '22 years \u00b7 Marathi \u00b7 Maharashtrian tradition \u00b7 340 Griha Pravesh done',
                            style: DvText.body(size: 12, color: DvColors.ink2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: const [
                    DvPill('\u2713 ID verified', tone: DvTone.green),
                    DvPill('High reliability', tone: DvTone.brass),
                    DvPill('On time 96%', tone: DvTone.green),
                  ],
                ),
                const SizedBox(height: 11),
                DvCard(
                  color: DvColors.line2,
                  borderColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Text(
                    'He was on standby for Thane West this morning \u2014 that is why this took 17 minutes, not a day of phone calls.',
                    style: DvText.body(size: 12, color: DvColors.ink2),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DvCard(
                  color: DvColors.greenSoft,
                  borderColor: const Color(0xFFCFE5D8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('UNCHANGED', style: DvText.eyebrow(color: DvColors.green)),
                      const SizedBox(height: 8),
                      Text(
                        'Your 08:30 slot\nYour address\nYour samagri kit\nYour price',
                        style: DvText.body(size: 12, color: DvColors.greenDeep, height: 1.7),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: DvCard(
                  color: DvColors.amberSoft,
                  borderColor: const Color(0xFFF0DCB4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CHANGED', style: DvText.eyebrow(color: DvColors.amber)),
                      const SizedBox(height: 8),
                      Text(
                        'The Pandit\nArrival now 08:15\nNew contact number\nNothing else',
                        style: DvText.body(size: 12, color: DvColors.amberText, height: 1.7),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DvCard(
            color: DvColors.line2,
            borderColor: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pandit Rameshwar charges \u20b95,600', style: DvText.body(size: 13, weight: FontWeight.w700)),
                const SizedBox(height: 3),
                Text(
                  'You still pay \u20b95,100. DivyaSeva covers the \u20b9500 difference \u2014 a cancellation is our failure, not your cost.',
                  style: DvText.body(size: 12, color: DvColors.ink2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              'Not comfortable with the change? Full refund within 2 hours, no questions.',
              textAlign: TextAlign.center,
              style: DvText.body(size: 12, color: DvColors.ink2),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final road = Paint()
      ..color = const Color(0xFFD8D0BE)
      ..strokeWidth = 7;
    final inner = Paint()
      ..color = const Color(0xFFF0EADC)
      ..strokeWidth = 4;
    for (final y in [size.height * 0.68, size.height * 0.28]) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), road);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), inner);
    }
    for (final x in [size.width * 0.35, size.width * 0.78]) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), road);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), inner);
    }
    final route = Paint()
      ..color = DvColors.kum
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(50, size.height * 0.86)
      ..lineTo(size.width * 0.35, size.height * 0.86)
      ..lineTo(size.width * 0.35, size.height * 0.44)
      ..lineTo(size.width * 0.66, size.height * 0.44);
    canvas.drawPath(path, route);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
