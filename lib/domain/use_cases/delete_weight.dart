import 'package:task/domain/repositories/weight_repository.dart';

import '../entities/weight_entity.dart';

class DeleteWeight{
  final WeightRepository weightRepository;
  DeleteWeight({required this.weightRepository});
  Future<bool> call(String weightId)async=>await weightRepository.deleteWeight(weightId);
}