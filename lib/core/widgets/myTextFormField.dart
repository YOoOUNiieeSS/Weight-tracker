import 'package:flutter/material.dart';

myTextFormField({
  String text='',
  void Function(String)? onChange,
  textInputType,
  String? Function(String?)? validator,
  controller
}) {
  controller.text=text;
  return TextFormField(
  controller: controller,
  cursorColor: Colors.grey,
  keyboardType: textInputType,
  decoration: InputDecoration(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Colors.grey)),
    focusColor: Colors.grey,
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: const BorderSide(color: Colors.grey)),
  ),
  onChanged: onChange,
  onSaved: (String? v){
    if(onChange!=null)onChange(v!);
  },
  validator: (String? v){
    if(validator!=null)return validator(v);
    return null;
  },
);
}