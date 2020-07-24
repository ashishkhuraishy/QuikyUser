import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/features/home/domain/entity/recipie.dart';
import 'package:quiky_user/features/home/domain/repository/home_repository.dart';
import 'package:quiky_user/features/home/domain/usecase/get_recipies.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

main() {
  MockHomeRepository mockHomeRepository;
  GetRecipies getRecipies;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    getRecipies = GetRecipies(repository: mockHomeRepository);
  });

  List<Recipie> recipies = [
    Recipie(id: 1, title: 'Store 1', imgUrl: '', stores: [1, 7, 9]),
    Recipie(id: 1, title: 'Store 1', imgUrl: '', stores: [1, 7, 9]),
    Recipie(id: 1, title: 'Store 1', imgUrl: '', stores: [1, 7, 9]),
  ];

  test('should call getRecipes method', () {
    getRecipies();
    verify(mockHomeRepository.getRecipies());
  });
  test('should return List recipies when called', () async {
    when(mockHomeRepository.getRecipies())
        .thenAnswer((realInvocation) async => Right(recipies));

    final result = await getRecipies();
    verify(mockHomeRepository.getRecipies());
    expect(result, Right(recipies));
  });
}
