import 'package:build/build.dart';
import 'package:similo/src/class_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder similoFactory(BuilderOptions options) =>
    SharedPartBuilder([ClassDefiner()], 'similo');
