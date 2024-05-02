import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_with_api/Features/posts/models/posts_data_ui_model.dart';
import 'package:bloc_with_api/Features/posts/repos/posts_repo.dart';
import 'package:meta/meta.dart';

part 'posts_bloc_event.dart';
part 'posts_bloc_state.dart';

class PostsBlocBloc extends Bloc<PostsBlocEvent, PostsBlocState> {
  PostsBlocBloc() : super(PostsBlocInitial()) {
    on<PostsIntiatialfetchEvent>(postsIntiatialfetchEvent);
    on<PostAddEvent>(postAddEvent);
  }

  FutureOr<void> postsIntiatialfetchEvent(
      PostsIntiatialfetchEvent event, Emitter<PostsBlocState> emit) async {
    emit(FetchingLoadingState());
    List<Temperatures> posts = await PostsRepo.fetchposts();
    emit(PostFetchingsuccessful(posts: posts));
  }

  /* FutureOr<void> postAddEvent(
      PostAddEvent event, Emitter<PostsBlocState> emit) async {
    bool success = await PostsRepo.addPost();
    log('success');
    if (success) {
      emit(PostsAdditionSuccess());
    } else {
      emit(PostsAdditionError());
    }
  }*/
  FutureOr<void> postAddEvent(
      PostAddEvent event, Emitter<PostsBlocState> emit) async {
    try {
      log('Starting postAddEvent');

      bool success = await PostsRepo.addPost();

      log('addPost result: $success');

      if (success) {
        emit(PostsAdditionSuccess());
        log('Emitting PostsAdditionSuccess state');
      } else {
        emit(PostsAdditionError());
        log('Emitting PostsAdditionError state');
      }
    } catch (e) {
      log('Exception in postAddEvent: $e');
      emit(PostsAdditionError());
    }
  }
}
