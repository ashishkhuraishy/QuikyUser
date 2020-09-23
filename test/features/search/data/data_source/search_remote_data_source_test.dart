import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/Constants/Apikeys.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';
import 'package:quiky_user/features/search/data/data_source/search_remote_data_source.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../cart/data/data_source/cart_remote_data_source_test.dart';

main() {
  MockClient mockClient = MockClient();
  SearchRemoteDataSourceImpl remoteDataSourceImpl =
      SearchRemoteDataSourceImpl(client: mockClient);

  // final restaurentModel = RestaurantModel(
  //   id: 25,
  //   offers: [
  //     Offer(
  //       id: 1,
  //       title: 'Quicky50',
  //       code: 'quick',
  //       text: '',
  //       offerId: 3,
  //       percentage: '40',
  //     ),
  //   ],
  //   employeeId: "97632",
  //   title: "MRA Bakery And Restaurant",
  //   mobile: "85930 12345",
  //   gst: '',
  //   tinTan: '',
  //   typeGoods: "food",
  //   delivery: false,
  //   vendor: true,
  //   customer: false,
  //   popularBrand: true,
  //   brandLogo: "/media/images.png",
  //   profilePicture: "/media/8.png",
  //   fssai: "11319007002211",
  //   storeSubType: "Indian, Chinese",
  //   status: "opened",
  //   option: "trending",
  //   totalReviews: "0",
  //   avgRating: '0',
  //   coordinate: "10.0142468,76.2775775",
  //   address:
  //       "ARRA-96 Cheranalllur Road Bypass Junction, Ponekkara, Edappally, Opposite lulu mall, Kochi, Kerala 682024",
  //   recommendationCount: '',
  //   minimumCostTwo: '450',
  //   avgDeliveryTime: "4.5",
  //   active: true,
  //   inOrder: false,
  //   bulkOrder: false,
  //   opening: '',
  //   closing: '',
  //   highlightStatus: true,
  //   featuredBrand: true,
  //   commisionPercentage: '',
  //   user: "37",
  //   city: "1",
  //   zone: '',
  //   vendorLocation: "10.0142468,76.2775775",
  // );

  // final tRestaurents = [restaurentModel, restaurentModel, restaurentModel];
  final tQuery = "Test Query";
  final tLat = 6.5;
  final tLong = 7.99;

  setUp(() {
    when(mockClient.get(any)).thenAnswer(
        (realInvocation) async => Response(fixture('restaurants.json'), 200));
  });

  group('Get Results', () {
    test('should return the list of [Restaurent] when the api is called',
        () async {
      final result = await remoteDataSourceImpl.getResults(tQuery, tLat, tLong);
      verify(mockClient
          .get(BASE_URL + "/search/?lat=$tLat&lon=$tLong&search=$tQuery"));
      expect(result, isA<List<Restaurant>>());
    });

    test('should throw [ServerException] when response not 200', () async {
      when(mockClient.get(any)).thenAnswer(
          (realInvocation) async => Response(fixture('restaurants.json'), 400));
      final result = remoteDataSourceImpl.getResults;
      expect(() async => await result(tQuery, tLat, tLong),
          throwsA(isA<ServerException>()));
      verify(mockClient
          .get(BASE_URL + "/search/?lat=$tLat&lon=$tLong&search=$tQuery"));
    });
  });
}
