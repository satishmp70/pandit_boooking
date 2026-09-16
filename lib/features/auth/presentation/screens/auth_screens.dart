import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/dv_theme.dart';
import '../../../../core/widgets/dv_widgets.dart';
import '../../../../routes/routes.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2A2352), Color(0xFF1A1636), Color(0xFF3C2140)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 86,
                height: 86,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: DvColors.gold, width: 1),
                ),
                child: const Icon(Icons.filter_vintage, color: Color(0xFFE27065), size: 40),
              ),
              const SizedBox(height: 16),
              Text(
                '\u0926\u093f\u0935\u094d\u092f\u0938\u0947\u0935\u093e',
                style: DvText.body(size: 20, color: DvColors.gold, spacing: 6),
              ),
              const SizedBox(height: 6),
              Text('DivyaSeva', style: DvText.display(size: 38, color: Colors.white)),
              const SizedBox(height: 10),
              Text(
                'A trusted Pandit, actually arranged for you.',
                textAlign: TextAlign.center,
                style: DvText.body(size: 14, color: const Color(0xFFC6BEDD), height: 1.55),
              ),
              const Spacer(),
              DvButton(label: 'Get started', onTap: () => context.go(Routes.loginPath)),
              const SizedBox(height: 14),
              Text(
                'Serving Mumbai \u00b7 Thane \u00b7 Navi Mumbai',
                style: DvText.body(size: 11.5, color: const Color(0xFF8F87AB)),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const _languages = ['English', '\u0939\u093f\u0902\u0926\u0940', '\u092e\u0930\u093e\u0920\u0940'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return DvScaffold(
          backPath: Routes.splashPath,
          cta: DvButton(
            label: state.isBusy ? 'Sending\u2026' : 'Send OTP',
            onTap: () {
              context.read<AuthBloc>().add(AuthOtpRequested(state.phone));
              context.go(Routes.otpPath);
            },
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text('Book a verified Pandit\nfor your home', style: DvText.display(size: 26)),
              const SizedBox(height: 8),
              Text(
                'We will send a one-time code to confirm it is you. No password to remember.',
                style: DvText.body(size: 13.5, color: DvColors.ink2),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                decoration: BoxDecoration(
                  color: DvColors.surface,
                  border: Border.all(color: DvColors.kum, width: 1.4),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mobile number', style: DvText.eyebrow()),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('+91', style: DvText.mono(size: 14, color: DvColors.ink2)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text('98204 41207', style: DvText.mono(size: 14, weight: FontWeight.w600)),
                        ),
                        const DvPill('\u2713', tone: DvTone.green),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              DvChipRow(
                children: [
                  for (var i = 0; i < _languages.length; i++)
                    DvChip(_languages[i], selected: i == 0),
                ],
              ),
              const SizedBox(height: 16),
              DvCard(
                color: DvColors.line2,
                borderColor: Colors.transparent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.family_restroom, size: 20, color: DvColors.ink2),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Booking for your parents?', style: DvText.body(size: 13, weight: FontWeight.w700)),
                          const SizedBox(height: 3),
                          Text(
                            'Add them to a Family Dharma Account after login \u2014 you pay, they receive the service.',
                            style: DvText.body(size: 12, color: DvColors.ink2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              Center(
                child: Text(
                  'By continuing you agree to the Terms and Privacy Policy.\nBirth and horoscope details always stay private to you.',
                  textAlign: TextAlign.center,
                  style: DvText.body(size: 11.5, color: DvColors.ink3),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.go(Routes.homePath);
        }
      },
      builder: (context, state) {
        return DvScaffold(
          backPath: Routes.loginPath,
          cta: DvButton(
            label: state.isBusy ? 'Verifying\u2026' : 'Verify and continue',
            onTap: () => context.read<AuthBloc>().add(const AuthOtpSubmitted('492700')),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text('Enter the 6-digit code', style: DvText.display(size: 26)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text('Sent to ', style: DvText.body(size: 13.5, color: DvColors.ink2)),
                  Text(state.phone, style: DvText.mono(size: 13, weight: FontWeight.w600)),
                  Text(' \u00b7 ', style: DvText.body(size: 13.5, color: DvColors.ink2)),
                  Text('Change', style: DvText.body(size: 13.5, weight: FontWeight.w700, color: DvColors.kum)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  for (var i = 0; i < 6; i++) ...[
                    if (i > 0) const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: DvColors.surface,
                          border: Border.all(
                            color: i < 4 ? DvColors.kum : DvColors.line,
                            width: 1.4,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          i < 4 ? '4927'[i] : '',
                          style: DvText.mono(size: 20, weight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              if (state.status == AuthStatus.failure) ...[
                const SizedBox(height: 10),
                Text(
                  state.error ?? 'Something went wrong',
                  style: DvText.body(size: 12, color: DvColors.kum),
                ),
              ],
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Did not get it?', style: DvText.body(size: 12, color: DvColors.ink2)),
                  Text('Resend in 0:24', style: DvText.mono(size: 12, color: DvColors.ink3)),
                ],
              ),
              const DvDivider(),
              DvCard(
                color: DvColors.line2,
                borderColor: Colors.transparent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.phone, size: 20, color: DvColors.ink2),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Prefer to book by phone?', style: DvText.body(size: 13, weight: FontWeight.w700)),
                          const SizedBox(height: 3),
                          Text(
                            'Call 1800-000-000 and our team will arrange the Pandit for you. Useful for elders.',
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
}
