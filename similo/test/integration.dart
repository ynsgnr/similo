import 'package:similo_annotations/annotations.dart';
import 'package:source_gen_test/annotations.dart';

import 'src/mocks/screen_utils.dart';

@ShouldGenerate(r'''
class _$Test implements Test {
  final TestValues _values;

  const _$Test(TestValues v) : this._values = v;
  String testFunction(String v) {
    return value.toString() + v;
  }

  Test copyWith(TestValues v) {
    return _$Test(TestValues(
      value: v.value != null ? v.value : this._values.value,
    ));
  }

  //Getters
  get value => _values.value;
}

//Values
class TestValues {
  //Define variables with types
  final int value;

  //Write const constructor
  const TestValues({
    this.value,
  });
}
''')
@Const
abstract class Test {
  final int value;

  String testFunction(String v) {
    return value.toString() + v;
  }

  @CopyWith
  Test copyWith(TestValues v);

  const factory Test(TestValues b) = _$Test;
}

@ShouldGenerate(r'''
class _$TestDefault implements TestDefault {
  final TestDefaultValues _values;

  const _$TestDefault(TestDefaultValues v) : this._values = v;
  TestDefault copyWith(TestDefaultValues v) {
    return _$TestDefault(TestDefaultValues(
      stringValue:
          v.stringValue != "test" ? v.stringValue : this._values.stringValue,
      doubleValue:
          v.doubleValue != 3 ? v.doubleValue : this._values.doubleValue,
      intValue: v.intValue != 4 ? v.intValue : this._values.intValue,
      boolValue: v.boolValue != true ? v.boolValue : this._values.boolValue,
    ));
  }

  //Getters
  get stringValue => _values.stringValue;
  get doubleValue => _values.doubleValue;
  get intValue => _values.intValue;
  get boolValue => _values.boolValue;
}

//Values
class TestDefaultValues {
  //Define variables with types
  final String stringValue;
  final double doubleValue;
  final int intValue;
  final bool boolValue;

  //Write const constructor
  const TestDefaultValues({
    this.stringValue = "test",
    this.doubleValue = 3,
    this.intValue = 4,
    this.boolValue = true,
  });
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

@ShouldGenerate(r'''
class _$TestSomeDefault implements TestSomeDefault {
  final TestSomeDefaultValues _values;

  const _$TestSomeDefault(TestSomeDefaultValues v) : this._values = v;
  TestSomeDefault copyWith(TestSomeDefaultValues v) {
    return _$TestSomeDefault(TestSomeDefaultValues(
      stringValue:
          v.stringValue != "test" ? v.stringValue : this._values.stringValue,
      doubleValue:
          v.doubleValue != 3 ? v.doubleValue : this._values.doubleValue,
      intValue: v.intValue != null ? v.intValue : this._values.intValue,
      boolValue: v.boolValue != null ? v.boolValue : this._values.boolValue,
    ));
  }

  //Getters
  get stringValue => _values.stringValue;
  get doubleValue => _values.doubleValue;
  get intValue => _values.intValue;
  get boolValue => _values.boolValue;
}

//Values
class TestSomeDefaultValues {
  //Define variables with types
  final String stringValue;
  final double doubleValue;
  final int intValue;
  final bool boolValue;

  //Write const constructor
  const TestSomeDefaultValues({
    this.stringValue = "test",
    this.doubleValue = 3,
    this.intValue,
    this.boolValue,
  });
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

@ShouldGenerate(r'''class GivenClass implements TestGivenNameValues {
  final GivenValues _values;

  const GivenClass(GivenValues v) : this._values = v;
  String testFunction(String v) {
    return value.toString() + v;
  }

  TestGivenNameValues copyWith(GivenValues v) {
    return GivenClass(GivenValues(
      value: v.value != null ? v.value : this._values.value,
      nonScallableValue: v.nonScallableValue != null
          ? v.nonScallableValue
          : this._values.nonScallableValue,
    ));
  }

  TestGivenNameValues scale(ScreenUtils screenUtils) {
    return copyWith(GivenValues(
      value: screenUtil.setHeight(value),
    ));
  }

  //Getters
  get value => _values.value;
  get nonScallableValue => _values.nonScallableValue;
}

//Values
class GivenValues {
  //Define variables with types
  final double value;
  final double nonScallableValue;

  //Write const constructor
  const GivenValues({
    this.value,
    this.nonScallableValue,
  });
}
''')
@ConstNamed(className: "GivenClass", valuesName: "GivenValues")
abstract class TestGivenNameValues {
  @ScallableWith(Height)
  final double value;
  @NonScallable
  final double nonScallableValue;

  String testFunction(String v) {
    return value.toString() + v;
  }

  @CopyWith
  TestGivenNameValues copyWith(GivenValues v);

  @Scale
  TestGivenNameValues scale(ScreenUtils screenUtils);

  const factory TestGivenNameValues(GivenValues b) = GivenClass;
}