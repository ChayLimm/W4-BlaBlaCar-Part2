import 'package:refactor_pref_service/model/ride/locations.dart';

abstract class LocationsRepository {
  List<Location> getLocations();
}