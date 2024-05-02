part of 'posts_bloc_bloc.dart';

@immutable
sealed class PostsBlocEvent {}

class PostsIntiatialfetchEvent extends PostsBlocEvent {}

class PostAddEvent extends PostsBlocEvent {}
