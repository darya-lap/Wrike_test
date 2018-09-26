import 'package:test/test.dart';
import '../bin/wrike_ATM.dart' as ATM_test;

void main(){

  group('getCash(cash, List<int>.from(bills)) returns map which use bills as a keys and amount of bills as a value',(){

    test('Test 1 - Get minimal possible sum', (){
      int cash = 1;
      var bills = [1,5,10,50];
      expect(new ATM_test.ATM().getCash(cash, List<int>.from(bills)), equals({1:1, 5:0, 10:0, 50:0}));
    });

    test('Test 2 - Get sum, which can be given in wrong way with equals number of bills, but with a less max bill', (){
      int cash = 5;
      var bills = [1,5,10,50];
      expect(new ATM_test.ATM().getCash(cash, List<int>.from(bills)), equals({1:0, 5:1, 10:0, 50:0}));
    });

    test('Test 3 - Get sum, which can be given in a wrong way with the max possible bill, but with fewer bills', (){
      int cash = 10;
      var bills = [1,5,10,15];
      expect(new ATM_test.ATM().getCash(cash, List<int>.from(bills)), equals({1:5, 5:1, 10:0, 15:0}));
    });

    test('Test 4 - Get sum, which can be given in a wrong way with the max possible bill, but with fewer bills', (){
      int cash = 55;
      var bills = [1,5,10,50];
      expect(new ATM_test.ATM().getCash(cash, List<int>.from(bills)), equals({1:5, 5:2, 10:4, 50:0}));
    });

    test('Test 5 - Get sum, which can be given in wrong way with equals number of bills, but with a less max bill', (){
      int cash = 56;
      var bills = [1,5,10,50];
      expect(new ATM_test.ATM().getCash(cash, List<int>.from(bills)), equals({1:1, 5:1, 10:0, 50:1}));
    });  
    test('Test 6 - Get sum with anothher bills', (){
      int cash = 56;
      var bills = [1,8,28];
      expect(new ATM_test.ATM().getCash(cash, List<int>.from(bills)), equals({1:4, 8:3, 28:1}));
    });
    test('Test 7 - Not ordered bills in the list of bills', (){
      int cash = 15;
      var bills = [1,50,10,5];
      expect(new ATM_test.ATM().getCash(cash, List<int>.from(bills)), equals({1:0, 5:1, 10:1, 50:0}));
    });

    test('Test 8 - Get sum with anothher bills', (){
      int cash = 120;
      var bills = [1,2,3,30];
      expect(new ATM_test.ATM().getCash(cash, List<int>.from(bills)), equals({1:1, 2:1, 3:9, 30:3}));
    });
  });
  
  
  group('Error tests',(){

    test('getCash(cash, List<int>.from(bills)) throws the error because of the incorrect cash value', (){
      int cash = 0;
      var bills = [4,8];
      expect(() => new ATM_test.ATM().getCash(cash, List<int>.from(bills)), throwsA(predicate((e) => e is ArgumentError && e.message == 'The requested cash must be more than 0')));
    });


    test('getCash(cash, List<int>.from(bills)) throws the error because of empty list', (){
      int cash = 35;
      var bills = [];
      expect(() => new ATM_test.ATM().getCash(cash, List<int>.from(bills)), throwsA(predicate((e) => e is ArgumentError && e.message == 'Incorrect bills parameter')));
    });


    test('getCash(cash, List<int>.from(bills)) throws the error because it isn\'t possible to get cash with available bills', (){
      int cash = 15;
      var bills = [4,8];
      expect(() => new ATM_test.ATM().getCash(cash, List<int>.from(bills)), throwsA(predicate((e) => e is ArgumentError && e.message == 'The requested cash can not be issued by available bills')));
    });  

  });





}



