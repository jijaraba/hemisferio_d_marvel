import 'package:formz/formz.dart';

enum SearchValidation { empty }

class SearchForm extends FormzInput<String, SearchValidation> {
  const SearchForm.pure() : super.pure('');

  const SearchForm.dirty(String value) : super.dirty(value);

  @override
  SearchValidation? validator(String value) {
    if (value.isEmpty) return SearchValidation.empty;
    return null;
  }
}
