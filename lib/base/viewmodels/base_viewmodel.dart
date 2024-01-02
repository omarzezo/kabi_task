import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../states/base_state.dart';

abstract class BaseViewModel extends Cubit<BaseState> {
  BaseViewModel() : super(const BaseInitialState()) {
    load();
  }

  bool _isLoading = false;
  bool _isDisposed = false;

  FutureOr<void> _initState;

  FutureOr<void> init();
  FutureOr<bool> createPost(int userId,String title,String body);

  void load() async {
    isLoading = true;
    _initState = init();
    await _initState;
  }

  //Getters
  bool get isLoading => _isLoading;
  bool get isDisposed => _isDisposed;

  //Setters
  set isLoading(bool value) {
    _isLoading = value;
    scheduleMicrotask(() {
      if (!_isDisposed) emit(BaseLoadingSate(_isLoading));
    });
  }

  void reloadState() {
    if (!isLoading) emit(BaseLoadingSate(_isLoading));
  }

  @override
  Future<void> close() async {
    _isDisposed = true;
    super.close();
  }
}
