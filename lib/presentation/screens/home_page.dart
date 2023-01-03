import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:task/core/utils/app_color.dart';
import 'package:task/core/widgets/elevated_button.dart';
import 'package:task/core/widgets/myTextFormField.dart';
import 'package:task/domain/entities/weight_entity.dart';
import 'package:task/presentation/provider/weight_provider.dart';
import 'package:task/injection_container.dart' as di;

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final TextEditingController weightController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context)=>WeightProvider(deleteWeight: di.sl(), getAllWeights: di.sl(), updateWeight: di.sl(), addWeight: di.sl())..getWeights(),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark),
            centerTitle: true,
            title: const Text(
              "Weight Tracker",
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0,
          ),
          body: Consumer<WeightProvider>(
            builder: (context, weightProvider, _) =>SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  height: 400,
                  child: weightProvider.weights.isEmpty?const Center(child: CircularProgressIndicator(),):
                  ListView.separated(
                    itemBuilder: (context, index) =>
                    (index+weightProvider.page)<weightProvider.weights.length?buildWeightRow(weightProvider.weights[index+weightProvider.page]):
                      Container(),
                    separatorBuilder: (context, index) =>(index+weightProvider.page)<weightProvider.weights.length? const Divider(color: AppColor.greyColor,):Container(),
                    itemCount: weightProvider.weights.length<5?weightProvider.weights.length:5,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(disabledColor: AppColor.greyColor,onPressed: weightProvider.page<=0?null: (){weightProvider.nextPage(reverse: true);}, icon: const Icon(Icons.arrow_circle_left_outlined)),
                    Text((weightProvider.page+5>=weightProvider.weights.length?weightProvider.weights.length:(weightProvider.page+5)).toString(),style: const TextStyle(fontSize: 20),),
                    IconButton(onPressed: weightProvider.page+5>=weightProvider.weights.length?null:(){weightProvider.nextPage();}, icon: const Icon(Icons.arrow_circle_right_outlined))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                myElevatedButton(
                    text: 'Add new Weight',
                    onPressed: () async {
                      showMyDialog(weightProvider: weightProvider,context: context,text: 'Add');
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showMyDialog({required WeightProvider weightProvider, weight=0.0,context, text,edit=false,weightId='id'})=>showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Center(child: Text(edit?"Update Weight":"Add New Weight")),
        contentPadding: const EdgeInsets.all(10),
        content: Form(
            key: formKey,
            child: Container(
              height: 200,
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myTextFormField(
                    validator: (String? v) {
                      if (v!.isEmpty) {
                        return 'Please enter your weight';
                      } else {
                        return null;
                      }
                    },
                    textInputType: const TextInputType.numberWithOptions(decimal: true),
                    controller: weightController,
                  ),
                  myElevatedButton(
                      text: text,onPressed: ()async{
                    if(formKey.currentState!.validate()){
                      final success = edit ?await weightProvider.updateWeightEntry(weightEntity: WeightEntity(id: weightId, isMale: true, weight: double.parse(weightController.text), dateTime: DateTime.now()))
                          :await weightProvider.addWeightEntry(weightEntity: WeightEntity(id: 'id', isMale: true, weight: double.parse(weightController.text), dateTime: DateTime.now()));
                      if(success){
                        Navigator.of(context).pop();
                      }
                    }
                  })
                ],
              ),
            )),
      ));
  buildWeightRow(WeightEntity weight) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<WeightProvider>(
        builder: (context,provider,_)=> Row(
          children: [
            Text(weight.weight.toString(),style: const TextStyle(color: Colors.black),),
            const Spacer(),
            IconButton(onPressed: ()async{
              showMyDialog(weightProvider: provider,text: 'Update',context: context,edit: true,weight: weight.weight,weightId: weight.id);
            }, icon: const Icon(Icons.edit)),
            IconButton(onPressed: (){
              provider.deleteWeightEntry(weightId: weight.id);
            }, icon: const Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
