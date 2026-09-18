import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/dv_theme.dart';
import '../../../../core/widgets/dv_widgets.dart';
import '../../../../routes/routes.dart';
import '../bloc/booking_bloc.dart';
import '../bloc/booking_state.dart';
import '../../../payment/presentation/payment_cubit.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final q = state.quote;
        return DvScaffold(
          title: 'Review and pay',
          backPath: Routes.panditPath,
          cta: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Price locked for ',
                        style: DvText.body(size: 12, color: DvColors.ink2),
                      ),
                      Text(
                        '09:52',
                        style: DvText.mono(size: 12, weight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Text(
                    '\u20b9${_money(q.total)}',
                    style: DvText.mono(size: 15, weight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 9),
              DvButton(
                label: 'Proceed to payment',
                onTap: () => context.go(Routes.paymentPath),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DvCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const DvAvatar('G'),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Griha Pravesh \u00b7 ${state.variant.name.replaceAll('Griha Pravesh', '').trim().isEmpty ? 'Standard' : state.variant.name.replaceAll('Griha Pravesh', '').trim()}',
                                style: DvText.body(
                                  size: 15,
                                  weight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Sat 12 Sep \u00b7 08:30\u201311:00 \u00b7 ${state.draft.muhurat}',
                                style: DvText.mono(
                                  size: 11,
                                  color: DvColors.ink3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const DvDivider(),
                    _row('Pandit', state.draft.panditName),
                    _row('Address', 'B-1204, Rustomjee Urbania'),
                    _row(
                      'Language / tradition',
                      '${state.draft.language} \u00b7 ${state.draft.tradition}',
                    ),
                    _row('Samagri', state.samagri.name),
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
                        DvSectionLabel('The complete price'),
                        DvPill('Nothing added later'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    DvMoneyRow(
                      label: '${state.variant.name} \u00b7 dakshina',
                      value: '\u20b9${_money(q.base)}',
                    ),
                    const DvMoneyRow(
                      label: 'Travel (within 12 km)',
                      value: 'Included',
                      valueColor: DvColors.green,
                    ),
                    DvMoneyRow(
                      label: state.samagri.name,
                      value: q.samagri == 0
                          ? '\u20b90'
                          : '\u20b9${_money(q.samagri)}',
                    ),
                    DvMoneyRow(
                      label: 'DivyaSeva platform fee',
                      value: '\u20b9${_money(q.platform)}',
                    ),
                    DvMoneyRow(
                      label: 'GST on platform fee (18%)',
                      value: '\u20b9${_money(q.gst)}',
                    ),
                    DvMoneyRow(
                      label: 'FIRSTPUJA discount',
                      value: '\u2212 \u20b9${_money(q.discount)}',
                      discount: true,
                    ),
                    const DvDivider(),
                    DvMoneyRow(
                      label: 'Total payable',
                      value: '\u20b9${_money(q.total)}',
                      total: true,
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Why this price?',
                            style: DvText.body(
                              size: 13,
                              weight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Pandit sets his own dakshina. DivyaSeva adds a flat platform fee, never a hidden margin on his fee.',
                            style: DvText.body(size: 12, color: DvColors.ink2),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: DvColors.ink3),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              DvCard(
                color: DvColors.amberSoft,
                borderColor: const Color(0xFFF0DCB4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CANCELLATION POLICY \u2014 SAVED WITH THIS BOOKING',
                      style: DvText.eyebrow(color: DvColors.amber),
                    ),
                    const SizedBox(height: 9),
                    _policy('Cancel before Thu 10 Sep, 08:30', 'Full refund'),
                    _policy('Before Fri 11 Sep, 20:30', '50% refund'),
                    _policy('After that', 'No refund'),
                    _policy('If the Pandit cancels', 'Backup, or 100% back'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _row(String label, String value) {
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
              style: DvText.body(size: 12.5, weight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _policy(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: DvText.body(size: 12.5, color: DvColors.amberText),
            ),
          ),
          Text(
            value,
            style: DvText.body(
              size: 12.5,
              weight: FontWeight.w700,
              color: DvColors.amberText,
            ),
          ),
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

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final q = state.quote;
        final part = (q.total * 0.2).round();
        final payment = context.watch<PaymentCubit>().state;
        return DvScaffold(
          title: 'Payment',
          backPath: Routes.quotePath,
          cta: DvButton(
            label: payment.status == PaymentFlowStatus.processing
                ? 'Verifying payment…'
                : 'Pay \u20b9${_money(_selected == 2 ? part : q.total)}',
            onTap: payment.status == PaymentFlowStatus.processing
                ? null
                : () async {
                    final paid = await context.read<PaymentCubit>().pay(
                      amount: _selected == 2 ? part : q.total,
                      method: _selected == 0
                          ? 'upi'
                          : (_selected == 1 ? 'card' : 'deposit'),
                      reference: 'DV-PB-24817',
                    );
                    if (paid && context.mounted) {
                      context.go(Routes.confirmedPath);
                    }
                  },
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DvBanner(
                icon: Icons.access_time,
                title: 'Pandit Suresh and your 08:30 slot are held',
                body:
                    'Reservation expires in 09:41. Nobody else can take this slot until then.',
              ),
              const SizedBox(height: 16),
              const DvSectionLabel('Pay with'),
              const SizedBox(height: 10),
              _option(
                0,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'UPI',
                          style: DvText.body(
                            size: 13.5,
                            weight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'sharad@okhdfc',
                          style: DvText.mono(size: 11, color: DvColors.ink2),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Instant confirmation',
                      style: DvText.body(size: 12, color: DvColors.ink2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 9),
              _option(
                1,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card',
                      style: DvText.body(size: 13.5, weight: FontWeight.w700),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Visa \u2022\u2022\u2022\u2022 4417',
                      style: DvText.body(size: 12, color: DvColors.ink2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 9),
              _option(
                2,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pay 20% now',
                          style: DvText.body(
                            size: 13.5,
                            weight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '\u20b9${_money(part)}',
                          style: DvText.mono(size: 13, weight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Balance \u20b9${_money(q.total - part)} after the ceremony is completed',
                      style: DvText.body(size: 12, color: DvColors.ink2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              DvCard(
                color: DvColors.line2,
                borderColor: Colors.transparent,
                child: DvMoneyRow(
                  label: 'Paying now',
                  value: '\u20b9${_money(_selected == 2 ? part : q.total)}',
                  total: true,
                ),
              ),
              const SizedBox(height: 14),
              const DvBanner(
                tone: DvTone.green,
                icon: Icons.lock_outline,
                title: 'Confirmed by our server, not by your screen',
                body:
                    'Your booking is created only after the payment gateway confirms it to us directly. If the network drops, we reconcile and either confirm or refund \u2014 you are never charged for a booking that does not exist.',
              ),
              if (payment.status == PaymentFlowStatus.failure) ...[
                const SizedBox(height: 12),
                DvBanner(
                  tone: DvTone.kum,
                  icon: Icons.error_outline,
                  title: 'Payment not completed',
                  body: payment.message ?? 'Please try again.',
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _option(int index, Widget child) {
    return DvOptionRow(
      selected: _selected == index,
      onTap: () => setState(() => _selected = index),
      child: child,
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

class ConfirmedScreen extends StatelessWidget {
  const ConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final q = state.quote;
        return DvScaffold(
          bottomPadding: 30,
          cta: Column(
            children: [
              DvButton(
                label: 'View booking',
                onTap: () => context.go(Routes.bookingDetailPath),
              ),
              const SizedBox(height: 9),
              DvButton(
                label: 'Open preparation checklist',
                variant: DvButtonVariant.ghost,
                small: true,
                onTap: () => context.go(Routes.preparationPath),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 14),
              Container(
                width: 74,
                height: 74,
                decoration: BoxDecoration(
                  color: DvColors.greenSoft,
                  shape: BoxShape.circle,
                  border: Border.all(color: DvColors.green, width: 2),
                ),
                child: const Icon(Icons.check, size: 34, color: DvColors.green),
              ),
              const SizedBox(height: 16),
              Text('Your Pandit is booked', style: DvText.display(size: 26)),
              const SizedBox(height: 6),
              Text(
                'Pandit ${state.draft.panditName} has accepted. You will meet him on Saturday.',
                textAlign: TextAlign.center,
                style: DvText.body(size: 13.5, color: DvColors.ink2),
              ),
              const SizedBox(height: 12),
              Text(
                'BOOKING DV-PB-24817',
                style: DvText.mono(size: 12, color: DvColors.ink3),
              ),
              const SizedBox(height: 18),
              DvCard(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Griha Pravesh',
                          style: DvText.body(
                            size: 14.5,
                            weight: FontWeight.w700,
                          ),
                        ),
                        const DvPill('Confirmed', tone: DvTone.green),
                      ],
                    ),
                    const DvDivider(),
                    _row('When', 'Sat 12 Sep \u00b7 08:30', mono: true),
                    _row('Where', 'B-1204, Rustomjee Urbania'),
                    _row('Paid', '\u20b9${_money(q.total)}', mono: true),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const DvSectionLabel('What happens next'),
              const SizedBox(height: 10),
              DvCard(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 6),
                child: Column(
                  children: const [
                    DvStepRow(
                      title: 'Preparation checklist sent',
                      subtitle: 'Just now \u00b7 11 things to keep ready',
                      state: DvStepState.done,
                    ),
                    DvStepRow(
                      title: 'Samagri kit delivered',
                      subtitle: 'Fri 11 Sep, before 19:00',
                    ),
                    DvStepRow(
                      title: 'Reminder + Pandit contact shared',
                      subtitle: 'Fri 11 Sep, 18:00',
                    ),
                    DvStepRow(
                      title: 'Live tracking on the day',
                      subtitle: 'Sat 12 Sep, from 07:30',
                      last: true,
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

  Widget _row(String label, String value, {bool mono = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: DvText.body(size: 12.5, color: DvColors.ink2)),
          Text(
            value,
            style: mono
                ? DvText.mono(size: 12.5, weight: FontWeight.w600)
                : DvText.body(size: 12.5, weight: FontWeight.w700),
          ),
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
