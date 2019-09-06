import 'package:similo_annotations/annotations.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(r'''
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
''')
@Const
abstract class TestClass {
  final String test;

  const factory TestClass(TestClassValues b) = _$TestClass;
}

@ShouldGenerate(r'''
class _$TestMultipleTypes implements TestMultipleTypes {
  final TestMultipleTypesValues _values;

  const _$TestMultipleTypes(TestMultipleTypesValues v) : this._values = v;

  //Getters
  get stringValue => _values.stringValue;
  get doubleValue => _values.doubleValue;
  get intValue => _values.intValue;
  get boolValue => _values.boolValue;
}

//Values
class TestMultipleTypesValues {
  //Define variables with types
  final String stringValue;
  final double doubleValue;
  final int intValue;
  final bool boolValue;

  //Write const constructor
  const TestMultipleTypesValues({
    this.stringValue,
    this.doubleValue,
    this.intValue,
    this.boolValue,
  });
}
''')
@Const
abstract class TestMultipleTypes {
  final String stringValue;
  final double doubleValue;
  final int intValue;
  final bool boolValue;

  const factory TestMultipleTypes(TestMultipleTypesValues b) =
      _$TestMultipleTypes;
}

@ShouldGenerate(r'''
class _$TestDefault implements TestDefault {
  final TestDefaultValues _values;

  const _$TestDefault(TestDefaultValues v) : this._values = v;

  //Getters
  get stringValue => _values.stringValue;
  get doubleValue => _values.doubleValue;
  get intValue => _values.intValue;
  get boolValue => _values.boolValue;
}

//Values
class TestDefaultValues {
  //Define variables with types
  final String stringValue = "test";
  final double doubleValue = 3;
  final int intValue = 4;
  final bool boolValue = true;

  //Write const constructor
  const TestDefaultValues({
    this.stringValue,
    this.doubleValue,
    this.intValue,
    this.boolValue,
  });
}
''')
@Const
abstract class TestDefault {
  final String stringValue = "test";
  final double doubleValue = 3;
  final int intValue = 4;
  final bool boolValue = true;

  const factory TestDefault(TestDefaultValues b) = _$TestDefault;
}

@ShouldGenerate(r'''
class _$TestEmpty implements TestEmpty {
  final TestEmptyValues _values;

  const _$TestEmpty(TestEmptyValues v) : this._values = v;

  //Getters

}

//Values
class TestEmptyValues {
  //Define variables with types

  //Write const constructor
  const TestEmptyValues();
}
''')
@Const
abstract class TestEmpty {
  const factory TestEmpty(TestEmptyValues b) = _$TestEmpty;
}

@ShouldGenerate(r'''
class _$TestInheritenceBase implements TestInheritenceBase {
  final TestInheritenceBaseValues _values;

  const _$TestInheritenceBase(TestInheritenceBaseValues v) : this._values = v;

  //Getters
  get base => _values.base;
}

//Values
class TestInheritenceBaseValues {
  //Define variables with types
  final String base;

  //Write const constructor
  const TestInheritenceBaseValues({
    this.base,
  });
}
''')
@Const
abstract class TestInheritenceBase {
  final String base;

  const factory TestInheritenceBase(TestInheritenceBaseValues b) =
      _$TestInheritenceBase;
}

@ShouldGenerate(r'''
class _$TestInheritence implements TestInheritence {
  final TestInheritenceValues _values;

  const _$TestInheritence(TestInheritenceValues v) : this._values = v;

  //Getters
  get inherited => _values.inherited;
  get base => _values.base;
}

//Values
class TestInheritenceValues {
  //Define variables with types
  final String inherited;
  final String base;

  //Write const constructor
  const TestInheritenceValues({
    this.inherited,
    this.base,
  });
}
''')
@Const
abstract class TestInheritence extends TestInheritenceBase {
  final String inherited;

  const factory TestInheritence(TestInheritenceValues b) = _$TestInheritence;
}

class TestNonCost {
  double number = 42;
}

@ShouldThrow(
    'Generator cannot target `TestInheritenceFromNonCost` which Inherited non const class.',
    todo:
        'Add const constructor or @Cost to inherited classes of TestInheritenceFromNonCost.')
@Const
abstract class TestInheritenceFromNonCost extends TestNonCost {
  final bool b = true;
}

@ShouldGenerate(r'''
class _$TestInheritenceChain implements TestInheritenceChain {
  final TestInheritenceChainValues _values;

  const _$TestInheritenceChain(TestInheritenceChainValues v) : this._values = v;

  //Getters
  get inheritedThird => _values.inheritedThird;
  get base => _values.base;
  get inherited => _values.inherited;
}

//Values
class TestInheritenceChainValues {
  //Define variables with types
  final bool inheritedThird;
  final String base;
  final String inherited;

  //Write const constructor
  const TestInheritenceChainValues({
    this.inheritedThird,
    this.base,
    this.inherited,
  });
}
''')
@Const
abstract class TestInheritenceChain extends TestInheritence {
  final bool inheritedThird;

  const factory TestInheritenceChain(TestInheritenceChainValues b) =
      _$TestInheritenceChain;
}

//TODO implement
@ShouldGenerate(r'''
''')
@Const
abstract class TestFunctions {
  String testFunction() {
    return "String";
  }

  const factory TestFunctions(TestFunctionsValues b) = _$TestFunctions;
}

@ShouldGenerate(r'''
class _$TestHidden implements TestHidden {
  final TestHiddenValues _values;

  const _$TestHidden(TestHiddenValues v) : this._values = v;

  //Getters

}

//Values
class TestHiddenValues {
  //Define variables with types
  final String thisIsHidden;

  //Write const constructor
  const TestHiddenValues({
    this.thisIsHidden,
  });
}
''')
@Const
abstract class TestHidden {
  final String _thisIsHidden;

  const factory TestHidden(TestHiddenValues b) = _$TestHidden;
}

@ShouldGenerate(r'''
class _$TestHiddenInheritence implements TestHiddenInheritence {
  final TestHiddenInheritenceValues _values;

  const _$TestHiddenInheritence(TestHiddenInheritenceValues v)
      : this._values = v;

  //Getters
  get thisIsNotHidden => _values.thisIsNotHidden;
}

//Values
class TestHiddenInheritenceValues {
  //Define variables with types
  final String thisIsNotHidden;
  final String thisIsHidden;

  //Write const constructor
  const TestHiddenInheritenceValues({
    this.thisIsNotHidden,
    this.thisIsHidden,
  });
}
''')
@Const
abstract class TestHiddenInheritence extends TestHidden {
  final String thisIsNotHidden;

  const factory TestHiddenInheritence(TestHiddenInheritenceValues b) =
      _$TestHiddenInheritence;
}

class TestWithConstructor {
  final int thisIsAValue;
  const TestWithConstructor({this.thisIsAValue});
}

@ShouldGenerate(r'''
class _$TestWithConstructorInheritence
    implements TestWithConstructorInheritence {
  final TestWithConstructorInheritenceValues _values;

  const _$TestWithConstructorInheritence(TestWithConstructorInheritenceValues v)
      : this._values = v;

  //Getters
  get thisIsAValue => _values.thisIsAValue;
  get thisIsANewValue => _values.thisIsANewValue;
}

//Values
class TestWithConstructorInheritenceValues {
  //Define variables with types
  final int thisIsANewValue;
  final int thisIsAValue;

  //Write const constructor
  const TestWithConstructorInheritenceValues({
    this.thisIsANewValue,
    this.thisIsAValue,
  });
}
''')
@Const
abstract class TestWithConstructorInheritence extends TestWithConstructor {
  final int thisIsANewValue;

  const factory TestWithConstructorInheritence(
          TestWithConstructorInheritenceValues b) =
      _$TestWithConstructorInheritence;
}
