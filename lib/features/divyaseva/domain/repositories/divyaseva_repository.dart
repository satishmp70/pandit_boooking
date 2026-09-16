import '../entities/divyaseva_entities.dart';

/// Single bounded-context repository for the DivyaSeva booking app.
abstract class DivyaSevaRepository {
  Future<List<DivyaService>> getServices();

  Future<DivyaService> getServiceDetail(String id);

  Future<List<ServiceVariant>> getVariants(String serviceId);

  Future<List<SamagriOption>> getSamagriOptions();

  Future<List<MuhuratWindow>> getMuhuratWindows();

  Future<List<String>> getDateOptions();

  Future<List<String>> getStartTimes();

  Future<List<String>> getLanguages();

  Future<List<String>> getTraditions();

  Future<List<Pandit>> getMatchedPandits();

  Future<List<PrepItem>> getPreparationChecklist();

  Future<List<DivyaBooking>> getBookings();

  Future<List<BookingStep>> getBookingSteps();

  Future<List<BookingStep>> getTrackingSteps();

  Future<List<FamilyMember>> getFamilyMembers();

  Future<SupportCase> getSupportCase();

  Future<List<String>> getSupportTopics();

  Future<PartnerDashboard> getPartnerDashboard();
}
