import 'dart:async';

import 'package:similo/src/class_generator.dart';
import 'package:similo_annotations/similo_annotations.dart';
import 'package:source_gen_test/source_gen_test.dart';

Future main() async {
  final file =
      await initializeLibraryReaderForDirectory('test/src/class_generator', 'class_generator.dart');
  initializeBuildLogTracking();
  testAnnotatedElements<SimiloBase>(
    file,
    ClassDefiner(),
  );
}