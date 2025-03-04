import 'package:refactor_pref_service/model/ride/ride.dart';
import 'package:refactor_pref_service/model/ride_pref/ride_pref.dart';
import 'package:refactor_pref_service/service/rides_service.dart';

abstract class RidesRepository {
    List<Ride> getRides (RidePreference preference, RidesFilter? filter);
}