import 'package:quiky_user/features/search/domain/repository/search_repository.dart';

class GetQueries {
  final SearchRepository repository;

  GetQueries({this.repository});

  List<String> call() {
    return repository.getQueries();
  }
}
