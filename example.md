# Example

```dart
//Defining class as const
const TestClass t = const TestClass(TestClassValues(test: "test"));

//Class we write by hand
@Const
abstract class TestClass {
  final String test;

  @ScallableWith(Height)
  final double value;
  
  const factory TestClass(TestClassValues b) = _$TestClass;
  
  String testFunction(String v) {
    return value.toString() + v;
  }

  @CopyWith
  TestGivenNameValues copyWith(GivenValues v);

  @Scale
  TestGivenNameValues scale(ScreenUtils screenUtils);
}

//Generated code:
//We can add new function to be generated on _$TestClass class

class _$TestClass implements TestClass{
  final TestClassValues _values;
  
  const _$TestClass(TestClassValues v):this._values=v;

  TestClass copyWith(TestClassValues v) {
    return GivenClass(GivenValues(
      value: v.value != null ? v.value : this._values.value,
      nonScallableValue: v.nonScallableValue != null
          ? v.nonScallableValue
          : this._values.nonScallableValue,
    ));
  }

  TestClass scale(ScreenUtils screenUtils) {
    return copyWith(TestClassValues(
      value: screenUtil.setHeight(value),
    ));
  }

  String get test => _values.test;
  String get value => _values.value;
}

class TestClassValues{
  final String test;
  final double value;
  const TestClassValues({this.test,this.value,});
}
```