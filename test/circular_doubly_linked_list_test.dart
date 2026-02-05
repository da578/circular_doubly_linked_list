import 'package:circular_doubly_linked_list/circular_doubly_linked_list.dart';
import 'package:test/test.dart';

void main() {
  group('CircularDoublyLinkedList Tests', () {
    test('Empty list state', () {
          final list = CircularDoublyLinkedList<int>();
          expect(list.isEmpty, isTrue);
          expect(list.length, 0);
        });

        test('Single element circularity', () {
          final list = CircularDoublyLinkedList<int>();
          list.addFirst(1);
          expect(list.first, equals(list.last));
          expect(list.length, 1);
          expect(list.toList(), [1]);
        });

        test('Multi-element circularity (Forward & Backward)', () {
          final list = CircularDoublyLinkedList<int>.fromIterable([1, 2, 3]);

          expect(list.first, 1);
          expect(list.last, 3);
          expect(list.length, 3);

          list.removeFirst();
          expect(list.first, 2);
          expect(list.last, 3);

          list.addFirst(1);
          list.removeLast();
          expect(list.last, 2);
          expect(list.first, 1);
        });

        test('Bidirectional Traversal logic', () {
          final list = CircularDoublyLinkedList<String>.fromIterable(['A', 'B', 'C']);

          expect(list[0], 'A');
          expect(list[1], 'B');
          expect(list[2], 'C');
        });

        test('Mutation stress test', () {
          final list = CircularDoublyLinkedList<int>();

          for(int i = 0; i < 100; i++) {
            list.addLast(i);
          }

          expect(list.length, 100);
          expect(list.first, 0);
          expect(list.last, 99);

          for(int i = 0; i < 100; i++) {
            list.removeFirst();
          }

          expect(list.isEmpty, isTrue);
        });

        test('Iterator should not loop infinitely', () {
          final list = CircularDoublyLinkedList<int>.fromIterable([1, 2, 3]);
          int count = 0;

          for (var _ in list) {
            count++;
          }

          expect(count, equals(3));
        });

        test('Error handling', () {
          final list = CircularDoublyLinkedList<int>();
          expect(() => list.first, throwsStateError);
          expect(() => list.removeLast(), throwsStateError);
          expect(() => list[5], throwsRangeError);
        });
  });
}
