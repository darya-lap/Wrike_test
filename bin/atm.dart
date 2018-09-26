import 'package:collection/collection.dart';

import 'parameters_of_algorithm.dart';


class ATM {

  /// The list of available bills
  List<int> bills;

  ATM(List<int> bills){
    this.setBills(bills);
  }

  /// Sets list of bills from the [bills]
  void setBills(List<int> bills){
    this.bills = bills;
  }

  /// The list of available bills
  List<int> getBills(){
    return this.bills;
  }

  /// Returns Map<int,int>, which uses bills types as a keys and number of bills as a value.
  Map<int,int> getCash(int cash) {

    var bills = this.getBills();

    // Throws an [ArgumentError] if there are some errors with input parameters.
    if (bills.isEmpty) {
      throw new ArgumentError('Incorrect bills parameter');
    }
    if (cash <= 0) {
      throw new ArgumentError('The requested cash must be more than 0');
    }

    bills.sort((a, b) => a.compareTo(b));

    // Initialization of the map of bills with 0 values 
    final mapOfBills = new Map.fromIterable(
        List.generate(bills.length, (int index) => bills[index]),
        value: (_) => 0);
    
    var bestParam = new ParametersOfAlgorithm(0, mapOfBills);

    for (int i = bills.length - 1; i >= 0; i--) {

      // Breaks cycle if current best parameter is better then it can be in current iteration
      if ((bestParam.getMapOfBills() == bills.length) ||
          ((i + 1) <= bestParam.getNumberOfDiffBills())) {
        break;
      }
      int curBill = bills[i];

      // Calls recursive function if current bill <= cash
      if (cash >= curBill) {
        mapOfBills[curBill]++;
        var curParam = new ParametersOfAlgorithm(1, mapOfBills);
        var paramList = this.getBestMapOfBills(i, cash - curBill, bestParam, curParam);
        mapOfBills[curBill]--;

        if (paramList.getNumberOfDiffBills() >
            bestParam.getNumberOfDiffBills()) {
          bestParam = paramList;
        }
      }
    }

    Function deepEq = const DeepCollectionEquality().equals;

    // Throws an [ArgumentError] if there is no possibility to give cash with available bills.
    if (deepEq(mapOfBills, bestParam.getMapOfBills())) {
      throw new ArgumentError(
          'The requested cash can not be issued by available bills');
    }
    return bestParam.getMapOfBills();
  }

  /// Returns the best parameters, using recursiveness
  ParametersOfAlgorithm getBestMapOfBills(int index, int cash,
      ParametersOfAlgorithm bestParam, ParametersOfAlgorithm curParamPrev) {
    var bills = this.getBills();
    var curParam = new ParametersOfAlgorithm(
        curParamPrev.getNumberOfDiffBills(),
        new Map.from(curParamPrev.getMapOfBills()));
    
    // Exits from the recursion if current best number of different bills more then max possible in current depth of recursion
    if (bestParam.getNumberOfDiffBills() >=
        (curParam.getNumberOfDiffBills() + index)) {
      return bestParam;
    }
    var curBill = bills[index];

    // Continue recursiveness if cash > 0
    // Call recursion for current bill if cash >= curBill, for the next bill if 0 < cash < curBill
    if (cash >= curBill) {
      for (int i = index; i >= 0; i--) {
        var tempBill = bills[i];
        if (i != index) curParam.incrementNumberOfDiffBills();
        curParam.incrementNumberOfBillByKey(tempBill);
        var newParam = this
            .getBestMapOfBills(i, cash - tempBill, bestParam, curParam);

        if (newParam.getNumberOfDiffBills() >
            bestParam.getNumberOfDiffBills()) {
          bestParam = newParam;
        }
        curParam.decrementNumberOfBillByKey(tempBill);
        if (i != index) curParam.decrementNumberOfDiffBills();
      }
    } else {
      if (cash > 0) {
        for (int i = index - 1; i >= 0; i--) {
          var tempBill = bills[i];
          if (cash >= tempBill) {
            curParam.incrementNumberOfDiffBills();
            curParam.incrementNumberOfBillByKey(tempBill);
            var newParam = this.getBestMapOfBills(i, cash - tempBill, bestParam, curParam);
            if (newParam.getNumberOfDiffBills() >
                bestParam.getNumberOfDiffBills()) {
              bestParam = newParam;
            }
            curParam.decrementNumberOfDiffBills();
            curParam.decrementNumberOfBillByKey(tempBill);
          }
        }
      } else {
        // exits from recursion
        bestParam = curParam;
      }
    }
    return bestParam;
  }
}
