import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';
import 'package:quiky_user/features/home/domain/repository/home_repository.dart';
import 'package:quiky_user/features/home/domain/usecase/get_popular.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

main() {
  MockHomeRepository mockHomeRepository;
  GetPopular getPopular;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    getPopular = GetPopular(repository: mockHomeRepository);
  });

  final lat = 0.0, long = 0.0;

  List<Restaurant> restaurents = [
    Restaurant(
        id: null,
        offers: null,
        employeeId: null,
        title: null,
        mobile: null,
        gst: null,
        tinTan: null,
        typeGoods: null,
        delivery: null,
        vendor: null,
        customer: null,
        popularBrand: null,
        brandLogo: null,
        profilePicture: null,
        fssai: null,
        storeSubType: null,
        status: null,
        option: null,
        totalReviews: null,
        avgRating: null,
        coordinate: null,
        address: null,
        recommendationCount: null,
        minimumCostTwo: null,
        avgDeliveryTime: null,
        active: null,
        inOrder: null,
        bulkOrder: null,
        opening: null,
        closing: null,
        highlightStatus: null,
        featuredBrand: null,
        commisionPercentage: null,
        user: null,
        city: null,
        zone: null,
        vendorLocation: null),
  ];

  test('should call getRecipes method', () {
    getPopular(lat: lat, long: long);
    verify(mockHomeRepository.getPopular(lat: lat, long: long));
  });
  test('should return List recipies when called', () async {
    when(mockHomeRepository.getPopular(
            lat: anyNamed('lat'), long: anyNamed('long')))
        .thenAnswer((realInvocation) async => Right(restaurents));

    final result = await getPopular(lat: lat, long: long);
    verify(mockHomeRepository.getPopular(lat: lat, long: long));
    expect(result, Right(restaurents));
  });
}
