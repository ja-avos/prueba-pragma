import 'package:equatable/equatable.dart';
import 'package:prueba_pragma/Cats/models/cat_model.dart';
import 'package:prueba_pragma/config/request_state.dart';

/// State for the CatsCubit
class CatState extends Equatable {
  final RequestState state;

  final List<Cat> cats;

  final List<Cat> filteredCats;

  final String? error;

  const CatState({
    this.state = RequestState.INITIAL,
    this.cats = const [],
    this.filteredCats = const [],
    this.error,
  });

  @override
  List<Object?> get props => [
        state,
        cats,
        filteredCats,
        error,
      ];

  CatState copyWith({
    RequestState? state,
    List<Cat>? cats,
    List<Cat>? filteredCats,
    String? error,
  }) {
    return CatState(
      state: state ?? this.state,
      cats: cats ?? this.cats,
      filteredCats: filteredCats ?? this.filteredCats,
      error: error ?? this.error,
    );
  }
}
