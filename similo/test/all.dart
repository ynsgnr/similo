import 'dart:async';

import 'package:similo/src/class_generator.dart';
import 'package:similo/src/copy_with_generator.dart';
import 'package:similo_annotations/annotations.dart';
import 'package:source_gen_test/src/build_log_tracking.dart';
import 'package:source_gen_test/src/init_library_reader.dart';
import 'package:source_gen_test/src/test_annotated_classes.dart';

import 'src/parsers/code_parser.dart';

Future<void> main() async {
  //Class Definer Tests
  final classGenReader = await initializeLibraryReaderForDirectory(
      'test/src', 'class_generator.dart');
  final copyWithGenReader = await initializeLibraryReaderForDirectory(
      'test/src', 'copy_with_generator.dart');
  final integration =
      await initializeLibraryReaderForDirectory('test', 'integration.dart');
  initializeBuildLogTracking();
  testAnnotatedElements<SimiloBase>(
    classGenReader,
    const ClassDefiner(),
  );
  testAnnotatedElements<SimiloBase>(
    copyWithGenReader,
    const CopyWithGen(),
  );
  testAnnotatedElements<SimiloBase>(
    integration,
    const ClassDefiner(),
  );

  test_code_parser();
}
