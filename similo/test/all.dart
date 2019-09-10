import 'dart:async';

import 'package:similo/src/class_generator.dart';
import 'package:similo/src/copy_with_generator.dart';
import 'package:similo_annotations/annotations.dart';
import 'package:source_gen_test/src/build_log_tracking.dart';
import 'package:source_gen_test/src/init_library_reader.dart';
import 'package:source_gen_test/src/test_annotated_classes.dart';

import 'src/element_parser.dart';

Future<void> main() async {
  //Class Definer Tests
  final classGenReader = await initializeLibraryReaderForDirectory(
      'test/src', 'class_generator.dart');
  final copyWithGenReader = await initializeLibraryReaderForDirectory(
      'test/src', 'copy_with_generator.dart');
  initializeBuildLogTracking();
  testAnnotatedElements<SimiloBase>(
    classGenReader,
    const ClassDefiner(),
  ); 
  testAnnotatedElements<SimiloBase>(
    copyWithGenReader,
    const CopyWithGen(),
  );

  test_element_parser();
}
