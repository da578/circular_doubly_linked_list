# Circular Doubly Linked List

A robust, generic, and high-performance **Circular Doubly Linked List** implementation for Dart. 

This package provides a bidirectional linked list where the last node points back to the first node and vice versa, ensuring a continuous loop that is ideal for circular buffers, round-robin scheduling, or carousel-like data structures.

## Features

* **Circular Architecture**: The tail's `next` points to the head, and the head's `previous` points to the tail.
* **Constant Time Operations**: O(1) complexity for `addFirst`, `addLast`, `removeFirst`, and `removeLast`.
* **Optimized Index Access**: Element access via `operator[]` uses an optimized traversal (O(n/2)) by determining the shortest path from either the head or tail.
* **Dart-Idiomatic Iteration**: Implements `Iterable<T>`, allowing you to use `for-in` loops, `map`, `where`, and other standard Dart collection methods.
* **Infinite Loop Protection**: The custom iterator is designed to traverse the list exactly once per iteration cycle, preventing infinite loops despite the circular structure.
* **Comprehensive Testing**: Includes unit tests for circularity, stress testing, and error handling.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  circular_doubly_linked_list: ^1.0.0
```

## Usage

**Basic Operations**

```dart
import 'package:circular_doubly_linked_list/circular_doubly_linked_list.dart';

void main() {
  // Initialize from an existing Iterable
  final list = CircularDoublyLinkedList<int>.fromIterable([1, 2, 3]);

  // Add elements to both ends
  list.addFirst(0);
  list.addLast(4);

  print(list); // Output: [0, 1, 2, 3, 4]
  
  // Access elements by index
  print('Middle element: ${list[2]}'); // 2
  
  // Remove elements
  list.removeFirst();
  list.removeLast();
  
  print('Length: ${list.length}'); // 3
}
```

**Iteration**

Because the list extends `Iterable`, you can use it like any other Dart collection:

```dart
final list = CircularDoublyLinkedList<String>.fromIterable(['A', 'B', 'C']);

// The iterator handles circularity and stops after one full cycle
for (final item in list) {
  print('Node: $item');
}

// Functional style
final joined = list.map((e) => '[$e]').join(' <-> ');
print(joined); // [A] <-> [B] <-> [C]
````

## API Reference

## API Reference

| Method | Complexity | Description |
| :--- | :--- | :--- |
| `addFirst(T)` | O(1) | Adds an element to the front. |
| `addLast(T)` | O(1) | Adds an element to the end. |
| `removeFirst()` | O(1) | Removes and returns the first element. |
| `removeLast()` | O(1) | Removes and returns the last element. |
| `insert(index, T)` | O(n) | Inserts an element at a specific index. |
| `removeAt(index)` | O(n) | Removes the element at a specific index. |
| `operator[](index)` | O(n/2) | Accesses the element at the given index. |
| `clear()` | O(1) | Removes all elements from the list. |

## Running Tests

To ensure the circularity logic remains intact during development, run the included test suite:

```bash
dart test
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
