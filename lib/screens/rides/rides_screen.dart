
import 'package:flutter/material.dart';
import 'package:refactor_pref_service/screens/rides/widgets/ride_pref_bar.dart';
import 'package:refactor_pref_service/screens/rides/widgets/ride_pref_modal.dart';
import 'package:refactor_pref_service/service/filter_service.dart';
import 'package:refactor_pref_service/service/ride_prefs_service.dart';
import 'package:refactor_pref_service/utils/animations_util.dart';
 
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';
 
import 'widgets/rides_tile.dart';

///
///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
///  The screen also allow user to re-define the ride preferences and to activate some filters.
///
class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
 
  // initilize value by default
  RidesFilter filter = FilterService.instance.ridesFilter ?? RidesFilter(false);
  RideSortType sortType = FilterService.instance.rideSortType?? RideSortType.timeOfDeparture;

  RidePreference currentPreference  = RidePrefService.instance.currentPreference!;   // TODO 1 :  We should get it from the service
  
  // get teh matching rides base on the user filtering
  List<Ride> get matchingRides => RidesService.instance!.getRidesFor(currentPreference,filter,sortType);


  void onBackPressed() {
    Navigator.of(context).pop();     //  Back to the previous view
  } 

  void onPreferencePressed() async {
        // TODO  6 : we should push the modal with the current pref
        RidePreference newRidePref = await Navigator.of(context).push(AnimationUtils.createBottomToTopRoute(RidePrefModal(initRidePref: currentPreference)));
        // TODO 9 :  After pop, we should get the new current pref from the modal 
        // TODO 10 :  Then we should update the service current pref, and update the view
        RidePrefService.instance.setCurrentPreference(newRidePref);
        setState(() {
          currentPreference = newRidePref;
        });
  }
  

  void onPressedFilter() {
  // Update filter and sortType with the latest values from FilterService
  setState(() {
    filter = FilterService.instance.ridesFilter ?? RidesFilter(false);
    sortType = FilterService.instance.rideSortType ?? RideSortType.timeOfDeparture;
  });
  print("Filter and sort type updated, screen rebuilding");
}

  @override
  Widget build(BuildContext context) {
    print(matchingRides.length);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
          left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
      child: Column(
        children: [
          // Top search Search bar
          RidePrefBar(
              ridePreference: currentPreference,
              onBackPressed: onBackPressed,
              onPreferencePressed: onPreferencePressed,
              onFilterPressed: onPressedFilter),

          Expanded(
            child: ListView.builder(
              itemCount: matchingRides.length,
              itemBuilder: (ctx, index) => RideTile(
                ride: matchingRides[index],
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
