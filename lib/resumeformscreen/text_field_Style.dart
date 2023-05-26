import 'package:flutter/material.dart';

InputDecoration textFieldDecoration(hintText, labelText){
  return InputDecoration(
    hintText: hintText,
    labelText: labelText,
    filled: true,
    fillColor: Colors.grey[300],
    labelStyle: TextStyle(color: Colors.black54),
    focusColor: Colors.black87,
    // border: InputBorder.none,
    contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
    // focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none)
    border: InputBorder.none
     
  );
}