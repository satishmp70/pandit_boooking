import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/dv_theme.dart';
import '../../../../core/widgets/dv_widgets.dart';
import '../../../../routes/routes.dart';
import '../../domain/entities/divyaseva_entities.dart';
import '../bloc/booking_bloc.dart';
import '../bloc/booking_event.dart';
import '../bloc/booking_state.dart';
import '../cubit/async_status.dart';
import '../cubit/pandit_match_cubit.dart';

class MatchingScreen extends StatefulWidget {
  const MatchingScreen({super.key});

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    context.read<PanditMatchCubit>().findPandits();
    _timer = Timer(const Duration(milliseconds: 2400), () {
      if (mounted) context.go(Routes.resultsPath);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DvScaffold(
      backPath: Routes.samagriPath,
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            const SizedBox(
              width: 34,
              height: 34,
              child: CircularProgressIndicator(strokeWidth: 3, color: DvColors.kum),
            ),
            const SizedBox(height: 16),
            Text(
              'Finding a Pandit who can\nactually be there',
              textAlign: TextAlign.center,
              style: DvText.display(size: 26),
            ),
            const SizedBox(height: 8),
            Text(
              'Sat 12 Sep \u00b7 08:30 \u00b7 Thane West',
              style: DvText.body(size: 13.5, color: DvColors.ink2),
            ),
            const SizedBox(height: 26),
            DvCard(
              child: Column(
                children: [
                  for (final line in const [
                    ('Approved & active Pandits in Thane West', '26'),
                    ('Offer Griha Pravesh, Maharashtrian', '21'),
                    ('Slot genuinely free at 08:30', '14'),
                    ('Can reach you with prep time', '11'),
                  ])
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          const Icon(Icons.check, size: 16, color: DvColors.green),
                          const SizedBox(width: 10),
                          Expanded(child: Text(line.$1, style: DvText.body(size: 12.5))),
                          Text(line.$2, style: DvText.mono(size: 13, weight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2, color: DvColors.ink3),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Ranking by reliability, language and travel\u2026',
                            style: DvText.body(size: 12.5, color: DvColors.ink2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'An empty calendar is not availability. We only count Pandits whose slot is confirmed and who can physically reach Majiwada in time.',
              textAlign: TextAlign.center,
              style: DvText.body(size: 12, color: DvColors.ink2),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  static const _sorts = ['Recommended', 'Most reliable', 'Price', 'Nearest'];

  int _sort = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PanditMatchCubit, PanditMatchState>(
      builder: (context, state) {
        final pandits = state.pandits;
        return DvScaffold(
          title: pandits.isEmpty ? 'Matching\u2026' : '${pandits.length + 8} Pandits available',
          backPath: Routes.samagriPath,
          rightLabel: 'Filter',
          cta: DvButton(
            label: 'Compare full profiles',
            variant: DvButtonVariant.ghost,
            onTap: () => context.go(Routes.panditPath),
          ),
          child: state.status == AsyncStatus.loading
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Center(child: CircularProgressIndicator(color: DvColors.kum)),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DvChipRow(
                      children: [
                        for (var i = 0; i < _sorts.length; i++)
                          DvChip(
                            _sorts[i],
                            selected: _sort == i,
                            onTap: () => setState(() => _sort = i),
                          ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    if (pandits.isNotEmpty) _highlighted(context, pandits.first),
                    const SizedBox(height: 12),
                    for (final pandit in pandits.skip(1)) ...[
                      _card(pandit),
                      const SizedBox(height: 12),
                    ],
                    DvCard(
                      color: DvColors.line2,
                      borderColor: Colors.transparent,
                      child: Row(
                        children: [
                          const Icon(Icons.auto_awesome, size: 19, color: DvColors.kum),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Auto-match for me', style: DvText.body(size: 13.5, weight: FontWeight.w700)),
                                const SizedBox(height: 3),
                                Text(
                                  'We assign the best available Pandit and hold a named backup. Same price. Recommended if you have no preference.',
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

  Widget _highlighted(BuildContext context, Pandit pandit) {
    return DvCard(
      padding: EdgeInsets.zero,
      borderColor: DvColors.kum,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Row(
                  children: [
                    DvAvatar(pandit.initials),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(pandit.name, style: DvText.body(size: 15, weight: FontWeight.w700)),
                              Text(
                                '\u20b9${_money(pandit.price)}',
                                style: DvText.mono(size: 14, weight: FontWeight.w700),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${pandit.experience} \u00b7 ${pandit.area}, ${pandit.distanceKm} km away',
                              style: DvText.body(size: 12, color: DvColors.ink2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      const DvPill('\u2713 ID verified', tone: DvTone.green),
                      DvPill(pandit.reliability, tone: DvTone.brass),
                      DvPill(pandit.languages),
                    ],
                  ),
                ),
                const SizedBox(height: 11),
                DvCard(
                  color: DvColors.line2,
                  borderColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DvSectionLabel('Recommended because'),
                      const SizedBox(height: 5),
                      Text(
                        'Speaks Marathi, specialises in Griha Pravesh (${pandit.completed} done), is genuinely free at 08:30, and lives ${pandit.distanceKm} km from Majiwada.',
                        style: DvText.body(size: 12, height: 1.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 11),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _stat('${pandit.onTime}%', 'On time'),
                    _stat('${pandit.completed}', 'Completed'),
                    _stat('${pandit.rating}', 'Rating'),
                    _stat('${pandit.noShows}', 'No-shows', color: DvColors.green),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: DvColors.line),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => context.go(Routes.panditPath),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      border: Border(right: BorderSide(color: DvColors.line)),
                    ),
                    child: Text(
                      'View profile',
                      style: DvText.body(size: 13, weight: FontWeight.w700, color: DvColors.ink2),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.read<BookingBloc>().add(BookingPanditSelected(pandit.name));
                    context.go(Routes.quotePath);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Select',
                      style: DvText.body(size: 13, weight: FontWeight.w700, color: DvColors.kum),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _card(Pandit pandit) {
    return DvCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DvAvatar(pandit.initials, tone: DvTone.brass),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(pandit.name, style: DvText.body(size: 14.5, weight: FontWeight.w700)),
                        Text(
                          '\u20b9${_money(pandit.price)}',
                          style: DvText.mono(size: 13.5, weight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${pandit.experience} \u00b7 ${pandit.area}, ${pandit.distanceKm} km',
                        style: DvText.body(size: 12, color: DvColors.ink2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              const DvPill('\u2713 ID verified', tone: DvTone.green),
              DvPill(pandit.reliability, tone: DvTone.brass),
              DvPill(pandit.languages),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            pandit.completed < 50
                ? '${pandit.completed} completed so far \u2014 we show that plainly instead of a borrowed rating.'
                : 'Most experienced nearby \u00b7 on time ${pandit.onTime}% \u00b7 ${pandit.completed} completed',
            style: DvText.body(size: 12, color: DvColors.ink2),
          ),
        ],
      ),
    );
  }

  Widget _stat(String value, String label, {Color color = DvColors.ink}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: DvText.mono(size: 15, weight: FontWeight.w600, color: color)),
        Text(label, style: DvText.body(size: 11, color: DvColors.ink3)),
      ],
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

class PanditProfileScreen extends StatelessWidget {
  const PanditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        return DvScaffold(
          title: 'Pandit profile',
          backPath: Routes.resultsPath,
          rightLabel: 'Report',
          cta: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sat 12 Sep \u00b7 08:30', style: DvText.body(size: 12.5, color: DvColors.ink2)),
                  Text('\u20b9${_money(state.variant.price)}', style: DvText.mono(size: 13, weight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 9),
              DvButton(
                label: 'Book Pandit Suresh',
                onTap: () {
                  context.read<BookingBloc>().add(const BookingPanditSelected('Suresh Joshi'));
                  context.go(Routes.quotePath);
                },
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DvAvatar('SJ', size: 64),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Suresh Joshi', style: DvText.display(size: 22)),
                        const SizedBox(height: 4),
                        Text(
                          '14 years \u00b7 Majiwada, Thane West \u00b7 Marathi, Sanskrit, Hindi',
                          style: DvText.body(size: 12, color: DvColors.ink2),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          children: const [
                            DvPill('High reliability', tone: DvTone.brass),
                            DvPill('\u2713 Verified', tone: DvTone.green),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DvCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DvSectionLabel('Verification \u2014 layer by layer'),
                    const SizedBox(height: 11),
                    for (final row in const [
                      ('Government ID', 'Verified 2026', true),
                      ('Mobile & email', 'Verified', true),
                      ('Service address & area', 'Verified', true),
                      ('Training & lineage', 'Self-declared, recorded', false),
                      ('Code of conduct', 'Signed', true),
                    ])
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(row.$1, style: DvText.body(size: 12.5)),
                            DvPill(
                              row.$3 ? '\u2713 ${row.$2}' : row.$2,
                              tone: row.$3 ? DvTone.green : DvTone.neutral,
                            ),
                          ],
                        ),
                      ),
                    const DvDivider(),
                    Text(
                      'We say exactly what was checked. We do not call anyone \u201cgovernment certified\u201d or \u201cscripture certified\u201d unless that claim was actually verified.',
                      style: DvText.body(size: 12, color: DvColors.ink2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              DvCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DvSectionLabel('Reliability \u2014 from real bookings, not stars'),
                    const SizedBox(height: 12),
                    _reliability('Arrived on time', '98%', 0.98),
                    _reliability('Accepted within 10 min', '96%', 0.96),
                    _reliability('Cancelled after accepting', '0.4%', 0.04, danger: true),
                    _reliability('No-shows', '0 in 212', 1.0),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              DvCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    DvSectionLabel('Services & prices'),
                    SizedBox(height: 10),
                    DvMoneyRow(label: 'Griha Pravesh \u00b7 Standard', value: '\u20b95,100'),
                    DvMoneyRow(label: 'Griha Pravesh + Havan', value: '\u20b97,600'),
                    DvMoneyRow(label: 'Satyanarayan Puja', value: '\u20b94,400'),
                    DvMoneyRow(label: 'Rudrabhishek', value: '\u20b96,200'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const DvSectionLabel('Reviews \u00b7 completed bookings only'),
              const SizedBox(height: 10),
              DvCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Meenal P.', style: DvText.body(size: 13, weight: FontWeight.w700)),
                        const DvStars(5),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Reached 20 minutes early, explained every step to my in-laws in Marathi. Finished exactly when he said.',
                      style: DvText.body(size: 12, color: DvColors.ink2),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      children: const [
                        DvPill('Punctuality 5'),
                        DvPill('Conduct 5'),
                        DvPill('Clarity 5'),
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
                        Text('Ajay S.', style: DvText.body(size: 13, weight: FontWeight.w700)),
                        const DvStars(4),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Very good ritual. Samagri list reached us a bit late, but he adjusted.',
                      style: DvText.body(size: 12, color: DvColors.ink2),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      children: const [DvPill('Punctuality 4'), DvPill('Conduct 5')],
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

  Widget _reliability(String label, String value, double fraction, {bool danger = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: DvText.body(size: 12.5)),
              Text(value, style: DvText.mono(size: 12.5, weight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 5),
          DvProgressBar(value: fraction, danger: danger),
        ],
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
