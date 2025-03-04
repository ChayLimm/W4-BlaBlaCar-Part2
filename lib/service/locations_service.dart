
import 'package:refactor_pref_service/model/ride/locations.dart';
import 'package:refactor_pref_service/repository/location_preferences_repository.dart';
////
///   This service handles:
///   - The list of available rides
///
class LocationsService {

  // static locationservice so it can be acces anywhere
  static  LocationsService? _instance;

  final LocationsRepository repository;

  LocationsService._internal(this.repository);

  // static const List<Location> availableLocations = fakeLocations; 

  List<Location> get availableLocations => repository.getLocations();

    ///
    /// Initialize
    ///
  static void initialize(LocationsRepository repo){
    if(_instance == null){
      _instance = LocationsService._internal(repo);
    }else{
      throw Exception("LocatonService is already initialized.");
    }
  }

  ///
  /// Singleton for service accesssing
  /// 
  static LocationsService get instance {
    if (_instance == null) {
		  throw Exception("LocationsService is not initialized. Call initialize() first.");
		}
		return _instance!;
  }

  
 
}