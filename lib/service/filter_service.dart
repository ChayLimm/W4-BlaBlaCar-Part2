import 'package:refactor_pref_service/service/rides_service.dart';
///
/// FilterService use to store setting data
/// 
class FilterService {

  //store filter setting here
  RideSortType? rideSortType;
  RidesFilter? ridesFilter;

  FilterService._internal();
  
  static final FilterService _instance = FilterService._internal();
  
  static FilterService get instance => _instance;
}