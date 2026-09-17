import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/dv_theme.dart';
import '../../../../core/widgets/dv_widgets.dart';
import '../../../../routes/routes.dart';
import '../cubit/async_status.dart';
import '../cubit/partner_cubit.dart';

class PartnerDashboardScreen extends StatelessWidget {
  const PartnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartnerCubit, PartnerState>(
      builder: (context, state) {
        final dashboard = state.dashboard;
        return Scaffold(
          backgroundColor: DvColors.appBg,
          body: Column(
            children: [
              DvHero(
                radiusBottom: 26,
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('PANDIT PORTAL', style: DvText.eyebrow(color: const Color(0xFF9C93BC))),
                              const SizedBox(height: 2),
                              Text(
                                'Suresh Joshi ji',
                                style: DvText.body(size: 17, weight: FontWeight.w700, color: Colors.white),
                              ),
                            ],
                          ),
                          const DvPill('Available today', tone: DvTone.indigo),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(child: _stat('${dashboard?.jobsToday ?? 0}', 'Jobs today')),
                          const SizedBox(width: 8),
                          Expanded(child: _stat(dashboard?.weekEarnings ?? '\u2014', 'This week')),
                          const SizedBox(width: 8),
                          Expanded(child: _stat('${dashboard?.onTime ?? 0}%', 'On time', highlight: true)),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: state.status == AsyncStatus.loading
                      ? const Center(child: CircularProgressIndicator(color: DvColors.kum))
                      : SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DvCard(
                                borderColor: DvColors.kum,
                                onTap: () => context.go(Routes.partnerRequestPath),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('NEW REQUEST', style: DvText.eyebrow(color: DvColors.kum)),
                                        const DvPill('Expires in 4:12', tone: DvTone.kum),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Griha Pravesh \u00b7 Sat 12 Sep, 08:30',
                                      style: DvText.body(size: 14.5, weight: FontWeight.w700),
                                    ),
                                    const SizedBox(height: 3),
                                    Text.rich(
                                      TextSpan(
                                        style: DvText.body(size: 12, color: DvColors.ink2),
                                        children: const [
                                          TextSpan(text: 'Majiwada, 4.2 km \u00b7 Marathi \u00b7 you earn '),
                                          TextSpan(
                                            text: '\u20b94,335',
                                            style: TextStyle(fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 11),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: DvButton(
                                            label: 'Accept',
                                            small: true,
                                            onTap: () => context.go(Routes.partnerJobPath),
                                          ),
                                        ),
                                        const SizedBox(width: 9),
                                        const Expanded(
                                          child: DvButton(label: 'Decline', variant: DvButtonVariant.ghost, small: true),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              const DvSectionLabel('Today'),
                              const SizedBox(height: 10),
                              for (final job in dashboard?.jobs ?? const []) ...[
                                DvCard(
                                  onTap: () => context.go(Routes.partnerJobPath),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(job.title, style: DvText.body(size: 14, weight: FontWeight.w700)),
                                          const SizedBox(height: 3),
                                          Text(job.detail, style: DvText.mono(size: 11, color: DvColors.ink3)),
                                        ],
                                      ),
                                      DvPill(
                                        job.badge,
                                        tone: job.badgeTone == 'green' ? DvTone.green : DvTone.neutral,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                              DvCard(
                                color: DvColors.brassSoft,
                                borderColor: const Color(0xFFEBDCB4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('DEMAND NEAR YOU', style: DvText.eyebrow(color: DvColors.brass)),
                                    const SizedBox(height: 7),
                                    Text(
                                      'Griha Pravesh requests in Thane West are up 3x this weekend',
                                      style: DvText.body(size: 13, weight: FontWeight.w700, color: DvColors.brassText),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      '14 searches went unserved on Sat morning. Opening 07:00\u201312:00 could add about \u20b910,200.',
                                      style: DvText.body(size: 12, color: DvColors.brassText),
                                    ),
                                    const SizedBox(height: 11),
                                    const DvButton(
                                      label: 'Open Saturday morning',
                                      variant: DvButtonVariant.ghost,
                                      small: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: DvColors.surface,
              border: Border(top: BorderSide(color: DvColors.line)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 76,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _partnerTab(Icons.wb_sunny_outlined, 'Today', true),
                      _partnerTab(Icons.calendar_today_outlined, 'Calendar', false),
                      Expanded(
                        child: Transform.translate(
                          offset: const Offset(0, -22),
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFC4402F), Color(0xFF96262A)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                      _partnerTab(Icons.currency_rupee, 'Earnings', false),
                      _partnerTab(Icons.person_outline, 'Profile', false),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _stat(String value, String label, {bool highlight = false}) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(13)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: DvText.mono(
              size: 20,
              weight: FontWeight.w600,
              color: highlight ? DvColors.gold : Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: DvText.body(size: 10.5, color: const Color(0xFFBDB5D6))),
        ],
      ),
    );
  }

  Widget _partnerTab(IconData icon, String label, bool on) {
    final color = on ? DvColors.kum : DvColors.ink3;
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 4),
          Text(label, style: DvText.body(size: 9.5, weight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }
}

class PartnerRequestScreen extends StatelessWidget {
  const PartnerRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DvScaffold(
      title: 'New request',
      backPath: Routes.partnerDashboardPath,
      cta: Column(
        children: [
          DvButton(label: 'Accept \u00b7 \u20b94,335', onTap: () => context.go(Routes.partnerJobPath)),
          const SizedBox(height: 9),
          DvButton(
            label: 'Decline with reason',
            variant: DvButtonVariant.ghost,
            small: true,
            onTap: () => context.go(Routes.partnerDashboardPath),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DvBanner(
            tone: DvTone.kum,
            icon: Icons.access_time,
            title: 'Respond within 4:12',
            body: 'After that it goes to the next Pandit. Fast acceptance improves your ranking.',
          ),
          const SizedBox(height: 14),
          DvCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Griha Pravesh \u00b7 Standard', style: DvText.body(size: 16, weight: FontWeight.w700)),
                const SizedBox(height: 3),
                Text(
                  '2 hr 30 min \u00b7 Maharashtrian tradition \u00b7 Marathi',
                  style: DvText.body(size: 12, color: DvColors.ink2),
                ),
                const DvDivider(),
                _row('When', 'Sat 12 Sep \u00b7 08:30\u201311:00', mono: true),
                _row('Where', 'Majiwada, Thane W \u00b7 4.2 km'),
                _row('Travel time', '18 min \u00b7 leave by 07:55', mono: true),
                _row('Family size', '8\u201312 people'),
                _row('Samagri', 'DivyaSeva kit \u2014 not your job'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          DvCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                DvSectionLabel('Your earning'),
                SizedBox(height: 8),
                DvMoneyRow(label: 'Your dakshina', value: '\u20b95,100'),
                DvMoneyRow(label: 'DivyaSeva commission (15%)', value: '\u2212 \u20b9765'),
                DvDivider(),
                DvMoneyRow(label: 'You receive', value: '\u20b94,335', total: true),
              ],
            ),
          ),
          const SizedBox(height: 12),
          DvCard(
            color: DvColors.line2,
            borderColor: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DvSectionLabel('Note from the family'),
                const SizedBox(height: 7),
                Text(
                  '\u201cAaji is 84 and cannot sit on the floor \u2014 please allow a chair.\u201d',
                  style: DvText.body(size: 12, color: DvColors.ink2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const DvBanner(
            icon: Icons.warning_amber_rounded,
            title: 'Accepting is a commitment',
            body:
                'Cancelling after acceptance affects your reliability rating and may reduce future requests. If you are unsure about the timing, decline now.',
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool mono = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: DvText.body(size: 12.5, color: DvColors.ink2)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: mono
                  ? DvText.mono(size: 12, weight: FontWeight.w600)
                  : DvText.body(size: 12.5, weight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class PartnerJobScreen extends StatelessWidget {
  const PartnerJobScreen({super.key});

  static const _beforeStart = [
    ('Confirm family follows Maharashtrian vidhi', true),
    ('Samagri kit received by the family', true),
    ('Chair arranged for the elder', false),
    ('Puja space set, east facing', false),
  ];

  @override
  Widget build(BuildContext context) {
    return DvScaffold(
      title: 'Today \u00b7 08:30',
      backPath: Routes.partnerDashboardPath,
      rightLabel: 'Help',
      onRight: () => context.go(Routes.supportPath),
      cta: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Next step in the service', style: DvText.body(size: 12, color: DvColors.ink2)),
              Text('08:22', style: DvText.mono(size: 12, color: DvColors.ink2)),
            ],
          ),
          const SizedBox(height: 9),
          const DvButton(label: 'Mark arrived', variant: DvButtonVariant.indigo),
        ],
      ),
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
                    Text('CURRENT STATUS', style: DvText.eyebrow(color: DvColors.green)),
                    const SizedBox(height: 4),
                    Text(
                      'En route \u00b7 2.1 km away',
                      style: DvText.body(size: 16, weight: FontWeight.w700, color: DvColors.greenDeep),
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
          DvCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Griha Pravesh \u00b7 Standard', style: DvText.body(size: 14.5, weight: FontWeight.w700)),
                        const SizedBox(height: 3),
                        Text('DV-PB-24817 \u00b7 08:30\u201311:00', style: DvText.mono(size: 11, color: DvColors.ink3)),
                      ],
                    ),
                    const DvPill('\u20b94,335'),
                  ],
                ),
                const DvDivider(),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 18, color: DvColors.ink2),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'B-1204, Rustomjee Urbania, Majiwada',
                            style: DvText.body(size: 13, weight: FontWeight.w600),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '12th floor \u00b7 lift working \u00b7 security informed',
                            style: DvText.body(size: 12, color: DvColors.ink2),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.navigation, size: 18, color: DvColors.indigo),
                  ],
                ),
                const DvDivider(),
                Row(
                  children: [
                    const DvAvatar('SK', size: 38),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sharad Kulkarni', style: DvText.body(size: 13, weight: FontWeight.w600)),
                          const SizedBox(height: 2),
                          Text(
                            'Masked line \u00b7 number not shared',
                            style: DvText.body(size: 12, color: DvColors.ink2),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(color: DvColors.greenSoft, borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.phone, size: 16, color: DvColors.green),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const DvSectionLabel('Before you start'),
          const SizedBox(height: 10),
          DvCard(
            child: Column(
              children: [
                for (final item in _beforeStart)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          margin: const EdgeInsets.only(top: 1),
                          decoration: BoxDecoration(
                            color: item.$2 ? DvColors.green : DvColors.surface,
                            border: Border.all(
                              color: item.$2 ? DvColors.green : DvColors.line,
                              width: 1.4,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: item.$2 ? const Icon(Icons.check, size: 13, color: Colors.white) : null,
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Text(item.$1, style: DvText.body(size: 13))),
                      ],
                    ),
                  ),
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
                    Text('Cannot make it?', style: DvText.body(size: 13, weight: FontWeight.w700)),
                    const SizedBox(height: 3),
                    Text(
                      'Tell us now \u2014 a standby Pandit can still reach in time.',
                      style: DvText.body(size: 12, color: DvColors.ink2),
                    ),
                  ],
                ),
                Text('Report', style: DvText.body(size: 12, weight: FontWeight.w700, color: DvColors.kum)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
