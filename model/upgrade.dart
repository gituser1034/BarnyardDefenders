import 'package:flutter/material.dart';
import 'package:final_barnyard_defenders/actors/defender.dart';

// Olly

// Characters can have upgrades giving them more power
// Upgrades must have a defender to apply to, a value for how much to upgrade by
// and an upgrade element dictating which element is being upgraded
class Upgrade{
  Text? title;
  int? value;
  Defender? defender;
  int? upgradeElement;

  Upgrade({this.title, this.value, this.defender, this.upgradeElement});

  void applyUpgrade(){
    // Want ie cow.health
    switch(upgradeElement){
      // applies to upgrade element 0
      case 0:
        defender!.increaseHealth(value!);
        // Test to see if applied
        print(defender!.description());
        break;
      case 1:
        defender!.attack!.increaseDamage(value!);
        break;
      case 2:
        defender!.attack!.decreaseRechargeTime(value!);
        break;
      case 3:
        defender!.attack!.increaseDamage(value!);
        break;
      case 4:
        defender!.attack!.increaseDistance(value!);
        break;
      case 5:
        defender!.attack!.decreaseRechargeTime(value!);
        break;
    }
  }

  String upgradeApplyMessage(){
    return "The ${defender!.title}'s ";
  }
}