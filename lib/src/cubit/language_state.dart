part of 'language_cubit.dart';

@immutable
abstract class LanguageState extends Equatable {
  const LanguageState(this.locale);

  final Locale locale;

  @override
  List<Object?> get props => [locale];
}

class LanguageInitial extends LanguageState {
  const LanguageInitial(super.locale);
}
