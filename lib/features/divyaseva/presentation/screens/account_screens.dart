import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/dv_theme.dart';
import '../../../../core/widgets/dv_widgets.dart';
import '../../../../routes/routes.dart';
import '../../domain/entities/divyaseva_entities.dart';
import '../cubit/account_cubit.dart';
import '../cubit/async_status.dart';
import '../cubit/bookings_cubit.dart';

DvTone _toneFor(String tone) {
  switch (tone) {
    case 'green':
      return DvTone.green;
    case 'amber':
      return DvTone.amber;
    case 'kum':
      return DvTone.kum;
    default:
      return DvTone.neutral;
  }
}

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsCubit, BookingsState>(
      builder: (context, state) {
        return DvScaffold(
          title: 'My bookings',
          tab: 'bookings',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DvChipRow(
                children: [
                  for (final filter in const ['Upcoming', 'Past', 'Cancelled'])
                    DvChip(
                      filter,
                      selected: state.filter == filter,
                      onTap: () => context.read<BookingsCubit>().selectFilter(filter),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              if (state.status == AsyncStatus.loading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Center(child: CircularProgressIndicator(color: DvColors.kum)),
                )
              else
                for (final booking in state.bookings) ...[
                  _bookingCard(context, booking),
                  const SizedBox(height: 12),
                ],
            ],
          ),
        );
      },
    );
  }

  Widget _bookingCard(BuildContext context, DivyaBooking booking) {
    final active = booking.status == 'En route';
    final needsAction = booking.status == 'Action needed';
    return DvCard(
      borderColor: active
          ? DvColors.green
          : (needsAction ? const Color(0xFFF0DCB4) : DvColors.line),
      onTap: () {
        context.read<BookingsCubit>().select(booking.id);
        if (active) {
          context.go(Routes.trackingPath);
        } else if (needsAction) {
          context.go(Routes.backupPanditPath);
        } else {
          context.go(Routes.serviceRecordPath);
        }
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booking.service, style: DvText.body(size: 14.5, weight: FontWeight.w700)),
                    const SizedBox(height: 3),
                    Text(booking.when, style: DvText.mono(size: 11, color: DvColors.ink3)),
                  ],
                ),
              ),
              DvPill(
                active ? '\u25cf ${booking.status}' : booking.status,
                tone: _toneFor(booking.pillTone),
              ),
            ],
          ),
          const DvDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                active
                    ? 'Arriving in 6 minutes'
                    : (needsAction ? 'Pandit changed \u2014 confirm your backup' : 'View service record'),
                style: DvText.body(size: 12, color: DvColors.ink2),
              ),
              Text(
                active ? 'Track live \u203a' : (needsAction ? 'Review \u203a' : 'Open \u203a'),
                style: DvText.body(
                  size: 11.5,
                  weight: FontWeight.w700,
                  color: active
                      ? DvColors.green
                      : (needsAction ? DvColors.amber : DvColors.kum),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        return DvScaffold(
          title: 'Kulkarni Parivar',
          rightLabel: 'Invite',
          tab: 'family',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [DvColors.heroStart, DvColors.heroEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('FAMILY DHARMA ACCOUNT', style: DvText.eyebrow(color: DvColors.gold)),
                    const SizedBox(height: 5),
                    Text('Kulkarni Parivar', style: DvText.display(size: 23, color: Colors.white)),
                    const SizedBox(height: 3),
                    Text(
                      '${state.members.length} members \u00b7 2 shared addresses \u00b7 9 services since 2024',
                      style: DvText.body(size: 12, color: const Color(0xFFBDB5D6)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const DvSectionLabel('Members'),
              const SizedBox(height: 10),
              DvCard(
                child: Column(
                  children: [
                    for (var i = 0; i < state.members.length; i++) ...[
                      if (i > 0) const DvDivider(),
                      _member(state.members[i]),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const DvSectionLabel('Book on behalf of'),
              const SizedBox(height: 10),
              DvChipRow(
                children: const [
                  DvChip('Myself', selected: true),
                  DvChip('Aai & Baba, Dadar'),
                  DvChip('Manisha'),
                ],
              ),
              const SizedBox(height: 14),
              const DvBanner(
                tone: DvTone.green,
                icon: Icons.lock_outline,
                title: 'Private by default',
                body:
                    'Addresses are shared only when a member allows it. Birth details and horoscopes are never shared with the family \u2014 not even with the account owner.',
              ),
              const SizedBox(height: 16),
              const DvSectionLabel('Shared service history'),
              const SizedBox(height: 10),
              DvCard(
                color: DvColors.line2,
                borderColor: Colors.transparent,
                child: Text(
                  'Griha Pravesh (Sep 2026) \u00b7 Ganesh Puja (Sep 2025) \u00b7 Namkaran (Mar 2025) \u00b7 Satyanarayan (Nov 2024). Anyone in the family can rebook these in two taps.',
                  style: DvText.body(size: 12, color: DvColors.ink2),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _member(FamilyMember member) {
    final tone = member.role == 'Owner'
        ? DvTone.kum
        : (member.role == 'Elder' ? DvTone.brass : DvTone.neutral);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          DvAvatar(member.initials, size: 38, tone: tone),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(member.name, style: DvText.body(size: 13.5, weight: FontWeight.w700)),
                    const SizedBox(width: 6),
                    DvPill(member.role),
                  ],
                ),
                const SizedBox(height: 2),
                Text(member.subtitle, style: DvText.body(size: 12, color: DvColors.ink2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DvScaffold(
      title: 'Account',
      tab: 'account',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const DvAvatar('SK', size: 64),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sharad Kulkarni', style: DvText.display(size: 21)),
                    const SizedBox(height: 4),
                    Text('+91 98204 41207 \u00b7 Thane West', style: DvText.mono(size: 11, color: DvColors.ink3)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DvCard(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            child: Column(
              children: [
                _menuRow(Icons.person_outline, 'Personal details'),
                const DvDivider(),
                _menuRow(Icons.location_on_outlined, 'Addresses', trailing: '2 saved'),
                const DvDivider(),
                _menuRow(Icons.family_restroom, 'Family Dharma Account', onTap: () => context.go(Routes.familyPath)),
                const DvDivider(),
                _menuRow(Icons.currency_rupee, 'Payments & refunds'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          DvCard(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            child: Column(
              children: [
                _menuRow(Icons.translate, 'Language', trailing: 'English'),
                const DvDivider(),
                _menuRow(Icons.wb_sunny_outlined, 'Reminders & festival alerts'),
                const DvDivider(),
                _menuRow(Icons.lock_outline, 'Privacy & my data'),
                const DvDivider(),
                _menuRow(
                  Icons.mail_outline,
                  'Help & support',
                  trailing: '1 open',
                  onTap: () => context.go(Routes.supportPath),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          DvCard(
            color: DvColors.line2,
            borderColor: Colors.transparent,
            onTap: () => context.go(Routes.partnerDashboardPath),
            child: Row(
              children: [
                const Icon(Icons.description_outlined, size: 19, color: DvColors.ink2),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Are you a Pandit?', style: DvText.body(size: 13, weight: FontWeight.w700)),
                      const SizedBox(height: 3),
                      Text(
                        'Join DivyaSeva \u2014 set your own dakshina, get bookings near you, keep your calendar in one place.',
                        style: DvText.body(size: 12, color: DvColors.ink2),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: DvColors.ink3),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: Text(
              'DivyaSeva v1.0 \u00b7 Mumbai \u00b7 Thane \u00b7 Navi Mumbai',
              style: DvText.body(size: 12, color: DvColors.ink2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuRow(IconData icon, String label, {String? trailing, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Row(
          children: [
            Icon(icon, size: 19, color: DvColors.ink2),
            const SizedBox(width: 14),
            Expanded(child: Text(label, style: DvText.body(size: 13.5, weight: FontWeight.w600))),
            if (trailing != null) ...[
              Text(trailing, style: DvText.body(size: 12, color: DvColors.ink3)),
              const SizedBox(width: 6),
            ],
            const Icon(Icons.chevron_right, size: 18, color: DvColors.ink3),
          ],
        ),
      ),
    );
  }
}

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        final supportCase = state.supportCase;
        return DvScaffold(
          title: 'Help & support',
          backPath: Routes.accountPath,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DvCard(
                color: DvColors.kumSoft,
                borderColor: DvColors.kum,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.phone, size: 19, color: DvColors.kumDeep),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Service is today and something is wrong',
                                style: DvText.body(size: 13.5, weight: FontWeight.w700, color: DvColors.kumDeep),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Straight to a human in operations, no menu. Average pickup 40 seconds.',
                                style: DvText.body(size: 12, color: DvColors.kumDeep),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 11),
                    const DvButton(label: 'Call operations now', small: true),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const DvSectionLabel('Your open case'),
              const SizedBox(height: 10),
              if (supportCase != null)
                DvCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              supportCase.title,
                              style: DvText.body(size: 13.5, weight: FontWeight.w700),
                            ),
                          ),
                          DvPill(supportCase.status, tone: DvTone.amber),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(supportCase.reference, style: DvText.mono(size: 11, color: DvColors.ink3)),
                      const DvDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Response promised by', style: DvText.body(size: 12.5, color: DvColors.ink2)),
                          Text(supportCase.responseBy, style: DvText.mono(size: 12, weight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Likely outcome', style: DvText.body(size: 12.5, color: DvColors.ink2)),
                          Text(supportCase.outcome, style: DvText.body(size: 12.5, weight: FontWeight.w700)),
                        ],
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              const DvSectionLabel('Common topics'),
              const SizedBox(height: 10),
              DvCard(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                child: Column(
                  children: [
                    for (var i = 0; i < state.topics.length; i++) ...[
                      if (i > 0) const DvDivider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                state.topics[i],
                                style: DvText.body(size: 13.5, weight: FontWeight.w600),
                              ),
                            ),
                            const Icon(Icons.chevron_right, size: 18, color: DvColors.ink3),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const DvButton(label: 'Chat with support', variant: DvButtonVariant.ghost, small: true),
            ],
          ),
        );
      },
    );
  }
}
