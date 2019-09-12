import 'dart:async';

import 'package:similo/src/copy_with_generator.dart';
import 'package:similo_annotations/similo_annotations.dart';
import 'package:source_gen_test/source_gen_test.dart';

Future main() async {
  final file =
      await initializeLibraryReaderForDirectory('test/src/copy_with_generator', 'copy_with_generator.dart');
  initializeBuildLogTracking();
  testAnnotatedElements<SimiloBase>(
    file,
    CopyWithGen(),
  );
}