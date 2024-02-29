import 'package:editor_app/features/home/presentation/cubit/download_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final QuillController _quillController = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          QuillToolbar.simple(
            configurations:
                QuillSimpleToolbarConfigurations(controller: _quillController),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: QuillEditor.basic(
                configurations: QuillEditorConfigurations(
                  controller: _quillController,
                  readOnly: false,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<DownloadCubit>().downloadTheCurrentFile(
            _quillController.document.toDelta().toJson()),
        tooltip: 'Download',
        child: BlocConsumer<DownloadCubit, DownloadState>(
          builder: (context, state) {
            return state.map(
              initial: (initial) => const Icon(Icons.download),
              loading: (loading) => const CupertinoActivityIndicator(),
              downloading: (downloading) => const CupertinoActivityIndicator(),
              success: (success) => const Icon(Icons.download),
              error: (error) => const Icon(Icons.download),
            );
          },
          listener: (BuildContext context, DownloadState state) {
            state.mapOrNull(
              error: (error) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error.error.toString()),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
