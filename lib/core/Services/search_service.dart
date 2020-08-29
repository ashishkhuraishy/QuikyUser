import 'package:quiky_user/features/search/domain/use_case/get_queries.dart';
import 'package:quiky_user/features/search/domain/use_case/get_result.dart';

import '../../injection_container.dart';

class SearchService {
  GetResults _getResults = GetResults(repository: sl());
  GetQueries _getQueries = GetQueries(repository: sl());

  List<String> get recentQueries => _getQueries();

  getResaturents({String query, double lat, double lng}) async {
    final result = await _getResults(query: query, lat: lat, long: lng);

    // TODO ; Edit Here

    result.fold((failure) => null, (restaurants) => null);
  }
}
