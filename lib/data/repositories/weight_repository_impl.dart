import 'package:task/domain/entities/weight_entity.dart';
import 'package:task/domain/repositories/weight_repository.dart';

import '../data_source/weight_data_source.dart';

class WeightRepositoryImpl extends WeightRepository{
  WeightDataSource weightDataSource;
  WeightRepositoryImpl({required this.weightDataSource});
  @override
  Future<bool> addWeight(WeightEntity weightEntity) async=>await weightDataSource.addWeight(weightEntity);

  @override
  Future<bool> deleteWeight(String id) async=>await weightDataSource.deleteWeight(id);

  @override
  Future<List<WeightEntity>> getAllWeights() async=>await weightDataSource.getAllWeights();

  @override
  Future<bool> updateWeight(WeightEntity weightEntity) async=>await weightDataSource.updateWeight(weightEntity);

}