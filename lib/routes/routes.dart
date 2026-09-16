/// Route names and paths for the DivyaSeva app.
class Routes {
  const Routes._();

  // Auth
  static const splash = 'splash';
  static const login = 'login';
  static const otp = 'otp';

  // Discover
  static const home = 'home';
  static const concierge = 'concierge';
  static const catalog = 'catalog';
  static const service = 'service';

  // Booking wizard
  static const location = 'location';
  static const when = 'when';
  static const preferences = 'preferences';
  static const samagri = 'samagri';

  // Matching
  static const matching = 'matching';
  static const results = 'results';
  static const pandit = 'pandit';

  // Confirm & pay
  static const quote = 'quote';
  static const payment = 'payment';
  static const confirmed = 'confirmed';

  // Bookings
  static const bookings = 'bookings';
  static const bookingDetail = 'bookingDetail';
  static const preparation = 'preparation';
  static const tracking = 'tracking';
  static const backupPandit = 'backupPandit';
  static const serviceRecord = 'serviceRecord';
  static const review = 'review';

  // Account
  static const account = 'account';
  static const family = 'family';
  static const support = 'support';

  // Partner (Pandit portal)
  static const partnerDashboard = 'partnerDashboard';
  static const partnerRequest = 'partnerRequest';
  static const partnerJob = 'partnerJob';

  // Paths
  static const splashPath = '/';
  static const loginPath = '/login';
  static const otpPath = '/otp';

  static const homePath = '/home';
  static const conciergePath = '/concierge';
  static const catalogPath = '/catalog';
  static const servicePath = '/service';

  static const locationPath = '/book/location';
  static const whenPath = '/book/when';
  static const preferencesPath = '/book/preferences';
  static const samagriPath = '/book/samagri';

  static const matchingPath = '/book/matching';
  static const resultsPath = '/book/results';
  static const panditPath = '/book/pandit';

  static const quotePath = '/book/quote';
  static const paymentPath = '/book/payment';
  static const confirmedPath = '/book/confirmed';

  static const bookingsPath = '/bookings';
  static const bookingDetailPath = '/bookings/detail';
  static const preparationPath = '/bookings/preparation';
  static const trackingPath = '/bookings/tracking';
  static const backupPanditPath = '/bookings/backup';
  static const serviceRecordPath = '/bookings/record';
  static const reviewPath = '/bookings/review';

  static const accountPath = '/account';
  static const familyPath = '/account/family';
  static const supportPath = '/account/support';

  static const partnerDashboardPath = '/partner';
  static const partnerRequestPath = '/partner/request';
  static const partnerJobPath = '/partner/job';
}
