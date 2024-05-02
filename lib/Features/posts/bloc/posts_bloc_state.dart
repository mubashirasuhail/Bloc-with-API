part of 'posts_bloc_bloc.dart';

@immutable
abstract class PostsBlocState {}

abstract class PostActionstate extends PostsBlocState {}

final class PostsBlocInitial extends PostsBlocState {}

class FetchingLoadingState extends PostsBlocState {}

class FetchingErrorState extends PostsBlocState {}

class PostFetchingsuccessful extends PostsBlocState {
  final List<Temperatures> posts;

  PostFetchingsuccessful({required this.posts});
}

class PostsAdditionSuccess extends PostActionstate {}

class PostsAdditionError extends PostActionstate {}
