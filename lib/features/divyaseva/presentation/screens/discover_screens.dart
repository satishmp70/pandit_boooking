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
import '../cubit/catalog_cubit.dart';

class ConciergeScreen extends StatelessWidget {
  const ConciergeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DvScaffold(
      title: 'Spiritual concierge',
      backPath: Routes.homePath,
      rightLabel: 'Human help',
      cta: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Understood: Griha Pravesh \u00b7 Thane West',
                style: DvText.body(size: 12, color: DvColors.ink2),
              ),
              Text(
                'Talk to a human',
                style: DvText.body(
                  size: 12,
                  weight: FontWeight.w700,
                  color: DvColors.kum,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          DvButton(
            label: 'Continue with Standard',
            onTap: () => context.go(Routes.servicePath),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bubble(
            'Namaste \uD83D\uDE4F Tell me what is happening at home \u2014 in your own words, any language.',
            me: false,
          ),
          _bubble(
            'We are moving into our new flat in Thane next week. What should we do?',
            me: true,
          ),
          _bubble(
            'That sounds like a Griha Pravesh \u2014 the ceremony done before a family first occupies a new home.\n\nPractices vary by family and region, so I will show you approved options rather than a ruling.',
            me: false,
          ),
          const SizedBox(height: 4),
          DvCard(
            borderColor: DvColors.kum,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Griha Pravesh \u00b7 Standard',
                      style: DvText.body(size: 13.5, weight: FontWeight.w700),
                    ),
                    Text(
                      '\u20b95,100',
                      style: DvText.mono(size: 13, weight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  '2 hr 30 min \u00b7 Kalash sthapana, Ganesh puja, Vastu sankalp, aarti',
                  style: DvText.body(size: 12, color: DvColors.ink2),
                ),
                const SizedBox(height: 9),
                const DvPill('Most booked in Thane'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          DvCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Griha Pravesh + Vastu Shanti',
                      style: DvText.body(size: 13.5, weight: FontWeight.w700),
                    ),
                    Text(
                      '\u20b99,200',
                      style: DvText.mono(size: 13, weight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  '5 hr \u00b7 Adds havan, Navagraha shanti and full Vastu puja',
                  style: DvText.body(size: 12, color: DvColors.ink2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Three quick things and I will find you a Pandit: which date, which language, and who arranges the samagri.',
            style: DvText.body(size: 13, color: DvColors.ink2),
          ),
          const SizedBox(height: 10),
          DvChipRow(
            children: const [
              DvChip('Next week', selected: true),
              DvChip('Marathi'),
              DvChip('Send me a kit'),
            ],
          ),
          const SizedBox(height: 14),
          const DvBanner(
            icon: Icons.info_outline,
            title: 'I never invent availability or prices',
            body:
                'Every slot and amount you see comes from the live booking system. If I am unsure, I hand you to a human guide.',
          ),
        ],
      ),
    );
  }

  Widget _bubble(String text, {required bool me}) {
    return Align(
      alignment: me ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(13),
        constraints: const BoxConstraints(maxWidth: 290),
        decoration: BoxDecoration(
          color: me ? DvColors.kum : DvColors.surface,
          border: me ? null : Border.all(color: DvColors.line),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: DvText.body(
            size: 13,
            color: me ? Colors.white : DvColors.ink,
            height: 1.45,
          ),
        ),
      ),
    );
  }
}

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  static const _categories = [
    'Home & property',
    'Common pujas',
    'Sanskar',
    'Ancestral',
    'Festival',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogCubit, CatalogState>(
      builder: (context, state) {
        return DvScaffold(
          title: 'All services',
          backPath: Routes.homePath,
          tab: '',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: DvColors.surface,
                  border: Border.all(color: DvColors.line),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, size: 18, color: DvColors.ink3),
                    const SizedBox(width: 9),
                    Text(
                      'Search \u201csatyanarayan\u201d, \u201cmundan\u201d\u2026',
                      style: DvText.body(size: 13.5, color: DvColors.ink3),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              DvChipRow(
                children: [
                  for (final category in _categories)
                    DvChip(
                      category,
                      selected: category == state.category,
                      onTap: () =>
                          context.read<CatalogCubit>().selectCategory(category),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              DvSectionLabel(
                '${state.category} \u00b7 ${state.visible.length} services',
              ),
              const SizedBox(height: 10),
              if (state.status == AsyncStatus.loading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: CircularProgressIndicator(color: DvColors.kum),
                  ),
                )
              else if (state.visible.isEmpty)
                DvCard(
                  color: DvColors.line2,
                  borderColor: Colors.transparent,
                  child: Text(
                    'No services in this category yet.',
                    style: DvText.body(size: 12, color: DvColors.ink2),
                  ),
                )
              else
                DvCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      for (var i = 0; i < state.visible.length; i++) ...[
                        if (i > 0)
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: DvColors.line2,
                          ),
                        _row(context, state.visible[i]),
                      ],
                    ],
                  ),
                ),
              const SizedBox(height: 14),
              const DvBanner(
                tone: DvTone.green,
                icon: Icons.wb_sunny_outlined,
                title: 'Cannot find your ceremony?',
                body:
                    'Regional names differ. Describe it to the concierge and we will map it to the right service.',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _row(BuildContext context, DivyaService service) {
    final available = service.available;
    return Opacity(
      opacity: available ? 1 : 0.55,
      child: GestureDetector(
        onTap: available
            ? () {
                context.read<BookingBloc>().add(
                  BookingServiceSelected(service.id),
                );
                context.go(Routes.servicePath);
              }
            : null,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      service.name,
                      style: DvText.body(size: 14.5, weight: FontWeight.w700),
                    ),
                  ),
                  if (available)
                    Text(
                      'from \u20b9${_money(service.fromPrice)}',
                      style: DvText.mono(size: 13, weight: FontWeight.w600),
                    )
                  else
                    const DvPill('No slots this week'),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                available
                    ? '${service.duration} \u00b7 3 variants \u00b7 ${service.panditsNearby} Pandits within 10 km'
                    : 'We show this honestly instead of taking a booking we cannot staff.',
                style: DvText.body(size: 12, color: DvColors.ink2),
              ),
            ],
          ),
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

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final service = state.selectedService;
        return DvScaffold(
          title: service?.name ?? 'Service',
          backPath: Routes.catalogPath,
          rightLabel: 'Share',
          cta: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${state.variant.name} \u00b7 ${state.variant.duration}',
                    style: DvText.body(size: 12.5, color: DvColors.ink2),
                  ),
                  Text(
                    '\u20b9${_money(state.variant.price)}',
                    style: DvText.mono(size: 13, weight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 9),
              DvButton(
                label: 'Choose date and location',
                onTap: () => context.go(Routes.locationPath),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DvCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.bottomLeft,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [DvColors.heroStart, DvColors.heroEnd],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if ((service?.devanagari ?? '').isNotEmpty)
                            Text(
                              service!.devanagari,
                              style: DvText.body(
                                size: 15,
                                color: DvColors.gold,
                                spacing: 3,
                              ),
                            ),
                          Text(
                            service?.name ?? 'Service',
                            style: DvText.display(
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          DvPill(
                            '\u2713 ${service?.panditsNearby ?? 0} Pandits nearby',
                            tone: DvTone.green,
                          ),
                          const SizedBox(width: 8),
                          DvPill(
                            '\u2605 ${service?.rating ?? 0} \u00b7 ${service?.completed ?? 0} done',
                            tone: DvTone.brass,
                          ),
                          const SizedBox(width: 8),
                          const DvPill('Home service'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                service?.description ??
                    'The ceremony performed before a family first occupies a new home.',
                style: DvText.body(size: 13.5, color: DvColors.ink2),
              ),
              const SizedBox(height: 16),
              Text('Choose a variant', style: DvText.eyebrow()),
              const SizedBox(height: 10),
              for (final variant in state.variants) ...[
                DvOptionRow(
                  selected: state.draft.variantId == variant.id,
                  onTap: () => context.read<BookingBloc>().add(
                    BookingVariantSelected(variant.id),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              variant.name,
                              style: DvText.body(
                                size: 13.5,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            '\u20b9${_money(variant.price)}',
                            style: DvText.mono(
                              size: 13.5,
                              weight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${variant.duration} \u00b7 ${variant.includes}',
                        style: DvText.body(size: 12, color: DvColors.ink2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 9),
              ],
              DvCard(
                color: DvColors.line2,
                borderColor: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DvSectionLabel('What the price includes'),
                    const SizedBox(height: 9),
                    for (final line in const [
                      'Pandit dakshina and full ritual',
                      'Travel within 12 km of your address',
                      'Backup Pandit cover, at no extra cost',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check,
                              size: 15,
                              color: DvColors.green,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(line, style: DvText.body(size: 12.5)),
                            ),
                          ],
                        ),
                      ),
                    for (final line in const [
                      'Samagri \u2014 you choose who arranges it, next step',
                      'Flowers, fruit and prasad on the day',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.remove,
                              size: 15,
                              color: DvColors.ink3,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                line,
                                style: DvText.body(
                                  size: 12.5,
                                  color: DvColors.ink2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const DvBanner(
                title: 'Regional variations are respected',
                body:
                    'Maharashtrian, North Indian and Gujarati families do this differently. You pick your tradition in the next steps and the Pandit is matched to it.',
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
