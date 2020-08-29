import 'package:hive/hive.dart';
import 'package:quiky_user/features/user/data/datasource/user_local_data_source.dart';

const String LRU = "LRU";

abstract class SearchLocalDataSource {
  /// Return the list of last 3 most
  /// recent Search queries performed by the user
  ///
  /// or return an empty list if nothing is found locally
  List<String> getCache();

  /// Check for any available queryList
  /// if nothing adds new one
  ///
  /// if anything is present removes and
  /// put the new list
  void newList(List<String> newList);
}

class SearchLocalDataSourceImpl extends SearchLocalDataSource {
  final HiveInterface hive;

  SearchLocalDataSourceImpl({this.hive});

  @override
  List<String> getCache() {
    if (!hive.isBoxOpen(CORE_BOX)) hive.openBox(CORE_BOX);
    final result =
        hive.box(CORE_BOX).get(LRU, defaultValue: <String>[]) ?? <String>[];
    return result;
  }

  @override
  void newList(List<String> newList) {
    if (!hive.isBoxOpen(CORE_BOX)) hive.openBox(CORE_BOX);
    hive.box(CORE_BOX).put(LRU, newList);
  }
}
