import 'package:retrofit/retrofit.dart';
import 'package:test_api_bloc/data/model/contact.dart';
import 'package:dio/dio.dart';
part 'apiservice.g.dart';

@RestApi(baseUrl: 'https://65ed929508706c584d9a1584.mockapi.io/api/')
abstract class ApiService {
  factory ApiService(Dio dio) => _ApiService(dio);

  @GET('')
  Future<List<Contact>> getContact();

  @POST('')
  Future<Contact> addContact(@Body() Contact contact);

  @PUT('{id}')
  Future<Contact> updateContact(@Path() String id, @Body() Contact contact);

  @DELETE('{id}')
  Future<Contact> deleteContact(@Path() String id);
}
