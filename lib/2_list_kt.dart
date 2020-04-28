import 'package:kt_dart/kt.dart';

void main() {
  final KtList<int> myList = listOf(3, 1, 2);
  doStuff(myList);
  // Use the list, expecting that its order is [3, 1, 2]
  print('Original: $myList');
}

void doStuff(KtList<int> list) {
  final sortedList = list.sorted();
  // Perform an operation which requires sorting (e.g. binary search)
  print('Sorted: $sortedList');
}
