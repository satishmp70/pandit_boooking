import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/dv_theme.dart';
import '../../../../core/widgets/dv_widgets.dart';
import '../../../../routes/routes.dart';
import '../bloc/booking_bloc.dart';
import '../bloc/booking_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DvColors.appBg,
      body: Column(
        children: [
          DvHero(
            radiusBottom: 0,
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('NAMASTE', style: DvText.eyebrow(color: const Color(0xFF9C93BC))),
                          const SizedBox(height: 2),
                          Text(
                            'Sharad Kulkarni',
                            style: DvText.body(size: 17, weight: FontWeight.w700, color: Colors.white),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white24),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '\u25ce Thane West \u25be',
                          style: DvText.body(size: 12, weight: FontWeight.w600, color: const Color(0xFFD6D0EA)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => context.go(Routes.conciergePath),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        border: Border.all(color: const Color(0x66D9A648)),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SPIRITUAL CONCIERGE', style: DvText.eyebrow(color: DvColors.gold)),
                          const SizedBox(height: 6),
                          Text(
                            'Not sure which puja you need?',
                            style: DvText.body(size: 15.5, weight: FontWeight.w700, color: Colors.white),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Describe it in your own words \u2014 \u201cwe are shifting to a new flat\u201d \u2014 and we will work out the rest.',
                            style: DvText.body(size: 12, color: const Color(0xFFBDB5D6)),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                  child: Text(
                                    'Type or speak your requirement',
                                    style: DvText.body(size: 12.5, color: const Color(0xFF8F87AB)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: DvColors.gold,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.mic, size: 18, color: DvColors.indigo),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DvCard(
                      color: DvColors.greenSoft,
                      borderColor: const Color(0xFFDCEBE1),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                      onTap: () => context.go(Routes.catalogPath),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const DvPill('\u25cf Live', tone: DvTone.green),
                                    const SizedBox(width: 7),
                                    Text('Pandit Today', style: DvText.body(size: 13, weight: FontWeight.w700)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '12 Pandits genuinely free today \u2014 availability re-checked 4 min ago, not just an empty calendar.',
                                  style: DvText.body(size: 12, color: DvColors.ink2),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: DvColors.green),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const DvSectionLabel('Book a ceremony'),
                        GestureDetector(
                          onTap: () => context.go(Routes.catalogPath),
                          child: Text(
                            'All services',
                            style: DvText.body(size: 11.5, weight: FontWeight.w700, color: DvColors.kum),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 9,
                      crossAxisSpacing: 9,
                      childAspectRatio: 0.95,
                      children: [
                        _tile(context, Icons.home_outlined, 'Griha Pravesh', 'griha-pravesh'),
                        _tile(context, Icons.description_outlined, 'Satyanarayan', 'satyanarayan'),
                        _tile(context, Icons.wb_sunny_outlined, 'Ganesh Puja', 'ganesh-puja'),
                        _tile(context, Icons.diamond_outlined, 'Lakshmi Puja', 'lakshmi-puja'),
                        _tile(context, Icons.local_fire_department_outlined, 'Havan', 'havan'),
                        _tile(context, Icons.more_horiz, 'View all', null),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DvCard(
                      padding: EdgeInsets.zero,
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [DvColors.brassSoft, DvColors.kumSoft],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('FESTIVAL CAPACITY', style: DvText.eyebrow(color: DvColors.brass)),
                                const DvPill('Filling fast', tone: DvTone.amber),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Ganesh Chaturthi \u00b7 17\u201319 Sep',
                              style: DvText.body(size: 14, weight: FontWeight.w700),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '64% of Thane Pandit capacity already committed. Book by 8 Sep to be sure of a slot.',
                              style: DvText.body(size: 12, color: DvColors.ink2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const DvSectionLabel('Your upcoming service'),
                    const SizedBox(height: 10),
                    DvCard(
                      onTap: () => context.go(Routes.bookingDetailPath),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const DvAvatar('G'),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Griha Pravesh', style: DvText.body(size: 14, weight: FontWeight.w700)),
                                        const DvPill('Confirmed', tone: DvTone.green),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Sat 12 Sep \u00b7 08:30 \u00b7 Pandit Suresh Joshi',
                                        style: DvText.mono(size: 11, color: DvColors.ink3),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const DvDivider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Preparation checklist: 7 of 11 ready',
                                style: DvText.body(size: 12, color: DvColors.ink2),
                              ),
                              Text(
                                'Open \u203a',
                                style: DvText.body(size: 11.5, weight: FontWeight.w700, color: DvColors.kum),
                              ),
                            ],
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
      bottomNavigationBar: const DvTabBar(active: 'home'),
    );
  }

  Widget _tile(BuildContext context, IconData icon, String label, String? serviceId) {
    return GestureDetector(
      onTap: () {
        if (serviceId == null) {
          context.go(Routes.catalogPath);
        } else {
          context.read<BookingBloc>().add(BookingServiceSelected(serviceId));
          context.go(Routes.servicePath);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: DvColors.surface,
          border: Border.all(color: DvColors.line),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: DvColors.kum),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center, style: DvText.body(size: 11.5, weight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
