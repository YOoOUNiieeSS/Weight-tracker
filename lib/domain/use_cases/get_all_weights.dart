import 'package:task/domain/repositories/weight_repository.dart';

import '../entities/weight_entity.dart';

class GetAllWeights{
  final WeightRepository weightRepository;
  GetAllWeights({required this.weightRepository});
  Future<List<WeightEntity>> call()async=>await weightRepository.getAllWeights();
}