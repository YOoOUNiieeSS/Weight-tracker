import 'package:task/domain/repositories/weight_repository.dart';

import '../entities/weight_entity.dart';

class AddWeight{
  final WeightRepository weightRepository;
  AddWeight({required this.weightRepository});
  Future<bool> call(WeightEntity weightEntity)async=>await weightRepository.addWeight(weightEntity);
}