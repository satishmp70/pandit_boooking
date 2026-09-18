import '../../../../core/errors/app_exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/divyaseva_entities.dart';
import '../../domain/repositories/divyaseva_repository.dart';

/// Real booking boundary. Concrete endpoint contracts must be supplied by the backend team.
class RealBookingRepository implements DivyaSevaRepository {
  const RealBookingRepository(this._client);

  final ApiClient _client;

  ApiClient get client => _client;

  Future<T> _blocked<T>() async {
    throw const IntegrationNotConfiguredException('Booking API');
  }

  @override
  Future<List<DivyaService>> getServices() => _blocked();
  @override
  Future<DivyaService> getServiceDetail(String id) => _blocked();
  @override
  Future<List<ServiceVariant>> getVariants(String serviceId) => _blocked();
  @override
  Future<List<SamagriOption>> getSamagriOptions() => _blocked();
  @override
  Future<List<MuhuratWindow>> getMuhuratWindows() => _blocked();
  @override
  Future<List<String>> getDateOptions() => _blocked();
  @override
  Future<List<String>> getStartTimes() => _blocked();
  @override
  Future<List<String>> getLanguages() => _blocked();
  @override
  Future<List<String>> getTraditions() => _blocked();
  @override
  Future<List<Pandit>> getMatchedPandits() => _blocked();
  @override
  Future<List<PrepItem>> getPreparationChecklist() => _blocked();
  @override
  Future<List<DivyaBooking>> getBookings() => _blocked();
  @override
  Future<List<BookingStep>> getBookingSteps() => _blocked();
  @override
  Future<List<BookingStep>> getTrackingSteps() => _blocked();
  @override
  Future<List<FamilyMember>> getFamilyMembers() => _blocked();
  @override
  Future<SupportCase> getSupportCase() => _blocked();
  @override
  Future<List<String>> getSupportTopics() => _blocked();
  @override
  Future<PartnerDashboard> getPartnerDashboard() => _blocked();
}
