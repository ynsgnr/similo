import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:similo/src/generator.dart';

Builder similoFactory(BuilderOptions options) =>
    SharedPartBuilder([SimiloGenerator()], 'similo');