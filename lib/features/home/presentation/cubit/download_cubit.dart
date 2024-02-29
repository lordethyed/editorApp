import 'package:editor_app/core/editor/docx_generator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'download_state.dart';
part 'download_cubit.freezed.dart';

class DownloadCubit extends Cubit<DownloadState> {
  final DocxGenerator docxGenerator;
  DownloadCubit({required this.docxGenerator})
      : super(const DownloadState.initial());

  void downloadTheCurrentFile(List<Map<String, dynamic>> json) async {
    emit(const DownloadState.loading());
    try {
      print(json);
      emit(const DownloadState.success());
    } on Exception catch (error) {
      emit(DownloadState.error(error));
    }
  }
}
