import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/dv_theme.dart';
import '../../../../core/widgets/dv_widgets.dart';
import '../../../../routes/routes.dart';
import '../bloc/booking_bloc.dart';
import '../bloc/booking_event.dart';
import '../bloc/booking_state.dart';

const _samagriKitItems = <String>[
  'Haldi \u00b7 50 g',
  'Kumkum \u00b7 50 g',
  'Akshata \u00b7 250 g',
  'Supari \u00b7 11',
  'Kalash (copper)',
  'Nariyal \u00b7 2',
  'Moli / kalava',
  'Camphor \u00b7 20 g',
  'Ghee \u00b7 250 ml',
  'Agarbatti',
  'Panchamrit set',
  '+ 23 more',
];

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int _address = 0;
  bool _noc = true;

  @override
  Widget build(BuildContext context) {
    return DvScaffold(
      title: 'Where is the puja?',
      backPath: Routes.servicePath,
      rightLabel: '1 of 4',
      wizardStep: 1,
      cta: DvButton(
        label: 'Continue to date and muhurat',
        onTap: () => context.go(Routes.whenPath),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _map(),
          const SizedBox(height: 16),
          const DvSectionLabel('Saved addresses'),
          const SizedBox(height: 10),
          DvOptionRow(
            selected: _address == 0,
            onTap: () => setState(() => _address = 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'New flat \u2014 Home',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (_address == 0)
                      const DvPill('This booking', tone: DvTone.kum),
                  ],
                ),
                const SizedBox(height: 2),
                const Text(
                  'B-1204, Rustomjee Urbania, Majiwada, Thane West 400601',
                  style: TextStyle(fontSize: 12, color: DvColors.ink2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 9),
          DvOptionRow(
            selected: _address == 1,
            onTap: () => setState(() => _address = 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Parents \u2014 Dadar',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (_address == 1)
                      const DvPill('This booking', tone: DvTone.kum),
                  ],
                ),
                const SizedBox(height: 2),
                const Text(
                  'Shivaji Park, Dadar West, Mumbai 400028 \u00b7 Shared by Aai',
                  style: TextStyle(fontSize: 12, color: DvColors.ink2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(
                child: DvField(
                  label: 'Floor / flat',
                  value: '12th \u00b7 B-1204',
                ),
              ),
              SizedBox(width: 9),
              Expanded(
                child: DvField(label: 'Lift working?', value: 'Yes'),
              ),
            ],
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
                        'Society permission needed',
                        style: DvText.body(size: 13, weight: FontWeight.w700),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Havan or loud aarti may need a society NOC. We will remind you 3 days before.',
                        style: DvText.body(size: 12, color: DvColors.ink2),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _noc = !_noc),
                  child: Container(
                    width: 42,
                    height: 24,
                    decoration: BoxDecoration(
                      color: _noc ? DvColors.green : DvColors.line,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Align(
                      alignment: _noc
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _map() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFFF0EADC),
        border: Border.all(color: DvColors.line),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _GridPainter())),
          Center(
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: DvColors.kum.withAlpha(26),
                shape: BoxShape.circle,
                border: Border.all(color: DvColors.kum, width: 1),
              ),
              child: const Icon(
                Icons.location_on,
                color: DvColors.kum,
                size: 22,
              ),
            ),
          ),
          Positioned(
            left: 14,
            bottom: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Text(
                'Serviceable \u00b7 18 Pandits within 12 km',
                style: DvText.body(
                  size: 10.5,
                  weight: FontWeight.w700,
                  color: DvColors.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WhenScreen extends StatelessWidget {
  const WhenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final bloc = context.read<BookingBloc>();
        return DvScaffold(
          title: 'When?',
          backPath: Routes.locationPath,
          rightLabel: '2 of 4',
          wizardStep: 2,
          cta: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${state.draft.date} \u00b7 08:30 \u00b7 ${state.draft.muhurat}',
                    style: DvText.body(size: 12.5, color: DvColors.ink2),
                  ),
                  Text(
                    'ends 11:00',
                    style: DvText.body(size: 12, color: DvColors.ink3),
                  ),
                ],
              ),
              const SizedBox(height: 9),
              DvButton(
                label: 'Continue to preferences',
                onTap: () => context.go(Routes.preferencesPath),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DvChipRow(
                children: [
                  for (final date in state.dateOptions)
                    DvChip(
                      date,
                      selected: date == state.draft.date,
                      onTap: () => bloc.add(BookingDateSelected(date)),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              DvSectionLabel('Auspicious windows \u00b7 ${state.draft.date}'),
              const SizedBox(height: 10),
              for (final window in state.muhuratWindows) ...[
                Opacity(
                  opacity: window.recommended ? 1 : 0.55,
                  child: DvOptionRow(
                    selected: state.draft.muhurat == window.name,
                    onTap: () => bloc.add(BookingMuhuratSelected(window.name)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              window.name,
                              style: DvText.body(
                                size: 13.5,
                                weight: FontWeight.w700,
                              ),
                            ),
                            DvPill(
                              window.availability,
                              tone: window.recommended
                                  ? DvTone.green
                                  : DvTone.kum,
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(window.range, style: DvText.mono(size: 13)),
                        const SizedBox(height: 3),
                        Text(
                          window.recommended
                              ? 'Widely used for Griha Pravesh in Maharashtrian practice. 18 Pandits free.'
                              : 'Shown so you can see it, not hidden from you.',
                          style: DvText.body(size: 12, color: DvColors.ink2),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 9),
              ],
              const SizedBox(height: 6),
              const DvSectionLabel('Start time'),
              const SizedBox(height: 10),
              DvChipRow(
                children: [
                  for (final time in state.startTimes)
                    DvChip(
                      time,
                      selected: state.draft.slot.startsWith(time),
                      onTap: () =>
                          bloc.add(BookingSlotSelected('$time \u2013 11:00')),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              const DvBanner(
                title: 'How we calculated this',
                body:
                    'Drik Panchang method, Thane coordinates, version 2.1 \u2014 saved with your booking so it can always be checked. Traditions differ; your Pandit may advise a different window and that is legitimate.',
              ),
            ],
          ),
        );
      },
    );
  }
}

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  static const _peopleOptions = [
    '2 \u2013 4',
    '4 \u2013 6',
    '8 \u2013 12',
    '15 \u2013 20',
    '25+',
  ];

  int _serviceFor = 0;

  void _changePeople(BookingBloc bloc, String current, int delta) {
    final index = _peopleOptions.indexOf(current);
    final base = index == -1 ? 2 : index;
    final next = (base + delta).clamp(0, _peopleOptions.length - 1);
    bloc.add(BookingPeopleChanged(_peopleOptions[next]));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final bloc = context.read<BookingBloc>();
        return DvScaffold(
          title: 'Your preferences',
          backPath: Routes.whenPath,
          rightLabel: '3 of 4',
          wizardStep: 3,
          cta: DvButton(
            label: 'Continue to samagri',
            onTap: () => context.go(Routes.samagriPath),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DvSectionLabel('Language the Pandit should use'),
              const SizedBox(height: 10),
              DvChipRow(
                children: [
                  for (final language in state.languages)
                    DvChip(
                      language,
                      selected: language == state.draft.language,
                      onTap: () => bloc.add(BookingLanguageSelected(language)),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              const DvSectionLabel('Tradition / region followed at home'),
              const SizedBox(height: 10),
              DvChipRow(
                children: [
                  for (final tradition in state.traditions)
                    DvChip(
                      tradition,
                      selected: tradition == state.draft.tradition,
                      onTap: () =>
                          bloc.add(BookingTraditionSelected(tradition)),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'If you pick Not sure, the Pandit will ask your family two questions before starting rather than assume.',
                style: DvText.body(size: 12, color: DvColors.ink2),
              ),
              const DvDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'People attending',
                          style: DvText.body(
                            size: 13.5,
                            weight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Decides seating, prasad quantity and duration',
                          style: DvText.body(size: 12, color: DvColors.ink2),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: DvColors.line, width: 1.5),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              _changePeople(bloc, state.draft.people, -1),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 7,
                            ),
                            child: Text(
                              '\u2212',
                              style: TextStyle(
                                fontSize: 16,
                                color: DvColors.ink3,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          state.draft.people,
                          style: DvText.mono(size: 13, weight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () =>
                              _changePeople(bloc, state.draft.people, 1),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 7,
                            ),
                            child: Text(
                              '+',
                              style: TextStyle(
                                fontSize: 16,
                                color: DvColors.kum,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const DvSectionLabel('Who is this service for?'),
              const SizedBox(height: 10),
              DvOptionRow(
                selected: _serviceFor == 0,
                onTap: () => setState(() => _serviceFor = 0),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Myself and my family',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'You are present at the address',
                      style: TextStyle(fontSize: 12, color: DvColors.ink2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 9),
              DvOptionRow(
                selected: _serviceFor == 1,
                onTap: () => setState(() => _serviceFor = 1),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My parents',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        DvPill('Family account', tone: DvTone.brass),
                      ],
                    ),
                    SizedBox(height: 2),
                    Text(
                      'They receive the Pandit, you pay and get the updates',
                      style: TextStyle(fontSize: 12, color: DvColors.ink2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const DvField(
                label: 'Anything the Pandit should know',
                value:
                    'Aaji is 84 and cannot sit on the floor \u2014 please allow a chair.',
              ),
            ],
          ),
        );
      },
    );
  }
}

class SamagriScreen extends StatelessWidget {
  const SamagriScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final bloc = context.read<BookingBloc>();
        final selected = state.samagri;
        return DvScaffold(
          title: 'Samagri',
          backPath: Routes.preferencesPath,
          rightLabel: '4 of 4',
          wizardStep: 4,
          cta: DvButton(
            label: 'Find my Pandit',
            onTap: () => context.go(Routes.matchingPath),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Griha Pravesh needs 34 items. Choose who arranges them \u2014 the price updates immediately, nothing appears later.',
                style: DvText.body(size: 13.5, color: DvColors.ink2),
              ),
              const SizedBox(height: 14),
              for (final option in state.samagriOptions) ...[
                DvOptionRow(
                  selected: state.draft.samagriId == option.id,
                  onTap: () => bloc.add(BookingSamagriSelected(option.id)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              option.name,
                              style: DvText.body(
                                size: 13.5,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            option.price == 0
                                ? '\u20b90'
                                : '+ \u20b9${_money(option.price)}',
                            style: DvText.mono(
                              size: 13,
                              weight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        option.description,
                        style: DvText.body(size: 12, color: DvColors.ink2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 9),
              ],
              const SizedBox(height: 6),
              if (selected.id == 'kit')
                DvCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          DvSectionLabel('In your kit \u00b7 34 items'),
                          DvPill('In stock', tone: DvTone.green),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 12,
                        runSpacing: 6,
                        children: [
                          for (final item in _samagriKitItems)
                            SizedBox(
                              width: 130,
                              child: Text(
                                item,
                                style: DvText.body(
                                  size: 12,
                                  color: item.startsWith('+')
                                      ? DvColors.ink3
                                      : DvColors.ink,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const DvDivider(),
                      Row(
                        children: [
                          const Icon(
                            Icons.inventory_2_outlined,
                            size: 18,
                            color: DvColors.ink2,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Delivered Fri 11 Sep, before 7:00 PM',
                                  style: DvText.body(
                                    size: 12.5,
                                    weight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Reserved from Thane warehouse. If anything is short we substitute and tell you, or refund that line.',
                                  style: DvText.body(
                                    size: 12,
                                    color: DvColors.ink2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              else
                DvCard(
                  color: DvColors.line2,
                  borderColor: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DvSectionLabel('You will get a checklist'),
                      const SizedBox(height: 8),
                      Text(
                        'A printed and in-app list of all 34 items with quantities, split into \u201cbuy\u201d and \u201cyou probably have it\u201d, sent as soon as you book.',
                        style: DvText.body(size: 12, color: DvColors.ink2),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 14),
              DvBanner(
                tone: DvTone.green,
                icon: Icons.currency_rupee,
                title:
                    'Running total \u20b9${_money(state.variant.price + selected.price)}',
                body:
                    'Service \u20b9${_money(state.variant.price)} + samagri \u20b9${_money(selected.price)}. Fees and taxes shown in full on the next screen before you pay anything.',
              ),
            ],
          ),
        );
      },
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

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final road = Paint()
      ..color = const Color(0xFFD8D0BE)
      ..strokeWidth = 5;
    final inner = Paint()
      ..color = const Color(0xFFF0EADC)
      ..strokeWidth = 3;
    for (final y in [size.height * 0.65, size.height * 0.28]) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), road);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), inner);
    }
    for (final x in [size.width * 0.42, size.width * 0.72]) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), road);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), inner);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
