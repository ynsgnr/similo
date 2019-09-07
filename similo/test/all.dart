import 'dart:async';

import 'package:similo/src/class_generator.dart';
import 'package:similo_annotations/annotations.dart';
import 'package:source_gen_test/src/build_log_tracking.dart';
import 'package:source_gen_test/src/init_library_reader.dart';
import 'package:source_gen_test/src/test_annotated_classes.dart';
import 'package:test/test.dart';

import 'src/element_parser.dart';

Future<void> main() async {
  //Class Definer Tests
  final reader = await initializeLibraryReaderForDirectory(
      'test/src', 'class_generator.dart');
  initializeBuildLogTracking();
  testAnnotatedElements<SimiloBase>(
    reader,
    const ClassDefiner(),
  );

  test_element_parser();
}
