import 'package:build/build.dart';
import 'package:similo/src/class_generator.dart';
import 'package:similo/src/copy_with_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:similo/src/const_generator.dart';

Builder similoFactory(BuilderOptions options) =>
    SharedPartBuilder([ClassDefiner(),ConstGenerator(),CopyWithGenerator(),ClassEncloser()], 'similo');