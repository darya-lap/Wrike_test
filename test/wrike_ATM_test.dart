import 'package:test/test.dart';
import "dart:async";
import '../bin/wrike_ATM.dart' as ATM_test;

void main(){
  test('getCash(cash, denominations) returns map which use denominations as a keys and amount of denominations as a value', (){
    int cash = 55;
    var denominations = [1,5,10,15];
    expect(ATM_test.getCash(cash, denominations), equals({1:5, 5:2, 10:1, 15:2}));
  });

  test('getCash(cash, denominations) returns map which use denominations as a keys and number of denominations as a value', (){
    int cash = 15;
    var denominations = [4,8];
    expect(ATM_test.getCash(cash, denominations),throwsA('kkkkkk'));
  });

  test('function hello should throw exception', (){
      expect(ATM_test.hello, throwsA(new isInstanceOf<String>()));
  });
}



