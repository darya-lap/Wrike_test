import '../bin/wrike_ATM.dart';
import 'dart:io';
import 'dart:async';

void main() {
  int cash = 55;
  var denominations = [1,5,10,15];
  print('HI');
  print(getCash(cash, denominations));
}