import 'package:flutter/cupertino.dart';

class educationAddSwitchProvider with ChangeNotifier{
    late bool addSwitch;

    initData(bool data){
      addSwitch = data;
    }
    bool get currentAddSwitch => addSwitch;

    onchangeUpdate(bool val){
      addSwitch = val;
      notifyListeners();
    }
}