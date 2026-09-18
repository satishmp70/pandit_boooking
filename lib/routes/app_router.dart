import 'package:go_router/go_router.dart';

import '../features/auth/presentation/screens/auth_screens.dart';
import '../features/auth/presentation/auth_access.dart';
import '../features/divyaseva/presentation/screens/account_screens.dart';
import '../features/divyaseva/presentation/screens/complete_screens.dart';
import '../features/divyaseva/presentation/screens/configure_screens.dart';
import '../features/divyaseva/presentation/screens/discover_screens.dart';
import '../features/divyaseva/presentation/screens/home_screen.dart';
import '../features/divyaseva/presentation/screens/match_screens.dart';
import '../features/divyaseva/presentation/screens/partner_screens.dart';
import '../features/divyaseva/presentation/screens/pay_screens.dart';
import '../features/divyaseva/presentation/screens/prepare_screens.dart';
import 'routes.dart';

class AppRouter {
  const AppRouter._();

  static GoRouter get router => GoRouter(
    initialLocation: Routes.splashPath,
    redirect: (context, state) {
      const publicPaths = {Routes.splashPath, Routes.loginPath, Routes.otpPath};
      final isPublic = publicPaths.contains(state.matchedLocation);
      if (!isPublic && !AuthAccess.isAuthenticated) return Routes.splashPath;
      if (state.matchedLocation == Routes.splashPath &&
          AuthAccess.isAuthenticated) {
        return Routes.homePath;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.splashPath,
        name: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.loginPath,
        name: Routes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.otpPath,
        name: Routes.otp,
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        path: Routes.homePath,
        name: Routes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: Routes.conciergePath,
        name: Routes.concierge,
        builder: (context, state) => const ConciergeScreen(),
      ),
      GoRoute(
        path: Routes.catalogPath,
        name: Routes.catalog,
        builder: (context, state) => const CatalogScreen(),
      ),
      GoRoute(
        path: Routes.servicePath,
        name: Routes.service,
        builder: (context, state) => const ServiceDetailScreen(),
      ),
      GoRoute(
        path: Routes.locationPath,
        name: Routes.location,
        builder: (context, state) => const LocationScreen(),
      ),
      GoRoute(
        path: Routes.whenPath,
        name: Routes.when,
        builder: (context, state) => const WhenScreen(),
      ),
      GoRoute(
        path: Routes.preferencesPath,
        name: Routes.preferences,
        builder: (context, state) => const PreferencesScreen(),
      ),
      GoRoute(
        path: Routes.samagriPath,
        name: Routes.samagri,
        builder: (context, state) => const SamagriScreen(),
      ),
      GoRoute(
        path: Routes.matchingPath,
        name: Routes.matching,
        builder: (context, state) => const MatchingScreen(),
      ),
      GoRoute(
        path: Routes.resultsPath,
        name: Routes.results,
        builder: (context, state) => const ResultsScreen(),
      ),
      GoRoute(
        path: Routes.panditPath,
        name: Routes.pandit,
        builder: (context, state) => const PanditProfileScreen(),
      ),
      GoRoute(
        path: Routes.quotePath,
        name: Routes.quote,
        builder: (context, state) => const QuoteScreen(),
      ),
      GoRoute(
        path: Routes.paymentPath,
        name: Routes.payment,
        builder: (context, state) => const PaymentScreen(),
      ),
      GoRoute(
        path: Routes.confirmedPath,
        name: Routes.confirmed,
        builder: (context, state) => const ConfirmedScreen(),
      ),
      GoRoute(
        path: Routes.bookingsPath,
        name: Routes.bookings,
        builder: (context, state) => const BookingsScreen(),
      ),
      GoRoute(
        path: Routes.bookingDetailPath,
        name: Routes.bookingDetail,
        builder: (context, state) => const BookingDetailScreen(),
      ),
      GoRoute(
        path: Routes.preparationPath,
        name: Routes.preparation,
        builder: (context, state) => const PreparationScreen(),
      ),
      GoRoute(
        path: Routes.trackingPath,
        name: Routes.tracking,
        builder: (context, state) => const TrackingScreen(),
      ),
      GoRoute(
        path: Routes.backupPanditPath,
        name: Routes.backupPandit,
        builder: (context, state) => const BackupPanditScreen(),
      ),
      GoRoute(
        path: Routes.serviceRecordPath,
        name: Routes.serviceRecord,
        builder: (context, state) => const ServiceRecordScreen(),
      ),
      GoRoute(
        path: Routes.reviewPath,
        name: Routes.review,
        builder: (context, state) => const ReviewScreen(),
      ),
      GoRoute(
        path: Routes.accountPath,
        name: Routes.account,
        builder: (context, state) => const AccountScreen(),
      ),
      GoRoute(
        path: Routes.familyPath,
        name: Routes.family,
        builder: (context, state) => const FamilyScreen(),
      ),
      GoRoute(
        path: Routes.supportPath,
        name: Routes.support,
        builder: (context, state) => const SupportScreen(),
      ),
      GoRoute(
        path: Routes.partnerDashboardPath,
        name: Routes.partnerDashboard,
        builder: (context, state) => const PartnerDashboardScreen(),
      ),
      GoRoute(
        path: Routes.partnerRequestPath,
        name: Routes.partnerRequest,
        builder: (context, state) => const PartnerRequestScreen(),
      ),
      GoRoute(
        path: Routes.partnerJobPath,
        name: Routes.partnerJob,
        builder: (context, state) => const PartnerJobScreen(),
      ),
    ],
  );
}
