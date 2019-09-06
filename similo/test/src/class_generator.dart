
import 'package:similo_annotations/annotations.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(
  r'''
class _$TestClass implements TestClass {
  final TestClassValues _values;

  const _$TestClass(TestClassValues v) : this._values = v;

  //Getters
  get test => _values.test;
}

//Values
class TestClassValues {
  //Define variables with types
  final String test;

  //Write const constructor
  const TestClassValues({
    this.test,
  });
}
'''
)
@Const
abstract class TestClass {
  final String test;
  
  const factory TestClass(TestClassValues b) = _$TestClass;
}