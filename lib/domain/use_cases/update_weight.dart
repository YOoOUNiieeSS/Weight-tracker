import 'package:task/domain/repositories/weight_repository.dart';

import '../entities/weight_entity.dart';

class UpdateWeight{
  final WeightRepository weightRepository;
  UpdateWeight({required this.weightRepository});
  Future<bool> call(WeightEntity weightEntity)async=>await weightRepository.updateWeight(weightEntity);
}