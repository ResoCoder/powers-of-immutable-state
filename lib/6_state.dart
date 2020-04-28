import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:powers_of_immutable_state_presentation/history.dart';

part '6_state.freezed.dart';

@freezed
abstract class AsyncNumberState with _$AsyncNumberState {
  const factory AsyncNumberState.initial() = _Initial;
  const factory AsyncNumberState.loading() = _Loading;
  const factory AsyncNumberState.loaded(int number) = _Loaded;
}

class AsyncNumberValueNotifier extends ValueNotifier<AsyncNumberState> {
  final _history = History<AsyncNumberState>(AsyncNumberState.initial());
  final _randomGenerator = Random();

  AsyncNumberValueNotifier() : super(const AsyncNumberState.initial());

  @override
  set value(AsyncNumberState newValue) {
    if (newValue is! _Loading) {
      _history.add(newValue);
    }
    super.value = newValue;
  }

  Future<void> fetchNumber() async {
    value = AsyncNumberState.loading();
    await Future.delayed(Duration(seconds: 1));
    value = AsyncNumberState.loaded(_randomGenerator.nextInt(1000));
  }

  void undo() {
    // Bypass our setter override to prevent saving to history
    super.value = _history.previous();
  }

  void redo() {
    super.value = _history.next();
  }
}
