import '../entities/weight_entity.dart';

abstract class WeightRepository{
  Future<List<WeightEntity>> getAllWeights();
  Future<bool> addWeight(WeightEntity weightEntity);
  Future<bool> deleteWeight(String id);
  Future<bool> updateWeight(WeightEntity weightEntity);
}