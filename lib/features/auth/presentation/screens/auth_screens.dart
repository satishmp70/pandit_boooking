import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';

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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF0D0915),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF21173C),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2C205D), Color(0xFF21173C), Color(0xFF402345)],
              stops: [0, 0.56, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 24),
              child: Column(
                children: [
                  const Spacer(flex: 5),
                  const _SplashMark(),
                  const SizedBox(height: 16),
                  Text(
                    '\u0926\u093f\u0935\u094d\u092f\u0938\u0947\u0935\u093e',
                    style: DvText.body(
                      size: 20,
                      color: DvColors.gold,
                      spacing: 6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'DivyaSeva',
                    style: DvText.display(size: 38, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'A trusted Pandit, actually arranged for you.',
                    textAlign: TextAlign.center,
                    style: DvText.body(
                      size: 14,
                      color: const Color(0xFFC6BEDD),
                      height: 1.55,
                    ),
                  ),
                  const Spacer(flex: 6),
                  DvButton(
                    label: 'Get started',
                    onTap: () => context.go(Routes.loginPath),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Serving Mumbai \u00b7 Thane \u00b7 Navi Mumbai',
                    style: DvText.body(
                      size: 11.5,
                      color: const Color(0xFF8F87AB),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SplashMark extends StatelessWidget {
  const _SplashMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 86,
      height: 86,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: DvColors.gold, width: 1.1),
      ),
      child: Container(
        width: 72,
        height: 72,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: DvColors.gold.withAlpha(150), width: 1),
        ),
        child: const Icon(
          Icons.filter_vintage,
          color: Color(0xFFE27065),
          size: 40,
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _phoneController;

  static const _languages = [
    'English',
    '\u0939\u093f\u0902\u0926\u0940',
    '\u092e\u0930\u093e\u0920\u0940',
  ];

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: '98204 41207');
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return DvScaffold(
          backPath: Routes.splashPath,
          cta: DvButton(
            label: state.isBusy ? 'Sending\u2026' : 'Send OTP',
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              context.read<AuthBloc>().add(
                AuthOtpRequested('+91 ${_phoneController.text.trim()}'),
              );
              context.go(Routes.otpPath);
            },
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'Book a verified Pandit\nfor your home',
                style: DvText.display(size: 26),
              ),
              const SizedBox(height: 8),
              Text(
                'We will send a one-time code to confirm it is you. No password to remember.',
                style: DvText.body(size: 13.5, color: DvColors.ink2),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                style: DvText.mono(size: 14, weight: FontWeight.w600),
                decoration: InputDecoration(
                  labelText: 'Mobile number',
                  prefixText: '+91  ',
                  prefixStyle: DvText.mono(size: 14, color: DvColors.ink2),
                  suffixIcon: const Icon(Icons.verified, color: DvColors.green),
                  filled: true,
                  fillColor: DvColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: const BorderSide(color: DvColors.line),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: const BorderSide(
                      color: DvColors.kum,
                      width: 1.4,
                    ),
                  ),
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
                    const Icon(
                      Icons.family_restroom,
                      size: 20,
                      color: DvColors.ink2,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Booking for your parents?',
                            style: DvText.body(
                              size: 13,
                              weight: FontWeight.w700,
                            ),
                          ),
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

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final List<TextEditingController> _codeControllers;
  late final List<FocusNode> _codeFocusNodes;

  @override
  void initState() {
    super.initState();
    const demoCode = '492700';
    _codeControllers = [
      for (var i = 0; i < 6; i++) TextEditingController(text: demoCode[i]),
    ];
    _codeFocusNodes = [for (var i = 0; i < 6; i++) FocusNode()];
  }

  @override
  void dispose() {
    for (final controller in _codeControllers) {
      controller.dispose();
    }
    for (final node in _codeFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _code =>
      _codeControllers.map((controller) => controller.text).join();

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
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              context.read<AuthBloc>().add(AuthOtpSubmitted(_code));
            },
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text('Enter the 6-digit code', style: DvText.display(size: 26)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Sent to ',
                    style: DvText.body(size: 13.5, color: DvColors.ink2),
                  ),
                  Text(
                    state.phone,
                    style: DvText.mono(size: 13, weight: FontWeight.w600),
                  ),
                  Text(
                    ' \u00b7 ',
                    style: DvText.body(size: 13.5, color: DvColors.ink2),
                  ),
                  Text(
                    'Change',
                    style: DvText.body(
                      size: 13.5,
                      weight: FontWeight.w700,
                      color: DvColors.kum,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  for (var i = 0; i < 6; i++) ...[
                    if (i > 0) const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _codeControllers[i],
                        focusNode: _codeFocusNodes[i],
                        autofocus: i == 4,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: DvText.mono(size: 20, weight: FontWeight.w600),
                        onChanged: (value) {
                          if (value.isNotEmpty && i < 5) {
                            _codeFocusNodes[i + 1].requestFocus();
                          } else if (value.isEmpty && i > 0) {
                            _codeFocusNodes[i - 1].requestFocus();
                          }
                        },
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: DvColors.surface,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: DvColors.line),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: DvColors.kum,
                              width: 1.4,
                            ),
                          ),
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
                  Text(
                    'Did not get it?',
                    style: DvText.body(size: 12, color: DvColors.ink2),
                  ),
                  Text(
                    'Resend in 0:24',
                    style: DvText.mono(size: 12, color: DvColors.ink3),
                  ),
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
                          Text(
                            'Prefer to book by phone?',
                            style: DvText.body(
                              size: 13,
                              weight: FontWeight.w700,
                            ),
                          ),
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
