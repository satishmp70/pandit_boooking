import '../config/app_config.dart';
import '../network/api_client.dart';
import '../../features/payment/data/real_payment_repository.dart';
import '../../features/payment/domain/payment_repository.dart';
import '../../features/payment/presentation/payment_cubit.dart';
import '../../features/auth/data/datasources/auth_mock_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/repositories/real_auth_repository.dart';
import '../../features/auth/data/session_store.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/auth_usecases.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/auth_access.dart';
import '../../features/divyaseva/data/datasources/divyaseva_mock_datasource.dart';
import '../../features/divyaseva/data/booking_draft_store.dart';
import '../../features/divyaseva/data/repositories/divyaseva_repository_impl.dart';
import '../../features/divyaseva/data/repositories/real_booking_repository.dart';
import '../../features/divyaseva/domain/repositories/divyaseva_repository.dart';
import '../../features/divyaseva/domain/usecases/divyaseva_usecases.dart';
import '../../features/divyaseva/presentation/bloc/booking_bloc.dart';
import '../../features/divyaseva/presentation/cubit/account_cubit.dart';
import '../../features/divyaseva/presentation/cubit/booking_detail_cubit.dart';
import '../../features/divyaseva/presentation/cubit/bookings_cubit.dart';
import '../../features/divyaseva/presentation/cubit/catalog_cubit.dart';
import '../../features/divyaseva/presentation/cubit/pandit_match_cubit.dart';
import '../../features/divyaseva/presentation/cubit/partner_cubit.dart';
import '../../features/divyaseva/presentation/cubit/tracking_cubit.dart';

final sl = ServiceLocator();

void init({
  AppConfig? config,
  SessionStore? sessionStore,
  BookingDraftStore? draftStore,
}) {
  AuthAccess.isAuthenticated = false;
  final appConfig = config ?? AppConfig.fromEnvironment();
  sl.registerFactory<ApiClient>(
    () => const UnconfiguredApiClient(integration: 'API'),
  );
  sl.registerFactory<SessionStore>(() => sessionStore ?? MemorySessionStore());
  sl.registerFactory<BookingDraftStore>(
    () => draftStore ?? MemoryBookingDraftStore(),
  );

  // Data sources
  final divyaDataSource = DivyaSevaMockDataSource();
  final authDataSource = AuthMockDataSource(scenario: appConfig.mockScenario);

  // Repositories
  sl.registerFactory<DivyaSevaRepository>(() {
    return appConfig.bookingProvider == ProviderMode.real
        ? RealBookingRepository(sl<ApiClient>())
        : MockBookingRepository(divyaDataSource);
  });
  sl.registerFactory<AuthRepository>(() {
    return appConfig.authProvider == ProviderMode.real
        ? RealAuthRepository(sl<ApiClient>())
        : MockAuthRepository(authDataSource);
  });
  sl.registerFactory<PaymentRepository>(() {
    return appConfig.paymentProvider == ProviderMode.real
        ? RealPaymentRepository(sl<ApiClient>())
        : MockPaymentRepository(scenario: appConfig.mockScenario);
  });

  // Use cases
  final repo = sl<DivyaSevaRepository>();
  sl.registerFactory<GetServices>(() => GetServices(repo));
  sl.registerFactory<GetServiceDetail>(() => GetServiceDetail(repo));
  sl.registerFactory<GetVariants>(() => GetVariants(repo));
  sl.registerFactory<GetSamagriOptions>(() => GetSamagriOptions(repo));
  sl.registerFactory<GetMuhuratWindows>(() => GetMuhuratWindows(repo));
  sl.registerFactory<GetDateOptions>(() => GetDateOptions(repo));
  sl.registerFactory<GetStartTimes>(() => GetStartTimes(repo));
  sl.registerFactory<GetLanguages>(() => GetLanguages(repo));
  sl.registerFactory<GetTraditions>(() => GetTraditions(repo));
  sl.registerFactory<GetMatchedPandits>(() => GetMatchedPandits(repo));
  sl.registerFactory<GetPreparationChecklist>(
    () => GetPreparationChecklist(repo),
  );
  sl.registerFactory<GetBookings>(() => GetBookings(repo));
  sl.registerFactory<GetBookingSteps>(() => GetBookingSteps(repo));
  sl.registerFactory<GetTrackingSteps>(() => GetTrackingSteps(repo));
  sl.registerFactory<GetFamilyMembers>(() => GetFamilyMembers(repo));
  sl.registerFactory<GetSupportCase>(() => GetSupportCase(repo));
  sl.registerFactory<GetSupportTopics>(() => GetSupportTopics(repo));
  sl.registerFactory<GetPartnerDashboard>(() => GetPartnerDashboard(repo));
  sl.registerFactory<BuildQuote>(() => const BuildQuote());

  final authRepo = sl<AuthRepository>();
  sl.registerFactory<RequestOtp>(() => RequestOtp(authRepo));
  sl.registerFactory<VerifyOtp>(() => VerifyOtp(authRepo));

  // Blocs / Cubits
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      requestOtp: sl<RequestOtp>(),
      verifyOtp: sl<VerifyOtp>(),
      sessionStore: sl<SessionStore>(),
    ),
  );
  sl.registerFactory<BookingBloc>(
    () => BookingBloc(
      getServices: sl<GetServices>(),
      getVariants: sl<GetVariants>(),
      getSamagriOptions: sl<GetSamagriOptions>(),
      getMuhuratWindows: sl<GetMuhuratWindows>(),
      getDateOptions: sl<GetDateOptions>(),
      getStartTimes: sl<GetStartTimes>(),
      getLanguages: sl<GetLanguages>(),
      getTraditions: sl<GetTraditions>(),
      buildQuote: sl<BuildQuote>(),
      draftStore: sl<BookingDraftStore>(),
    ),
  );
  sl.registerFactory<CatalogCubit>(
    () => CatalogCubit(getServices: sl<GetServices>()),
  );
  sl.registerFactory<PanditMatchCubit>(
    () => PanditMatchCubit(getMatchedPandits: sl<GetMatchedPandits>()),
  );
  sl.registerFactory<BookingsCubit>(
    () => BookingsCubit(getBookings: sl<GetBookings>()),
  );
  sl.registerFactory<BookingDetailCubit>(
    () => BookingDetailCubit(
      getBookingSteps: sl<GetBookingSteps>(),
      getPreparationChecklist: sl<GetPreparationChecklist>(),
    ),
  );
  sl.registerFactory<TrackingCubit>(
    () => TrackingCubit(getTrackingSteps: sl<GetTrackingSteps>()),
  );
  sl.registerFactory<AccountCubit>(
    () => AccountCubit(
      getFamilyMembers: sl<GetFamilyMembers>(),
      getSupportCase: sl<GetSupportCase>(),
      getSupportTopics: sl<GetSupportTopics>(),
    ),
  );
  sl.registerFactory<PartnerCubit>(
    () => PartnerCubit(getPartnerDashboard: sl<GetPartnerDashboard>()),
  );
  sl.registerFactory<PaymentCubit>(() => PaymentCubit(sl<PaymentRepository>()));
}

class ServiceLocator {
  final _factories = <Type, Object Function()>{};

  void registerFactory<T extends Object>(T Function() factory) {
    _factories[T] = factory;
  }

  T call<T extends Object>() {
    final factory = _factories[T];
    if (factory == null) {
      throw StateError('$T is not registered');
    }
    return factory() as T;
  }
}
