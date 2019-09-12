import 'package:similo_annotations/similo_annotations.dart';
import 'package:source_gen_test/annotations.dart';
import 'package:source_gen_test/source_gen_test.dart';

@ShouldGenerate(r'''TestCopyWith copyWith(TestCopyWithValues v) {
  return _$TestCopyWith(TestCopyWithValues(
    base: v.base != null ? v.base : this._values.base,
  ));
}
''')
@Const
abstract class TestCopyWith {
  final String base;

  @CopyWith
  TestCopyWith copyWith(TestCopyWithValues v);

  const factory TestCopyWith(TestCopyWithValues v) = _$TestCopyWith;
}

@ShouldGenerate(r'''TestHidden copyWith(TestHiddenValues v) {
  return _$TestHidden(TestHiddenValues(
    thisIsHidden:
        v.thisIsHidden != null ? v.thisIsHidden : this._values.thisIsHidden,
  ));
}
''')
@Const
abstract class TestHidden {
  final String _thisIsHidden;

  @CopyWith
  TestHidden copyWith(TestHiddenValues v);

  const factory TestHidden(TestHiddenValues b) = _$TestHidden;
}

@ShouldGenerate(r'''TestCopyWithNamed differentName(TestCopyWithNamedValues v) {
  return _$TestCopyWithNamed(TestCopyWithNamedValues(
    base: v.base != null ? v.base : this._values.base,
  ));
}
''')
@Const
abstract class TestCopyWithNamed {
  final String base;

  @CopyWith
  TestCopyWithNamed differentName(TestCopyWithNamedValues v);

  const factory TestCopyWithNamed(TestCopyWithNamedValues v) = _$TestCopyWith;
}

@ShouldGenerate(r'''TestDefault copyWith(TestDefaultValues v) {
  return _$TestDefault(TestDefaultValues(
    stringValue:
        v.stringValue != "test" ? v.stringValue : this._values.stringValue,
    doubleValue: v.doubleValue != 3 ? v.doubleValue : this._values.doubleValue,
    intValue: v.intValue != 4 ? v.intValue : this._values.intValue,
    boolValue: v.boolValue != true ? v.boolValue : this._values.boolValue,
  ));
}
''')
@Const
abstract class TestDefault {
  final String stringValue = "test";
  final double doubleValue = 3;
  final int intValue = 4;
  final bool boolValue = true;

  @CopyWith
  TestDefault copyWith(TestDefaultValues v);

  const factory TestDefault(TestDefaultValues b) = _$TestDefault;
}

@ShouldGenerate(r'''TestSomeDefault copyWith(TestSomeDefaultValues v) {
  return _$TestSomeDefault(TestSomeDefaultValues(
    stringValue:
        v.stringValue != "test" ? v.stringValue : this._values.stringValue,
    doubleValue: v.doubleValue != 3 ? v.doubleValue : this._values.doubleValue,
    intValue: v.intValue != null ? v.intValue : this._values.intValue,
    boolValue: v.boolValue != null ? v.boolValue : this._values.boolValue,
  ));
}
''')
@Const
abstract class TestSomeDefault {
  final String stringValue = "test";
  final double doubleValue = 3;
  final int intValue;
  final bool boolValue;

  @CopyWith
  TestSomeDefault copyWith(TestSomeDefaultValues v);

  const factory TestSomeDefault(TestSomeDefaultValues b) = _$TestSomeDefault;
}

@ShouldGenerate(r'''TestEmpty copyWith(TestEmptyValues v) {
  return _$TestEmpty(TestEmptyValues());
}
''')
@Const
abstract class TestEmpty {
  @CopyWith
  TestEmpty copyWith(TestEmptyValues v);

  const factory TestEmpty(TestEmptyValues b) = _$TestEmpty;
}

@ShouldGenerate(r'''TestInheritence copyWith(TestInheritenceValues v) {
  return _$TestInheritence(TestInheritenceValues(
    inherited: v.inherited != null ? v.inherited : this._values.inherited,
    base: v.base != null ? v.base : this._values.base,
  ));
}
''')
@Const
abstract class TestInheritence extends TestCopyWith {
  final String inherited;

  @CopyWith
  TestInheritence copyWith(TTestInheritenceValues v);

  const factory TestInheritence(TestInheritenceValues b) = _$TestInheritence;
}

@ShouldGenerate(r'''TestGivenNameValues copyWith(GivenValues v) {
  return GivenClass(GivenValues(
    value: v.value != null ? v.value : this._values.value,
  ));
}
''')
@ConstNamed(className: "GivenClass", valuesName: "GivenValues")
abstract class TestGivenNameValues {
  final int value;

  String testFunction(String v) {
    return value.toString() + v;
  }

  @CopyWith
  TestGivenNameValues copyWith(GivenValues v);

  const factory TestGivenNameValues(GivenValues b) = GivenClass;
}

@ShouldGenerate(r'''TestGivenName copyWith(TestGivenNameValues v) {
  return GivenClass(TestGivenNameValues(
    value: v.value != null ? v.value : this._values.value,
  ));
}
''')
@ConstNamed(className: "GivenClass")
abstract class TestGivenName {
  final int value;

  String testFunction(String v) {
    return value.toString() + v;
  }

  @CopyWith
  TestGivenName copyWith(TestGivenNameValues v);

  const factory TestGivenName(TestGivenNameValues b) = GivenClass;
}

@ShouldGenerate(r'''TestGivenValues copyWith(GivenValues v) {
  return _$TestGivenValues(GivenValues(
    value: v.value != null ? v.value : this._values.value,
  ));
}
''')
@ConstNamed(valuesName: "GivenValues")
abstract class TestGivenValues {
  final int value;

  String testFunction(String v) {
    return value.toString() + v;
  }

  @CopyWith
  TestGivenValues copyWith(GivenValues v);

  const factory TestGivenValues(GivenValues b) = _$TestGivenValues;
}

@ShouldGenerate(r'''

''')
@Const
abstract class TestNoAnnotations {
  final int value;

  String testFunction(String v) {
    return value.toString() + v;
  }

  const factory TestNoAnnotations(TestNoAnnotationsValues b) =
      _$TestNoAnnotations;
}

@ShouldGenerate(r'''

''')
@ConstNamed(className: "GivenClass", valuesName: "GivenValues")
abstract class TestNoAnnotationNamed {
  final int value;

  String testFunction(String v) {
    return value.toString() + v;
  }

  const factory TestNoAnnotationNamed(TestNoAnnotationNamedValues b) =
      _$TestNoAnnotationNamed;
}
