import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:test_api_bloc/bloc/get/cubit/getcontact_cubit.dart';
import 'package:test_api_bloc/data/api/apiservice.dart';
import 'package:test_api_bloc/data/contact_repository.dart';

var getIt = GetIt.I;
void locator() {
  Dio dio = Dio();
  getIt.registerLazySingleton(() => dio);

  ApiService apiService = ApiService(getIt.call());
  getIt.registerLazySingleton(() => apiService);

  ContactRepository contactRepository = ContactRepository(getIt.call());
  getIt.registerLazySingleton(() => contactRepository);

  GetcontactCubit getcontactCubit = GetcontactCubit(getIt.call());
  getIt.registerLazySingleton(() => getcontactCubit);
}
