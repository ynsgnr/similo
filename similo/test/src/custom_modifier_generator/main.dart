import 'dart:async';

import 'package:similo/src/custom_modifier_generator.dart';
import 'package:similo_annotations/annotations.dart';
import 'package:source_gen_test/source_gen_test.dart';

Future main() async {
  final file =
      await initializeLibraryReaderForDirectory('test/src/custom_modifier_generator', 'custom_modifier_generator.dart');
  initializeBuildLogTracking();
  testAnnotatedElements<SimiloBase>(
    file,
    CustomModifier({
      "CustomString": (String variableName)=>"$variableName + ' Customized String ' ",
      "NonExistingValue": (String variableName)=>"",
    }),
  );
}