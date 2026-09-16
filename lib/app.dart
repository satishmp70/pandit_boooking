import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection_container.dart';
import 'core/theme/dv_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/divyaseva/presentation/bloc/booking_bloc.dart';
import 'features/divyaseva/presentation/bloc/booking_event.dart';
import 'features/divyaseva/presentation/cubit/account_cubit.dart';
import 'features/divyaseva/presentation/cubit/booking_detail_cubit.dart';
import 'features/divyaseva/presentation/cubit/bookings_cubit.dart';
import 'features/divyaseva/presentation/cubit/catalog_cubit.dart';
import 'features/divyaseva/presentation/cubit/pandit_match_cubit.dart';
import 'features/divyaseva/presentation/cubit/partner_cubit.dart';
import 'features/divyaseva/presentation/cubit/tracking_cubit.dart';
import 'routes/app_router.dart';

class DivyaSevaApp extends StatelessWidget {
  const DivyaSevaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<BookingBloc>()..add(const BookingStarted())),
        BlocProvider(create: (_) => sl<CatalogCubit>()),
        BlocProvider(create: (_) => sl<PanditMatchCubit>()),
        BlocProvider(create: (_) => sl<BookingsCubit>()),
        BlocProvider(create: (_) => sl<BookingDetailCubit>()),
        BlocProvider(create: (_) => sl<TrackingCubit>()),
        BlocProvider(create: (_) => sl<AccountCubit>()),
        BlocProvider(create: (_) => sl<PartnerCubit>()),
      ],
      child: MaterialApp.router(
        title: 'DivyaSeva',
        theme: DvTheme.light,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
