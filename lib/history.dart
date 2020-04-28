import 'dart:collection';

class History<T> {
  final Queue<T> _undos;
  final Queue<T> _redos = Queue();

  History(T initialElement) : _undos = Queue.of([initialElement]);

  void add(T element) {
    _undos.addLast(element);
    _redos.clear();
  }

  /// Undo
  T previous() {
    if (_undos.length > 1) {
      final undoneElement = _undos.removeLast();
      _redos.addFirst(undoneElement);
      return _undos.last;
    } else {
      // Return the initial element as it cannot be undone
      return _undos.single;
    }
  }

  /// Redo
  T next() {
    if (_redos.isNotEmpty) {
      final redoneElement = _redos.removeFirst();
      _undos.addLast(redoneElement);
      return redoneElement;
    } else {
      return _undos.last;
    }
  }
}
