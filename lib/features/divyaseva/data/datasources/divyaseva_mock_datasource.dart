import '../../domain/entities/divyaseva_entities.dart';

/// In-memory mock data for the DivyaSeva app. Swapping in a network-backed
/// implementation only requires replacing this class.
class DivyaSevaMockDataSource {
  const DivyaSevaMockDataSource();

  static const _variants = <ServiceVariant>[
    ServiceVariant(
      id: 'std',
      name: 'Standard Griha Pravesh',
      duration: '2 hr 30 min',
      price: 5100,
      includes: 'Kalash sthapana, Ganesh puja, Vastu shanti sankalp, aarti',
    ),
    ServiceVariant(
      id: 'havan',
      name: 'With Havan',
      duration: '3 hr 45 min',
      price: 7600,
      includes: 'Everything in Standard + havan kund ritual and purnahuti',
    ),
    ServiceVariant(
      id: 'ext',
      name: 'Extended (Vastu Shanti)',
      duration: '5 hr',
      price: 9200,
      includes: 'Havan + Navagraha shanti + full Vastu puja',
    ),
  ];

  static const _services = <DivyaService>[
    DivyaService(
      id: 'griha-pravesh',
      name: 'Griha Pravesh',
      devanagari: '\u0917\u0943\u0939 \u092a\u094d\u0930\u0935\u0947\u0936',
      description:
          'The ceremony performed before a family first occupies a new home '
          '\u2014 kalash sthapana, Ganesh puja and a Vastu sankalp for the space.',
      fromPrice: 5100,
      duration: '2 hr 30 min',
      category: 'Home & property',
      variants: _variants,
      panditsNearby: 18,
      rating: 4.8,
      completed: 340,
    ),
    DivyaService(
      id: 'bhumi-pujan',
      name: 'Bhumi Pujan',
      devanagari: '\u092d\u0942\u092e\u093f \u092a\u0942\u091c\u0928',
      description: 'Ground-breaking ceremony before construction begins.',
      fromPrice: 6400,
      duration: '3 hr',
      category: 'Home & property',
      variants: _variants,
      panditsNearby: 11,
      rating: 4.7,
      completed: 120,
    ),
    DivyaService(
      id: 'office-opening',
      name: 'Office / shop opening',
      devanagari: '',
      description: 'Opening ceremony for a new workplace or shop.',
      fromPrice: 4600,
      duration: '1 hr 30 min',
      category: 'Home & property',
      variants: _variants,
      panditsNearby: 9,
      rating: 4.6,
      completed: 86,
    ),
    DivyaService(
      id: 'vastu-shanti',
      name: 'Vastu Shanti (standalone)',
      devanagari: '',
      description: 'Standalone Vastu shanti ritual.',
      fromPrice: 9200,
      duration: '5 hr',
      category: 'Home & property',
      variants: _variants,
      panditsNearby: 0,
      rating: 4.8,
      completed: 42,
      available: false,
    ),
    DivyaService(
      id: 'satyanarayan',
      name: 'Satyanarayan Puja',
      devanagari:
          '\u0938\u0924\u094d\u092f\u0928\u093e\u0930\u093e\u092f\u0923',
      description: 'Vrat and katha performed for family wellbeing.',
      fromPrice: 4400,
      duration: '2 hr',
      category: 'Common pujas',
      variants: _variants,
      panditsNearby: 22,
      rating: 4.8,
      completed: 510,
    ),
    DivyaService(
      id: 'ganesh-puja',
      name: 'Ganesh Puja',
      devanagari: '\u0917\u0923\u0947\u0936 \u092a\u0942\u091c\u093e',
      description: 'Ganesh sthapana and puja for auspicious beginnings.',
      fromPrice: 3800,
      duration: '1 hr 30 min',
      category: 'Common pujas',
      variants: _variants,
      panditsNearby: 26,
      rating: 4.7,
      completed: 640,
    ),
    DivyaService(
      id: 'lakshmi-puja',
      name: 'Lakshmi Puja',
      devanagari:
          '\u0932\u0915\u094d\u0937\u094d\u092e\u0940 \u092a\u0942\u091c\u093e',
      description: 'Invoking Lakshmi for prosperity and wellbeing at home.',
      fromPrice: 4200,
      duration: '2 hr',
      category: 'Common pujas',
      variants: _variants,
      panditsNearby: 24,
      rating: 4.7,
      completed: 380,
    ),
    DivyaService(
      id: 'havan',
      name: 'Havan',
      devanagari: '\u0939\u0935\u0928',
      description: 'Fire ritual with a dedicated havan kund and purnahuti.',
      fromPrice: 5600,
      duration: '3 hr',
      category: 'Common pujas',
      variants: _variants,
      panditsNearby: 15,
      rating: 4.8,
      completed: 290,
    ),
  ];

  static const _pandits = <Pandit>[
    Pandit(
      initials: 'SJ',
      name: 'Suresh Joshi',
      experience: '14 years',
      area: 'Majiwada, Thane West',
      distanceKm: 4.2,
      price: 5100,
      languages: 'Marathi \u00b7 Sanskrit',
      onTime: 98,
      completed: 212,
      rating: 4.8,
      noShows: 0,
      reliability: 'High reliability',
    ),
    Pandit(
      initials: 'RD',
      name: 'Rameshwar Dixit',
      experience: '22 years',
      area: 'Ghodbunder',
      distanceKm: 8.9,
      price: 5600,
      languages: 'Marathi \u00b7 Hindi',
      onTime: 96,
      completed: 480,
      rating: 4.7,
      noShows: 0,
      reliability: 'High reliability',
    ),
    Pandit(
      initials: 'AK',
      name: 'Anand Kale',
      experience: '6 years',
      area: 'Vartak Nagar',
      distanceKm: 3.1,
      price: 4700,
      languages: 'Marathi',
      onTime: 94,
      completed: 14,
      rating: 4.5,
      noShows: 0,
      reliability: 'New on DivyaSeva',
    ),
  ];

  Future<T> _resolve<T>(T value) async => value;

  Future<List<DivyaService>> getServices() => _resolve(_services);

  Future<DivyaService> getServiceDetail(String id) => _resolve(
    _services.firstWhere((s) => s.id == id, orElse: () => _services.first),
  );

  Future<List<ServiceVariant>> getVariants(String serviceId) => _resolve(
    _services
        .firstWhere((s) => s.id == serviceId, orElse: () => _services.first)
        .variants,
  );

  Future<List<SamagriOption>> getSamagriOptions() => _resolve(const [
    SamagriOption(
      id: 'self',
      name: 'I will arrange it',
      description: 'You get a printed checklist of 34 items',
      price: 0,
    ),
    SamagriOption(
      id: 'kit',
      name: 'DivyaSeva Samagri Kit',
      description: '34 items, delivered the morning before',
      price: 1450,
    ),
    SamagriOption(
      id: 'pandit',
      name: 'Pandit brings everything',
      description: 'Included in his package, billed as one line',
      price: 900,
    ),
  ]);

  Future<List<MuhuratWindow>> getMuhuratWindows() => _resolve(const [
    MuhuratWindow(
      name: 'Amrit Kaal',
      range: '07:12 \u2013 11:04',
      availability: '18 Pandits free',
      recommended: true,
    ),
    MuhuratWindow(
      name: 'Abhijit Muhurat',
      range: '12:06 \u2013 12:54',
      availability: '6 Pandits free',
      recommended: true,
    ),
    MuhuratWindow(
      name: 'Rahu Kaal',
      range: '09:18 \u2013 10:48',
      availability: 'Generally avoided',
      recommended: false,
    ),
  ]);

  Future<List<String>> getDateOptions() => _resolve(const [
    'Today',
    'Thu 10',
    'Fri 11',
    'Sat 12 Sep',
    'Sun 13',
    'Mon 14',
  ]);

  Future<List<String>> getStartTimes() =>
      _resolve(const ['07:30', '08:30', '09:30', '10:00']);

  Future<List<String>> getLanguages() => _resolve(const [
    'Marathi',
    'Hindi',
    'Sanskrit + Hindi',
    'Gujarati',
    'English explanation',
  ]);

  Future<List<String>> getTraditions() => _resolve(const [
    'Maharashtrian',
    'North Indian',
    'Gujarati',
    'South Indian',
    'Not sure',
  ]);

  Future<List<Pandit>> getMatchedPandits() => _resolve(_pandits);

  Future<List<PrepItem>> getPreparationChecklist() => _resolve(const [
    PrepItem(label: 'Clean the puja space, east or north facing', done: true),
    PrepItem(label: 'Low table (chowki) and a clean cloth', done: true),
    PrepItem(label: 'Chair for Aaji, near the space', done: true),
    PrepItem(label: '1 litre fresh milk', done: false),
    PrepItem(label: 'Flowers, tulsi and 5 seasonal fruits', done: false),
    PrepItem(label: 'Prasad for the number of guests', done: false),
    PrepItem(
      label: 'Lift and parking access informed to security',
      done: false,
    ),
  ]);

  Future<List<DivyaBooking>> getBookings() => _resolve(const [
    DivyaBooking(
      id: 'DV-PB-24817',
      service: 'Griha Pravesh',
      when: 'Sat 12 Sep \u00b7 08:30 \u00b7 Suresh Joshi',
      pandit: 'Suresh Joshi',
      status: 'En route',
      pillTone: 'green',
    ),
    DivyaBooking(
      id: 'DV-PB-24902',
      service: 'Satyanarayan Puja',
      when: 'Sun 28 Sep \u00b7 10:00 \u00b7 Dadar',
      pandit: 'Rameshwar Dixit',
      status: 'Action needed',
      pillTone: 'amber',
    ),
    DivyaBooking(
      id: 'DV-PB-22110',
      service: 'Ganesh Puja',
      when: '17 Sep 2025 \u00b7 Anand Kale',
      pandit: 'Anand Kale',
      status: 'Completed',
      pillTone: 'neutral',
    ),
    DivyaBooking(
      id: 'DV-PB-21004',
      service: 'Namkaran',
      when: '04 Mar 2025 \u00b7 Suresh Joshi',
      pandit: 'Suresh Joshi',
      status: 'Completed',
      pillTone: 'neutral',
    ),
  ]);

  Future<List<BookingStep>> getBookingSteps() => _resolve(const [
    BookingStep(
      title: 'Booking confirmed',
      subtitle: '02 Sep \u00b7 18:12',
      state: StepState.done,
    ),
    BookingStep(
      title: 'Pandit assigned & accepted',
      subtitle: '02 Sep \u00b7 18:14 \u00b7 Suresh Joshi',
      state: StepState.done,
    ),
    BookingStep(
      title: 'Preparation',
      subtitle: '7 of 11 ready \u00b7 kit arrives 11 Sep',
      state: StepState.now,
    ),
    BookingStep(
      title: 'En route',
      subtitle: 'Expected 12 Sep \u00b7 07:50',
      state: StepState.idle,
    ),
    BookingStep(
      title: 'Arrived',
      subtitle: 'Expected 08:20',
      state: StepState.idle,
    ),
    BookingStep(
      title: 'In service',
      subtitle: '08:30 \u2013 11:00',
      state: StepState.idle,
    ),
    BookingStep(
      title: 'Completed & receipt',
      subtitle: 'Record shared with you',
      state: StepState.idle,
    ),
  ]);

  Future<List<BookingStep>> getTrackingSteps() => _resolve(const [
    BookingStep(
      title: 'Accepted',
      subtitle: '02 Sep \u00b7 18:14',
      state: StepState.done,
    ),
    BookingStep(
      title: 'Kit delivered',
      subtitle: '11 Sep \u00b7 17:40',
      state: StepState.done,
    ),
    BookingStep(
      title: 'En route',
      subtitle: 'Today \u00b7 08:04',
      state: StepState.now,
    ),
    BookingStep(
      title: 'Arrived \u00b7 then service starts',
      subtitle: 'Expected 08:22',
      state: StepState.idle,
    ),
  ]);

  Future<List<FamilyMember>> getFamilyMembers() => _resolve(const [
    FamilyMember(
      initials: 'SK',
      name: 'Sharad Kulkarni',
      role: 'Owner',
      subtitle: 'Books and pays \u00b7 sees everything',
    ),
    FamilyMember(
      initials: 'MK',
      name: 'Manisha Kulkarni',
      role: 'Member',
      subtitle: 'Can book \u00b7 shares Thane address',
    ),
    FamilyMember(
      initials: 'VK',
      name: 'Vasant Kulkarni',
      role: 'Elder',
      subtitle: 'Receives the service \u00b7 does not need the app',
    ),
    FamilyMember(
      initials: 'SK',
      name: 'Sunanda Kulkarni',
      role: 'Elder',
      subtitle: 'Receives the service \u00b7 call-only updates',
    ),
  ]);

  Future<SupportCase> getSupportCase() => _resolve(
    const SupportCase(
      title: 'Samagri kit missing 2 items',
      reference: 'SC-4412 \u00b7 raised 12 Sep 11:20',
      status: 'Under review',
      responseBy: '13 Sep, 11:20',
      outcome: 'Refund of \u20b9120 to source',
    ),
  );

  Future<List<String>> getSupportTopics() => _resolve(const [
    'Reschedule or cancel a booking',
    'Pandit did not arrive',
    'Refund status',
    'Change address or time',
    'Report a Pandit\u2019s conduct',
  ]);

  Future<PartnerDashboard> getPartnerDashboard() => _resolve(
    const PartnerDashboard(
      jobsToday: 2,
      weekEarnings: '\u20b918.4k',
      onTime: 98,
      jobs: [
        PartnerJob(
          title: 'Satyanarayan Puja',
          detail: '10:00 \u00b7 Vartak Nagar \u00b7 3.1 km',
          badge: 'Next',
          badgeTone: 'green',
        ),
        PartnerJob(
          title: 'Rudrabhishek',
          detail: '17:30 \u00b7 Ghodbunder \u00b7 9.4 km',
          badge: 'Later',
          badgeTone: 'neutral',
        ),
      ],
    ),
  );
}
