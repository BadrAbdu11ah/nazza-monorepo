part of 'search_bloc.dart';

@freezed
class SearchStatus with _$SearchStatus {
  const factory SearchStatus.initial() = _Initial;
  const factory SearchStatus.loading() = _Loading;
  const factory SearchStatus.loaded() = _Loaded;
  const factory SearchStatus.notFound() = _NotFound;
  const factory SearchStatus.failure(String errorMessage) = _Failure;
}

@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState({
    @Default(SearchStatus.initial()) SearchStatus status,
    @Default([]) List<ItemModel> searchResults,
  }) = _SearchState;
}
