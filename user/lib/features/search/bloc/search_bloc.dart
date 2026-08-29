import 'package:frontend_user/data/model/item/item_model.dart';
import 'package:frontend_user/features/search/data/search_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchData searchData; // المستودع الخاص بالبحث

  SearchBloc({required this.searchData}) : super(const SearchState()) {
    on<_QueryChanged>(_onQueryChanged);
    on<_ClearSearch>(_onClearSearch);
  }

  Future<void> _onQueryChanged(
    _QueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(
        state.copyWith(status: const SearchStatus.initial(), searchResults: []),
      );
      return;
    }

    emit(state.copyWith(status: const SearchStatus.loading()));

    final response = await searchData.searchResults(event.query);

    response.fold(
      (failure) =>
          emit(state.copyWith(status: SearchStatus.failure(failure.message))),
      (data) {
        if (data.isEmpty) {
          emit(
            state.copyWith(
              status: const SearchStatus.notFound(),
              searchResults: [],
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: const SearchStatus.loaded(),
              searchResults: data,
            ),
          );
        }
      },
    );
  }

  void _onClearSearch(_ClearSearch event, Emitter<SearchState> emit) {
    emit(
      state.copyWith(status: const SearchStatus.initial(), searchResults: []),
    );
  }
}
