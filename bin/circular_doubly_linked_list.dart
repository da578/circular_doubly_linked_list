import 'package:circular_doubly_linked_list/circular_doubly_linked_list.dart';

void main() {
  print('--- Circular Doubly Linked List Demo ---');

  final list = CircularDoublyLinkedList<int>.fromIterable([1, 2, 3]);
  print('Initial List: ${list.toList()}');

  list.addFirst(0);
  list.addLast(4);
  print('After adding 0 (front) and 4 (back): $list');

  print('Iterating: ${list.map((e) => "Node($e)").join(" <-> ")}');

  print('\nAfter removing index 2: ${list.toList()}');

  list.clear();
  print('List cleared. Is empty? ${list.isEmpty}');
}
