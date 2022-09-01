abstract class SearchState{}
class InitState extends SearchState{}
class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {}

class SearchErrorState extends SearchState {
  final error;
  SearchErrorState(this.error);
}