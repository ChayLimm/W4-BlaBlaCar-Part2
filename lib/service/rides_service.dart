import 'package:refactor_pref_service/model/ride_pref/ride_pref.dart';
import 'package:refactor_pref_service/repository/rides_repository.dart';

import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {

  // static rideserivce so it can be acces anywhere, using static is not good
  static RidesService? _instance;
  final RidesRepository repository;

  RidesService._internal(this.repository);


  List<Ride> availableRides = fakeRides;  

  ///
  /// Initialize
  /// 

  static void initialize(RidesRepository repo){
    if(_instance == null){
      _instance = RidesService._internal(repo);
    }else{
      throw "Ride service is already initilized";
    }
  }
  /// 
  /// singleton
  /// 

  static RidesService? get instance{
    if(_instance != null){
      return _instance;
    }else{
      throw "Must initiallize ride service first";
    }
  }

  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
  List<Ride> getRidesFor(RidePreference preferences, RidesFilter? filter, RideSortType? sortBy) { 
    List<Ride> filteredRides = repository.getRides(preferences, filter).where(
      (ride) => ride.departureLocation == preferences.departure &&
                ride.arrivalLocation == preferences.arrival &&
                (filter == null || ride.ridesFilter.acceptPets == filter.acceptPets) 
    ).toList();

    // Apply sorting logic
    if (sortBy != null) {
      switch (sortBy) {
        case RideSortType.timeOfDeparture:
          filteredRides.sort((a, b) => a.departureDate.compareTo(b.departureDate));
          break;
        case RideSortType.lowestPrice:
          filteredRides.sort((a, b) => a.pricePerSeat.compareTo(b.pricePerSeat));
          break;

      }
    }

    return filteredRides;
  }

 
}

enum RideSortType{
  timeOfDeparture,
  lowestPrice;
}

class RidesFilter {
  final bool acceptPets;
  RidesFilter(this.acceptPets);
}

