import 'package:flutter/material.dart';
import 'package:task/domain/use_cases/add_weight.dart';
import 'package:task/domain/use_cases/delete_weight.dart';
import 'package:task/domain/use_cases/get_all_weights.dart';
import 'package:task/domain/use_cases/update_weight.dart';

import '../../domain/entities/weight_entity.dart';

class WeightProvider extends ChangeNotifier{
  AddWeight addWeight;
  UpdateWeight updateWeight;
  GetAllWeights getAllWeights;
  DeleteWeight deleteWeight;
  WeightProvider({required this.deleteWeight,required this.getAllWeights,required this.updateWeight,required this.addWeight});

  List<WeightEntity> weights=[];
  bool loaded=false;
  int page=0;
  Future<void> getWeights()async{
    weights=await getAllWeights();
    sortWeightEntries();
    notifyListeners();
  }
  Future<bool> updateWeightEntry({required WeightEntity weightEntity})async{
    final success = await updateWeight(weightEntity);
    await getWeights();
    notifyListeners();
    return success;
  }
  Future<void> deleteWeightEntry({required String weightId})async{
    await deleteWeight(weightId);
    await getWeights();
    notifyListeners();
  }
  Future<bool> addWeightEntry({required WeightEntity weightEntity})async{
    final success = await addWeight(weightEntity);
    await getWeights();
    notifyListeners();
    return success;
  }

  void sortWeightEntries(){
    weights.sort((a,b)=>a.dateTime.compareTo(b.dateTime));
    weights=weights.reversed.toList();
    notifyListeners();
  }
  void nextPage({bool reverse=false}){
    if(reverse){
      page-=5;
    }
    else {
      page+=5;
    }
    notifyListeners();
  }
}