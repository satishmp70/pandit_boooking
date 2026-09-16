import '../../domain/entities/divyaseva_entities.dart';
import '../../domain/repositories/divyaseva_repository.dart';
import '../datasources/divyaseva_mock_datasource.dart';

class DivyaSevaRepositoryImpl implements DivyaSevaRepository {
  const DivyaSevaRepositoryImpl(this._datasource);

  final DivyaSevaMockDataSource _datasource;

  @override
  Future<List<DivyaService>> getServices() => _datasource.getServices();

  @override
  Future<DivyaService> getServiceDetail(String id) => _datasource.getServiceDetail(id);

  @override
  Future<List<ServiceVariant>> getVariants(String serviceId) => _datasource.getVariants(serviceId);

  @override
  Future<List<SamagriOption>> getSamagriOptions() => _datasource.getSamagriOptions();

  @override
  Future<List<MuhuratWindow>> getMuhuratWindows() => _datasource.getMuhuratWindows();

  @override
  Future<List<String>> getDateOptions() => _datasource.getDateOptions();

  @override
  Future<List<String>> getStartTimes() => _datasource.getStartTimes();

  @override
  Future<List<String>> getLanguages() => _datasource.getLanguages();

  @override
  Future<List<String>> getTraditions() => _datasource.getTraditions();

  @override
  Future<List<Pandit>> getMatchedPandits() => _datasource.getMatchedPandits();

  @override
  Future<List<PrepItem>> getPreparationChecklist() => _datasource.getPreparationChecklist();

  @override
  Future<List<DivyaBooking>> getBookings() => _datasource.getBookings();

  @override
  Future<List<BookingStep>> getBookingSteps() => _datasource.getBookingSteps();

  @override
  Future<List<BookingStep>> getTrackingSteps() => _datasource.getTrackingSteps();

  @override
  Future<List<FamilyMember>> getFamilyMembers() => _datasource.getFamilyMembers();

  @override
  Future<SupportCase> getSupportCase() => _datasource.getSupportCase();

  @override
  Future<List<String>> getSupportTopics() => _datasource.getSupportTopics();

  @override
  Future<PartnerDashboard> getPartnerDashboard() => _datasource.getPartnerDashboard();
}
