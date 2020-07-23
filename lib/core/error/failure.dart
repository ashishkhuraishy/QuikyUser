import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => <dynamic>[];
}

class ServerFailure extends Failure {}

class ConnectionFailure extends Failure {}

class CacheFailure extends Failure {}

class LocationFailure extends Failure {}
