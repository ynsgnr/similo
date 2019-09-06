import 'dart:async';

import 'package:similo/src/class_generator.dart';
import 'package:similo_annotations/annotations.dart';
import 'package:source_gen_test/src/build_log_tracking.dart';
import 'package:source_gen_test/src/init_library_reader.dart';
import 'package:source_gen_test/src/test_annotated_classes.dart';

Future<void> main() async {
  final reader = await initializeLibraryReaderForDirectory(
      'test/src', 'class_generator.dart');

  initializeBuildLogTracking();
  testAnnotatedElements<SimiloBase>(
    reader,
    const ClassDefiner(),
  );
}