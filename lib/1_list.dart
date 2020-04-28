void main() {
  final List<int> myList = [3, 1, 2];
  doFunctionalStuff(myList);
  // Use the list, expecting that its order is [3, 1, 2]
  print('Original: $myList');
}

void doSideEffectyStuff(List<int> list) {
  list.sort();
  // Perform an operation which requires sorting (e.g. binary search)
  print('Sorted: $list');
}

void doFunctionalStuff(List<int> list) {
  final copiedList = list.map((item) => item).toList();
  copiedList.sort();
  // Perform an operation which requires sorting (e.g. binary search)
  print('Sorted: $copiedList');
}
