import 'package:formz/formz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marvel_hemisferio/src/core/forms/character/character_form.dart';

class CharacterFormState with FormzMixin {
  CharacterFormState({
    this.search = const SearchForm.pure(),
  });

  final SearchForm search;

  CharacterFormState copyWith({
    SearchForm? search,
  }) =>
      CharacterFormState(
        search: search ?? this.search,
      );

  @override
  List<FormzInput> get inputs => [
        search,
      ];
}

class CharacterFormNotifier extends StateNotifier<CharacterFormState> {
  CharacterFormNotifier() : super(CharacterFormState());

  void changeSearch(String value) {
    state = state.copyWith(search: SearchForm.dirty(value));
  }
}

final characterNotifierPod = StateNotifierProvider.autoDispose<
    CharacterFormNotifier, CharacterFormState>(
  (ref) => CharacterFormNotifier(),
);
