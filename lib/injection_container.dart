import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/data/repositories/weight_repository_impl.dart';
import 'package:task/domain/repositories/weight_repository.dart';
import 'package:task/domain/use_cases/add_weight.dart';
import 'package:task/domain/use_cases/delete_weight.dart';
import 'package:task/domain/use_cases/get_all_weights.dart';
import 'package:task/domain/use_cases/update_weight.dart';
import 'package:task/presentation/provider/main_provider.dart';
import 'package:task/presentation/provider/weight_provider.dart';

import 'data/data_source/weight_data_source.dart';

final sl=GetIt.instance;
init()async{

  sl.registerLazySingleton<MainProvider>(() => MainProvider());

  sl.registerFactory<WeightProvider>(() => WeightProvider(deleteWeight: sl(), getAllWeights: sl(), updateWeight: sl(), addWeight: sl()));
  sl.registerLazySingleton<AddWeight>(() => AddWeight(weightRepository: sl()));
  sl.registerLazySingleton<DeleteWeight>(() => DeleteWeight(weightRepository: sl()));
  sl.registerLazySingleton<UpdateWeight>(() => UpdateWeight(weightRepository: sl()));
  sl.registerLazySingleton<GetAllWeights>(() => GetAllWeights(weightRepository: sl()));
  sl.registerLazySingleton<WeightRepository>(() => WeightRepositoryImpl(weightDataSource: sl()));
  sl.registerLazySingleton<WeightDataSource>(() => WeightDataSourceImpl(fireStore: sl()));

  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() =>sharedPreferences);
}