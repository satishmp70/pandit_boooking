import '../entities/divyaseva_entities.dart';
import '../repositories/divyaseva_repository.dart';

class GetServices {
  const GetServices(this._repository);
  final DivyaSevaRepository _repository;

  Future<List<DivyaService>> call() => _repository.getServices();
}

class GetServiceDetail {
  const GetServiceDetail(this._repository);
  final DivyaSevaRepository _repository;

  Future<DivyaService> call(String id) => _repository.getServiceDetail(id);
}

class GetVariants {
  const GetVariants(this._repository);
  final DivyaSevaRepository _repository;

  Future<List<ServiceVariant>> call(String serviceId) => _repository.getVariants(serviceId);
}

class GetSamagriOptions {
  const GetSamagriOptions(this._repository);
  final DivyaSevaRepository _repository;

  Future<List<SamagriOption>> call() => _repository.getSamagriOptions();
}

class GetMuhuratWindows {
  const GetMuhuratWindows(this._repository);
  final DivyaSevaRepository _repository;

  Future<List<MuhuratWindow>> call() => _repository.getMuhuratWindows();
}

class GetDateOptions {
  const GetDateOptions(this._repository);
  final DivyaSevaRepository _repository;

  Future<List<String>> call() => _repository.getDateOptions();
}

class GetStartTimes {
  const GetStartTimes(this._repository);
  final DivyaSevaRepository _repository;

  Future<List<String>> call() => _repository.getStartTimes();
}

class GetLanguages {
  const GetLanguages(this._repository);
  final DivyaSevaRepository _repository;

  Future<List<String>> call() => _repository.getLanguages();
}

class GetTraditions {
  const GetTraditions(this._repository);
  final DivyaSevaRepository _repository;

  Future<List<String>> call() => _repository.getTraditions();
}

class GetMatchedPandits {
  const GetMatchedPandits(this._repository);
  final DivyaSevaRepository _repository;

  Future<List<Pandit>> call() => _repository.getMatchedPandits();
}

class GetPreparationChecklist {
  const GetPreparationChecklist(this._repository);
  final DivyaSevaRepository _repository;

  Future<List<PrepItem>> call() => _repository.getPreparationChecklist();
}

class GetBookings {
  const GetBookings(this._repository);
  final DivyaSevaRepository _repository;

  Future<List<DivyaBooking>> call() => _repository.getBookings();
}

class GetBookingSteps {
  const GetBookingSteps(this._repository);
  final DivyaSevaRepository _repository;

  Future<List<BookingStep>> call() => _repository.getBookingSteps();
}

class GetTrackingSteps {
  const GetTrackingSteps(this._repository);
  final DivyaSevaRepository _repository;

  Future<List<BookingStep>> call() => _repository.getTrackingSteps();
}

class GetFamilyMembers {
  const GetFamilyMembers(this._repository);
  final DivyaSevaRepository _repository;

  Future<List<FamilyMember>> call() => _repository.getFamilyMembers();
}

class GetSupportCase {
  const GetSupportCase(this._repository);
  final DivyaSevaRepository _repository;

  Future<SupportCase> call() => _repository.getSupportCase();
}

class GetSupportTopics {
  const GetSupportTopics(this._repository);
  final DivyaSevaRepository _repository;

  Future<List<String>> call() => _repository.getSupportTopics();
}

class GetPartnerDashboard {
  const GetPartnerDashboard(this._repository);
  final DivyaSevaRepository _repository;

  Future<PartnerDashboard> call() => _repository.getPartnerDashboard();
}

/// Derives the live quote from the current draft selection. Pure, so it can be
/// recomputed on every state change without touching the data layer.
class BuildQuote {
  const BuildQuote();

  Quote call({
    required ServiceVariant variant,
    required SamagriOption samagri,
    int platform = 149,
    int travel = 0,
    int discount = 500,
  }) {
    final gst = (platform * 0.18).round();
    final total = variant.price + samagri.price + gst + travel + platform - discount;
    return Quote(
      base: variant.price,
      samagri: samagri.price,
      gst: gst,
      travel: travel,
      platform: platform,
      discount: discount,
      total: total,
    );
  }
}
