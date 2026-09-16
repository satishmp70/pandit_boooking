import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/dv_theme.dart';
import '../../../../core/widgets/dv_widgets.dart';
import '../../../../routes/routes.dart';
import '../bloc/booking_bloc.dart';
import '../bloc/booking_state.dart';
import '../cubit/bookings_cubit.dart';

class ServiceRecordScreen extends StatelessWidget {
  const ServiceRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final q = state.quote;
        final booking = context.watch<BookingsCubit>().state.selected;
        return DvScaffold(
          title: 'Service record',
          backPath: Routes.bookingsPath,
          rightLabel: 'Share',
          cta: DvButton(label: 'Rate this service', onTap: () => context.go(Routes.reviewPath)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DvBanner(
                tone: DvTone.green,
                icon: Icons.check,
                title: '${booking?.service ?? 'Griha Pravesh'} completed',
                body:
                    'Sat 12 Sep \u00b7 recorded at 10:58. This is an operational record of the service, not a claim about its outcome.',
              ),
              const SizedBox(height: 14),
              DvCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DvSectionLabel('What actually happened'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _metric('08:24', 'Arrived \u00b7 6 min early')),
                        Expanded(child: _metric('08:31', 'Service started')),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(child: _metric('10:58', 'Completed')),
                        Expanded(child: _metric('2h 27m', 'Est. 2h 30m')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              DvCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const DvSectionLabel('Receipt'),
                        Text(
                          booking?.id ?? 'DV-PB-24817',
                          style: DvText.mono(size: 11, color: DvColors.ink3),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    DvMoneyRow(label: 'Griha Pravesh \u00b7 Standard', value: '\u20b9${_money(q.base)}'),
                    DvMoneyRow(label: 'Samagri kit \u00b7 34 items', value: '\u20b9${_money(q.samagri)}'),
                    DvMoneyRow(label: 'Platform fee + GST', value: '\u20b9${_money(q.platform + q.gst)}'),
                    DvMoneyRow(label: 'FIRSTPUJA', value: '\u2212 \u20b9${_money(q.discount)}', discount: true),
                    const DvDivider(),
                    DvMoneyRow(label: 'Paid on 02 Sep', value: '\u20b9${_money(q.total)}', total: true),
                    const SizedBox(height: 12),
                    const DvButton(label: 'Download PDF receipt', variant: DvButtonVariant.ghost, small: true),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              DvCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        DvSectionLabel('Photos'),
                        DvPill('Shared with your consent'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _photo(const [Color(0xFFE8DCC4), Color(0xFFC9A96E)])),
                        const SizedBox(width: 8),
                        Expanded(child: _photo(const [Color(0xFFD9C9E0), Color(0xFF8E7BA8)])),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Text(
                      'Taken by the Pandit after asking your family. Delete them any time from this screen.',
                      style: DvText.body(size: 12, color: DvColors.ink2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              DvCard(
                color: DvColors.line2,
                borderColor: Colors.transparent,
                child: Row(
                  children: [
                    const DvAvatar('SJ', size: 38),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Pandit Suresh Joshi', style: DvText.body(size: 13, weight: FontWeight.w700)),
                          const SizedBox(height: 2),
                          Text(
                            '213th completed service on DivyaSeva',
                            style: DvText.body(size: 12, color: DvColors.ink2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _metric(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: DvText.mono(size: 20, weight: FontWeight.w600)),
        const SizedBox(height: 2),
        Text(label, style: DvText.body(size: 11.5, color: DvColors.ink3)),
      ],
    );
  }

  Widget _photo(List<Color> colors) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(11),
        ),
      ),
    );
  }

  String _money(int value) {
    final digits = value.toString();
    if (digits.length <= 3) return digits;
    final last3 = digits.substring(digits.length - 3);
    final rest = digits.substring(0, digits.length - 3);
    return '$rest,$last3';
  }
}

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  static const _dimensionLabels = [
    'Punctuality',
    'Explained the ritual clearly',
    'Conduct with the family',
    'Overall service experience',
  ];

  int _overall = 5;
  final List<int> _dimensions = [5, 5, 5, 4];

  @override
  Widget build(BuildContext context) {
    return DvScaffold(
      title: 'How did it go?',
      backPath: Routes.serviceRecordPath,
      rightLabel: 'Skip',
      onRight: () => context.go(Routes.homePath),
      cta: DvButton(label: 'Submit review', onTap: () => context.go(Routes.homePath)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Center(child: DvAvatar('SJ', size: 64)),
          const SizedBox(height: 12),
          Center(child: Text('Rate Pandit Suresh', style: DvText.display(size: 26))),
          const SizedBox(height: 12),
          Center(
            child: _TappableStars(
              value: _overall,
              size: 30,
              onChanged: (value) => setState(() => _overall = value),
            ),
          ),
          const SizedBox(height: 18),
          DvCard(
            child: Column(
              children: [
                for (var i = 0; i < _dimensionLabels.length; i++) ...[
                  if (i > 0) const DvDivider(),
                  _dimension(i),
                ],
              ],
            ),
          ),
          const SizedBox(height: 14),
          const DvField(
            label: 'Public review \u00b7 optional',
            value:
                'Reached early, made space for Aaji to sit on a chair without being asked. Explained each step in Marathi.',
          ),
          const SizedBox(height: 12),
          DvCard(
            color: DvColors.line2,
            borderColor: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Private note to DivyaSeva operations',
                        style: DvText.body(size: 13, weight: FontWeight.w700),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Not shown to the Pandit or on his profile. Used to fix things.',
                        style: DvText.body(size: 12, color: DvColors.ink2),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 42,
                  height: 24,
                  decoration: BoxDecoration(color: DvColors.green, borderRadius: BorderRadius.circular(999)),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.all(3),
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const DvBanner(
            tone: DvTone.green,
            icon: Icons.calendar_today_outlined,
            title: 'Remind me next year?',
            body:
                'Many families repeat Satyanarayan Puja on this date. We will ask once, in Aug 2027, and never again if you say no.',
          ),
        ],
      ),
    );
  }

  Widget _dimension(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_dimensionLabels[index], style: DvText.body(size: 13)),
          _TappableStars(
            value: _dimensions[index],
            onChanged: (value) => setState(() => _dimensions[index] = value),
          ),
        ],
      ),
    );
  }
}

class _TappableStars extends StatelessWidget {
  const _TappableStars({required this.value, required this.onChanged, this.size = 13});

  final int value;
  final ValueChanged<int> onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= 5; i++)
          GestureDetector(
            onTap: () => onChanged(i),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Icon(
                i <= value ? Icons.star : Icons.star_border,
                size: size,
                color: DvColors.brass,
              ),
            ),
          ),
      ],
    );
  }
}
