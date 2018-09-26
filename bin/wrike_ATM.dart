import 'package:collection/collection.dart';

void main(){

  Function deepEq = const DeepCollectionEquality().equals;

  var s1 = new Map.from({50: 10, 3: 20});
  var s2 = new Map.from({50: 10, 3: 20});
print(s1 == s2);
}

class ParametersOfAlgorithm{
  int numberOfDiffBills;
  var mapOfBills = new Map<int, int>();

  ParametersOfAlgorithm(numberOfDiffBills, mapOfBills){
    this.numberOfDiffBills = numberOfDiffBills;
    this.mapOfBills = new Map<int,int>.from(mapOfBills);
  }

  void setMapOfBills(Map<int,int> newMapOfBills){
    this.mapOfBills = newMapOfBills;
  }

  Map<int,int> getMapOfBills(){
    return this.mapOfBills;
  }


  void setNumberOfDiffBills(int newNumberOfDiffBills){
    this.numberOfDiffBills = newNumberOfDiffBills;
  }

  int getNumberOfDiffBills(){
    return this.numberOfDiffBills;
  }

  void incrementNumberOfDiffBills(){
    this.numberOfDiffBills++;
  }

  void decrementNumberOfDiffBills(){
    this.numberOfDiffBills--;
  }

  void incrementNumberOfBillByKey(int key){
    this.getMapOfBills()[key]++;
  }

  void decrementNumberOfBillByKey(int key){
    this.getMapOfBills()[key]--;
  }
  
}

class ATM{  
  Map getCash(int cash, List<int> bills_param) {
    if (cash <= 0) {
      throw new ArgumentError('The requested cash must be more than 0');
    }
    if (bills_param.isEmpty) {
      throw new ArgumentError('Incorrect bills parameter');
    }

    int cash_rest = cash;

    var bills = List<int>.from(bills_param);
    bills.sort((a, b) => a.compareTo(b));

    final mapOfBills = new Map.fromIterable(List.generate(bills.length, (int index) => bills_param[index]), value: (_) => 0);

    var bestParam = new ParametersOfAlgorithm(0, mapOfBills);

    for (int i = bills.length - 1; i >= 0; i--) {

      if ((bestParam.getMapOfBills() == bills.length) || ((i + 1) <= bestParam.getNumberOfDiffBills())){
        break;
      }

      if (cash_rest >= bills[i]) {

        mapOfBills[bills[i]]++;
        var curParam = new ParametersOfAlgorithm(1, mapOfBills);

        var paramList = this.getBestMapOfBills(bills, i, cash_rest - bills[i], bestParam, curParam);
        mapOfBills[bills[i]]--;

        if (paramList.getNumberOfDiffBills() > bestParam.getNumberOfDiffBills()){
          bestParam = paramList;
        } 
      }
    }

    Function deepEq = const DeepCollectionEquality().equals;

    if (deepEq(mapOfBills, bestParam.getMapOfBills())){
        throw new ArgumentError('The requested cash can not be issued by available bills');
    }
    return bestParam.getMapOfBills();
  }

  ParametersOfAlgorithm getBestMapOfBills(List<int >bills, int index, int cash, ParametersOfAlgorithm bestParam, ParametersOfAlgorithm curParamPrev) {

    var curParam = new ParametersOfAlgorithm(curParamPrev.getNumberOfDiffBills(), new Map.from(curParamPrev.getMapOfBills()));

    if (bestParam.getNumberOfDiffBills() >= (curParam.getNumberOfDiffBills() + index)){
      return bestParam;
    }
    var curBill = bills[index];

    if (cash >= curBill) {
      for (int i = index; i >= 0; i--) {
        if (i != index){
          curParam.incrementNumberOfDiffBills();
        } 
        curParam.incrementNumberOfBillByKey(bills[i]);

        var newParam = this.getBestMapOfBills(bills, i, cash - bills[i], bestParam, curParam);
    
        if (newParam.getNumberOfDiffBills() > bestParam.getNumberOfDiffBills()){
          bestParam = newParam;
        }

        curParam.decrementNumberOfBillByKey(bills[i]);

        if (i != index){
          curParam.decrementNumberOfDiffBills();
        }
      }
    } else {
        if (cash > 0) {
          for (int i = index - 1; i >= 0; i--) {
            if (cash >= bills[i]) {
              curParam.incrementNumberOfDiffBills();
              curParam.incrementNumberOfBillByKey(bills[i]);
              var newParam = this.getBestMapOfBills(bills, i, cash - bills[i], bestParam, curParam);
              if (newParam.getNumberOfDiffBills() > bestParam.getNumberOfDiffBills()){
                bestParam = newParam;
              }
              curParam.decrementNumberOfDiffBills();
              curParam.decrementNumberOfBillByKey(bills[i]);
            }
          }
        } else{
            bestParam = curParam;
        };
    }
    return bestParam;
  }
}