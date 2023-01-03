import '../../domain/entities/weight_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class WeightDataSource{
  Future<List<WeightEntity>> getAllWeights();
  Future<bool> addWeight(WeightEntity weightEntity);
  Future<bool> deleteWeight(String id);
  Future<bool> updateWeight(WeightEntity weightEntity);
}

class WeightDataSourceImpl extends WeightDataSource{
  final FirebaseFirestore fireStore;
  WeightDataSourceImpl({required this.fireStore});
  @override
  Future<bool> addWeight(WeightEntity weightEntity) async{
    try{
      final res = await fireStore.collection('weights').add(weightEntity.toJson());
      final temp=weightEntity.toJson();
      temp.update('id', (value) => res.id);
      await fireStore.collection('weights').doc(res.id).update(temp);
      return true;
    }on FirebaseException catch(e){
      print('add weight error ${e.message}');
      return false;
    }
  }

  @override
  Future<bool> deleteWeight(String id)async {
    try{
      await fireStore.collection('weights').doc(id).delete();
      return true;
    }on FirebaseException catch (e){
      print('delete weight error ${e.message}');
      return false;
    }
  }

  @override
  Future<List<WeightEntity>> getAllWeights() async{
    try{
      List<WeightEntity> weights=[];
      final data = await fireStore.collection('weights').get();
      for (var weight in data.docs) {
        weights.add(WeightEntity.fromJson(weight.data()));
      }
      return weights;
    }on FirebaseException catch(e){
      print('get all weights error ${e.message}');
      return [];
    }
  }

  @override
  Future<bool> updateWeight(WeightEntity weightEntity) async{
    try{
      await fireStore.collection('weights').doc(weightEntity.id).update(weightEntity.toJson());
      return true;
    }on FirebaseException catch(e){
      print('update weight error ${e.message}');
      return false;
    }
  }

}