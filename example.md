# Example

```dart
//Defining class as const
const TestClass t = const TestClass(TestClassValues(test: "test"));

//Class we write by hand
@Const
abstract class TestClass {
  final String test;
  
  const factory TestClass(TestClassValues b) = _$TestClass;

  //Any additional functions must be added here
  //This ensures generated code doesnt add random functions
  //And control is on the hands of progrommer
  //This also means we can use 
  @CopyWith
  TestClass copyWith(TestClassValues);

  @Scale
  TestClass scale(ScreenUtil);
}

//Generated code:
//We can add new function to be generated on _$TestClass class

class _$TestClass implements TestClass{
  final TestClassValues _values;
  
  const _$TestClass(TestClassValues v):this._values=v;

  String get test => _values.test;
}

class TestClassValues{
  final String test;
  const TestClassValues({this.test,});
}
```