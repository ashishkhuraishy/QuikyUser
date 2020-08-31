import 'package:quiky_user/features/home/domain/entity/restaurents.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';
import 'package:quiky_user/features/search/domain/use_case/get_queries.dart';
import 'package:quiky_user/features/search/domain/use_case/get_result.dart';

import '../../injection_container.dart';

class SearchService {

  SearchService({this.currentAddress});

  final Address currentAddress;
  GetResults _getResults = GetResults(repository: sl());
  GetQueries _getQueries = GetQueries(repository: sl());

  List<String> get recentQueries => _getQueries();

  List<Restaurant> results =[];


  getResaturents({String query}) async {
    final result = await _getResults(query: query, lat: currentAddress.lat, long: currentAddress.long);

    // TODO ; Edit Here

    result.fold((failure) => failure, (restaurants) => restaurants);
  }
}
