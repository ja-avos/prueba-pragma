import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_pragma/Cats/bloc/cats_state.dart';
import 'package:prueba_pragma/Cats/models/cat_model.dart';
import 'package:prueba_pragma/Cats/repository/cats_repository.dart';
import 'package:prueba_pragma/config/request_state.dart';

/// Cubit for managing the state of the cats
class CatsCubit extends Cubit<CatState> {
  final CatsRepository _catsRepository;

  CatsCubit()
      : _catsRepository = CatsRepository(),
        super(const CatState());

  /// Fetches the cats from the API
  Future<void> fetchCats() async {
    print('Fetching cats...');
    emit(const CatState(
      state: RequestState.LOADING,
      cats: [],
    ));
    try {
      final cats = await _catsRepository.fetchCats();
      emit(CatState(
        state: RequestState.SUCCESS,
        cats: cats,
        filteredCats: cats,
      ));
      print('Fetched ${cats.length} cats');
    } catch (e) {
      print("""Error fetching cats: $e""");
      emit(CatState(
        state: RequestState.ERROR,
        error: e.toString(),
      ));
    }
  }

  /// Filters the cats by name
  void filterCats(String name) {
    final filteredCats = state.cats
        .where((cat) => cat.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
    emit(state.copyWith(filteredCats: filteredCats));
  }

  /// Clear the state
  void clear() {
    emit(const CatState());
  }
}
