import 'package:refactor_pref_service/model/ride/locations.dart';
import 'package:refactor_pref_service/repository/location_preferences_repository.dart';

///
/// This is where data usually fetch from the database
/// For now, we use
//
class MockLocationsRepository implements LocationsRepository {
  @override
  List<Location> getLocations() {
    return [
      /// mock data for now
      Location(name: "Phnom Penh", country: Country.cambodia),
      Location(name: "Siem Reap", country: Country.cambodia),
      Location(name: "Battambang", country: Country.cambodia),
      Location(name: "Sihanoukville", country: Country.cambodia),
      Location(name: "Kampot", country: Country.cambodia),
    ];
  }
}