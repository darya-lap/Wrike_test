class ParametersOfAlgorithm {
  /// The number of different bills
  int numberOfDiffBills;

  /// The map of bills and its numbers
  var mapOfBills = new Map<int, int>();

  ParametersOfAlgorithm(numberOfDiffBills, mapOfBills) {
    this.numberOfDiffBills = numberOfDiffBills;
    this.mapOfBills = new Map<int, int>.from(mapOfBills);
  }

  /// Sets map of bills and its numbers from the [newMapOfBills]
  void setMapOfBills(Map<int, int> newMapOfBills) {
    this.mapOfBills = newMapOfBills;
  }

  /// The map of bills and its numbers
  Map<int, int> getMapOfBills() {
    return this.mapOfBills;
  }

  /// Sets number of different bills from the [newNumberOfDiffBills]
  void setNumberOfDiffBills(int newNumberOfDiffBills) {
    this.numberOfDiffBills = newNumberOfDiffBills;
  }

  /// The number of different bills
  int getNumberOfDiffBills() {
    return this.numberOfDiffBills;
  }

  /// Increment number of different bills in this class
  void incrementNumberOfDiffBills() {
    this.numberOfDiffBills++;
  }

  /// Decrement number of different bills in this class
  void decrementNumberOfDiffBills() {
    this.numberOfDiffBills--;
  }

  /// Increment number of bill with key [key] from this.mapOfBills
  void incrementNumberOfBillByKey(int key) {
    this.getMapOfBills()[key]++;
  }

  /// Decrement number of bill with key [key] from this.mapOfBills
  void decrementNumberOfBillByKey(int key) {
    this.getMapOfBills()[key]--;
  }
}
