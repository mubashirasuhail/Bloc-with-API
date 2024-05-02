import 'package:bloc_with_api/Features/posts/bloc/posts_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Postspage extends StatefulWidget {
  const Postspage({super.key});

  @override
  State<Postspage> createState() => _PostspageState();
}

class _PostspageState extends State<Postspage> {
  final PostsBlocBloc postsBlocBloc = PostsBlocBloc();

  @override
  void initState() {
    postsBlocBloc.add(PostsIntiatialfetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Posts Page'),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          hoverColor: const Color.fromRGBO(68, 138, 255, 1),
          child: const Icon(Icons.add),
          onPressed: () {
            postsBlocBloc.add(PostAddEvent());
          }),
      body: BlocConsumer<PostsBlocBloc, PostsBlocState>(
        bloc: postsBlocBloc,
        listenWhen: (previous, current) => current is PostActionstate,
        buildWhen: (previous, current) => current is! PostActionstate,
        listener: (context, state) {
          print('Current state: $state');
          if (state is PostsAdditionSuccess) {
            print('Post added successfully');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Post added successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is PostsAdditionError) {
            print('Error adding post');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error adding post!'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case FetchingLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostFetchingsuccessful:
              final successstate = state as PostFetchingsuccessful;
              return Container(
                child: ListView.builder(
                  itemCount: successstate.posts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.grey.shade200,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(successstate.posts[index].title),
                          const SizedBox(height: 10),
                          Text(successstate.posts[index].body),
                        ],
                      ),
                    );
                  },
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),

      /*bloc: postsBlocBloc,
        listenWhen: (previous, current) => current is PostActionstate,
        buildWhen: (previous, current) => current is! PostActionstate,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case FetchingLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostFetchingsuccessful:
              final successstate = state as PostFetchingsuccessful;
              return Container(
                child: ListView.builder(
                  itemCount: successstate.posts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.grey.shade200,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(successstate.posts[index].title),
                          SizedBox(height: 10),
                          Text(successstate.posts[index].body)
                        ],
                      ),
                    );
                  },
                ),
              );
            default:
              return const SizedBox();
          }});,
       */
    );
  }
}
