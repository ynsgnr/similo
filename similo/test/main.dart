import 'dart:async';

import 'package:similo/src/class_generator.dart';
import 'package:similo/src/copy_with_generator.dart';
import 'package:similo/src/custom_modifier_generator.dart';
import 'package:similo_annotations/similo_annotations.dart';
import 'package:source_gen_test/src/build_log_tracking.dart';
import 'package:source_gen_test/src/init_library_reader.dart';
import 'package:source_gen_test/src/test_annotated_classes.dart';

import 'src/parsers/code_parser.dart';

Future<void> main() async {
  //Class Definer Tests
  final classGenReader = await initializeLibraryReaderForDirectory(
      'test/src/class_generator', 'class_generator.dart');
  final copyWithGenReader = await initializeLibraryReaderForDirectory(
      'test/src/copy_with_generator', 'copy_with_generator.dart');
  final customGenReader = await initializeLibraryReaderForDirectory(
      'test/src/custom_modifier_generator', 'custom_modifier_generator.dart');
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
    customGenReader,
    CustomModifier({
      "CustomString": (String variableName)=>"$variableName + ' Customized String ' ",
      "NonExistingValue": (String variableName)=>"",
      "double": (String variableName)=>"$variableName + 1",
    }),
  );  
  testAnnotatedElements<SimiloBase>(
    integration,
    const ClassDefiner(),
  );

  test_code_parser();
}
