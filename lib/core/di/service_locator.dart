import 'package:editor_app/core/editor/docx_generator.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  sl.registerLazySingleton<DocxGenerator>(() => DocxGeneratorImpl());
}
