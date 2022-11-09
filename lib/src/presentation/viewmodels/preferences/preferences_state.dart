import 'package:freezed_annotation/freezed_annotation.dart';

part 'preferences_state.freezed.dart';

enum PreferencesAction { add, update, remove, removeAll }

@freezed
class PreferencesState with _$PreferencesState {
  const factory PreferencesState.initial() = _PreferencesStateInitial;

  const factory PreferencesState.loading() = _PreferencesStateLoading;

  const factory PreferencesState.success({required PreferencesAction action}) =
      _PreferencesStateSuccess;

  const factory PreferencesState.error([String? error]) =
      _PreferencesStateError;

  const factory PreferencesState.displayingModal() =
      _PreferencesStateDisplayingModal;
}

extension PreferencesStateX on PreferencesState {
  bool get isLoading => this is _PreferencesStateLoading;

  bool get isSuccess => this is _PreferencesStateSuccess;

  PreferencesAction get action => (this as _PreferencesStateSuccess).action;

  bool get isError => this is _PreferencesStateError;

  String? get errorMessage => (this as _PreferencesStateError).error;

  bool get isDisplayingModal => this is _PreferencesStateDisplayingModal;
}
