import 'dart:io';

/// An internal node structure for the [CircularDoublyLinkedList].
class _Node<T> {
  T data;
  _Node<T>? next;
  _Node<T>? previous;

  _Node(this.data, {this.next, this.previous});
}

/// A generic circular doubly linked list implementation with a Dart-idiomatic interface.
///
/// In this implementation, the tail's next points to the head, and the head's previous points to the tail, forming a continuous circle.
class CircularDoublyLinkedList<T> extends Iterable<T> {
  _Node<T>? _head;
  _Node<T>? _tail;
  int _length = 0;

  /// Constructs an empty [CircularDoublyLinkedList]
  CircularDoublyLinkedList();

  factory CircularDoublyLinkedList.fromIterable(Iterable<T> elements) {
    final list = CircularDoublyLinkedList<T>();
    for (final element in elements) {
      list.addLast(element);
    }
    return list;
  }

  // --- Capacity ---

  @override
  int get length => _length;

  @override
  bool get isEmpty => _length == 0;

  @override
  bool get isNotEmpty => _length > 0;

  // --- Element Access ---

  @override
  T get first {
    if (isEmpty) {
      throw StateError('Cannot access first element of an empty list');
    }
    return _head!.data;
  }

  @override
  T get last {
    if (isEmpty) {
      throw StateError('Cannot access first element of an empty list');
    }
    return _tail!.data;
  }

  T operator [](int index) => _getNodeAt(index).data;

  void operator []=(int index, T value) => _getNodeAt(index).data = value;

  /// Adds an element to the end of the list and maintains circularity.
  void addLast(T value) {
    final newNode = _Node(value);
    if (isEmpty) {
      _head = _tail = newNode;
      newNode.next = newNode;
      newNode.previous = newNode;
    } else {
      newNode.previous = _tail;
      newNode.next = _head;
      _tail!.next = newNode;
      _head!.previous = newNode;
      _tail = newNode;
    }
    _length++;
  }

  /// Adds an element to the front of the list and maintains circularity.
  void addFirst(T value) {
    final newNode = _Node(value);
    if (isEmpty) {
      _head = _tail = newNode;
      newNode.next = newNode;
      newNode.previous = newNode;
    } else {
      newNode.next = _head;
      newNode.previous = _tail;
      _head!.previous = newNode;
      _tail!.next = newNode;
      _head = newNode;
    }
    _length++;
  }

  /// Removes the last element and updates circular pointers.
  T removeLast() {
    if (isEmpty) throw StateError('Cannot remove from an empty list');
    final data = _tail!.data;
    if (_length == 1) {
      _head = _tail = null;
    } else {
      _tail = _tail!.previous;
      _tail!.next = _head;
      _head!.previous = _tail;
    }
    _length--;
    return data;
  }

  /// Removes the first element and updates circular pointers.
  T removeFirst() {
    if (isEmpty) throw StateError('Cannot remove from an empty list');
    final data = _head!.data;
    if (_length == 1) {
      _head = _tail = null;
    } else {
      _head = _head!.next;
      _head!.previous = _tail;
      _tail!.next = _head;
    }
    _length--;
    return data;
  }

  /// Inserts [value] at the specified [index].
  void insert(int index, T value) {
    if (index < 0 || index > _length) throw RangeError.index(index, this);
    if (index == 0) {
      addFirst(value);
    } else if (index == _length) {
      addLast(value);
    } else {
      final nextNode = _getNodeAt(index);
      final previousNode = nextNode.previous!;
      final newNode = _Node(value, next: nextNode, previous: previousNode);
      previousNode.next = newNode;
      nextNode.previous = newNode;
      _length++;
    }
  }

  /// Removes the element at the specified [index].
  T removeAt(int index) {
    if (index < 0 || index >= _length) throw RangeError.index(index, this);
    if (index == 0) return removeFirst();
    if (index == _length - 1) return removeLast();

    final nodeToRemove = _getNodeAt(index);
    nodeToRemove.previous!.next = nodeToRemove.next;
    nodeToRemove.next!.previous = nodeToRemove.previous;
    _length--;
    return nodeToRemove.data;
  }

  /// Removes all elements from the list.
  void clear() {
    _head = _tail = null;
    _length = 0;
  }

  // --- Helpers & Iteration ---

  /// Internal helper to get node at [index] using optimized traversal.
  _Node<T> _getNodeAt(int index) {
    if (index < 0 || index >= _length) throw RangeError.index(index, this);
    _Node<T> current;
    if (index < _length / 2) {
      current = _head!;
      for (int i = 0; i < index; i++) {
        current = current.next!;
      }
    } else {
      current = _tail!;
      for (int i = _length - 1; i > index; i--) {
        current = current.previous!;
      }
    }
    return current;
  }

  @override
  String toString() => "[${join(', ')}]";

  @override
  Iterator<T> get iterator => _CircularIterator<T>(_head, _length);
}

/// Iterator Implementation for [CircularDoublyLinkedList].
class _CircularIterator<T> implements Iterator<T> {
  _Node<T>? _currentNode;
  final int _total;
  int _count = 0;
  T? _currentData;

  _CircularIterator(this._currentNode, this._total);

  @override
  T get current => _currentData as T;

  @override
  bool moveNext() {
    if (_count >= _total || _currentNode == null) return false;
    _currentData = _currentNode!.data;
    _currentNode = _currentNode!.next;
    _count++;
    return true;
  }
}
