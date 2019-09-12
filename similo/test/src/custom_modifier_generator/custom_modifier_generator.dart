import 'package:similo_annotations/annotations.dart';
import 'package:source_gen_test/annotations.dart';
import 'package:source_gen_test/source_gen_test.dart';

import '../mocks/custom_string.dart';

@ShouldGenerate(r'''TestCustomGen customTest() {
  return copyWith(TestCustomGenValues(
    customString: customString + ' Customized String ',
  ));
}
''')
@Const
abstract class TestCustomGen {
  final String base;
  final CustomString customString;

  @CopyWith
  TestCustomGen copyWith(TestCustomGenValues v);

  @SimiloCustom()
  TestCustomGen customTest();

  const factory TestCustomGen(TestCustomGenValues v) = _$TestCustomGen;
}

@ShouldGenerate(r'''TestCustomGenNamedCopyWith customTest() {
  return namedCopyWith(TestCustomGenNamedCopyWithValues(
    customString: customString + ' Customized String ',
  ));
}
''')
@Const
abstract class TestCustomGenNamedCopyWith {
  final String base;
  final CustomString customString;

  @CopyWith
  TestCustomGenNamedCopyWith namedCopyWith(TestCustomGenNamedCopyWithValues v);

  @SimiloCustom()
  TestCustomGenNamedCopyWith customTest();

  const factory TestCustomGen(TestCustomGenValues v) = _$TestCustomGen;
}

@ShouldGenerate(r'''TestCustomGenDefaults customTest() {
  return copyWith(TestCustomGenDefaultsValues(
    customString: customString + ' Customized String ',
  ));
}
''')
@Const
abstract class TestCustomGenDefaults {
  final String base = "Base";
  final CustomString customString = "Custom String";

  @CopyWith
  TestCustomGenDefaults copyWith(TestCustomGenDefaultsValues v);

  @SimiloCustom()
  TestCustomGenDefaults customTest();

  const factory TestCustomGen(TestCustomGenDefaultsValues v) = _$TestCustomGenDefaults;
}

@ShouldGenerate(r'''TestCustomGenSomeDefaults customTest() {
  return copyWith(TestCustomGenSomeDefaultsValues(
    customString: customString + ' Customized String ',
    value: value + 1,
  ));
}
''')
@Const
abstract class TestCustomGenSomeDefaults {
  final String base = "Base";
  final CustomString customString = "Custom String";
  final double value;

  @CopyWith
  TestCustomGenSomeDefaults copyWith(TestCustomGenSomeDefaultsValues v);

  @SimiloCustom()
  TestCustomGenSomeDefaults customTest();

  const factory TestCustomGenSomeDefaults(TestCustomGenSomeDefaultsValues v) = _$TestCustomGenSomeDefaults;
}

@ShouldGenerate(r'''TestCustomGenInput customTest(String toAdd) {
  return copyWith(TestCustomGenInputValues(
    customString: customString + ' Customized String ',
    value: value + 1,
  ));
}
''')
@Const
abstract class TestCustomGenInput {
  final String base = "Base";
  final CustomString customString = "Custom String";
  final double value;

  @CopyWith
  TestCustomGenInput copyWith(TestCustomGenInputValues v);

  @SimiloCustom()
  TestCustomGenInput customTest(String toAdd);

  const factory TestCustomGenInputValues(TestCustomGenInputValues v) = _$TestCustomGenInput;
}

@ShouldGenerate(r'''TestGivenNameValues customTest(String toAdd) {
  return copyWith(GivenValues(
    customString: customString + ' Customized String ',
  ));
}
''')
@ConstNamed(className: "GivenClass", valuesName: "GivenValues")
abstract class TestGivenNameValues {
  final int value;
  final CustomString customString;

  String testFunction(String v) {
    return value.toString() + v;
  }

  @CopyWith
  TestGivenNameValues copyWith(GivenValues v);
  
  @SimiloCustom()
  TestGivenNameValues customTest(String toAdd);

  const factory TestGivenNameValues(GivenValues b) = GivenClass;
}

@ShouldGenerate(r'''TestGivenName customTest(String toAdd) {
  return copyWith(TestGivenNameValues(
    customString: customString + ' Customized String ',
  ));
}
''')
@ConstNamed(className: "GivenClass")
abstract class TestGivenName {
  final int value;
  final CustomString customString;

  String testFunction(String v) {
    return value.toString() + v;
  }

  @CopyWith
  TestGivenName copyWith(TestGivenNameValues v);

  @SimiloCustom()
  TestGivenName customTest(String toAdd);

  const factory TestGivenName(TestGivenNameValues b) = GivenClass;
}

@ShouldGenerate(r'''TestGivenValues customTest(String toAdd) {
  return copyWith(GivenValues(
    customString: customString + ' Customized String ',
  ));
}
''')
@ConstNamed(valuesName: "GivenValues")
abstract class TestGivenValues {
  final int value;
  final CustomString customString;

  String testFunction(String v) {
    return value.toString() + v;
  }

  @CopyWith
  TestGivenValues copyWith(GivenValues v);

  
  @SimiloCustom()
  TestGivenValues customTest(String toAdd);

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

@ShouldGenerate(r'''TestCustomInput customTest(CustomString toAdd) {
  return copyWith(TestCustomInputValues(
    customString: customString + ' Customized String ',
  ));
}
''')
@Const
abstract class TestCustomInput {
  final int value;
  final CustomString customString;

  String testFunction(String v) {
    return value.toString() + v;
  }

  @CopyWith
  TestCustomInput copyWith(TestCustomInputValues v);
  
  @SimiloCustom()
  TestCustomInput customTest(CustomString toAdd);

  const factory TestCustomInput(TestCustomInputValues b) = _$TestCustomInput;
}

@ShouldGenerate(r'''TestCustomGenExclusiveAnnotation customTest() {
  return copyWith(TestCustomGenExclusiveAnnotationValues());
}
''')
@Const
abstract class TestCustomGenExclusiveAnnotation {
  final String base;
  @NonScallableAnnotation()
  final CustomString customString;

  @CopyWith
  TestCustomGenExclusiveAnnotation copyWith(TestCustomGenExclusiveAnnotationValues v);

  @SimiloCustom()
  TestCustomGenExclusiveAnnotation customTest();

  const factory TestCustomGenExclusiveAnnotation(TestCustomGenExclusiveAnnotationValues v) = _$TestCustomGenExclusiveAnnotation;
}

@ShouldGenerate(r'''TestCustomGenCustomAnnotation customTest() {
  return copyWith(TestCustomGenCustomAnnotationValues(
    value: screenUtils.setWidth(value),
  ));
}
''')
@Const
abstract class TestCustomGenCustomAnnotation {
  final String base;
  @ScallableWith(Width)
  final double value;

  @CopyWith
  TestCustomGenCustomAnnotation copyWith(TestCustomGenCustomAnnotationValues v);

  @SimiloCustom()
  TestCustomGenCustomAnnotation customTest();

  const factory TestCustomGenCustomAnnotation(TestCustomGenCustomAnnotationValues v) = _$TestCustomGenCustomAnnotation;
}



@ShouldGenerate(r'''TestCustomGenNotValidAnnotation customTest() {
  return copyWith(TestCustomGenNotValidAnnotationValues(
    value: value + 1,
  ));
}
''')
@Const
abstract class TestCustomGenNotValidAnnotation {
  final String base;
  @Const
  final double value;

  @CopyWith
  TestCustomGenNotValidAnnotation copyWith(TestCustomGenNotValidAnnotationValues v);

  @SimiloCustom()
  TestCustomGenNotValidAnnotation customTest();

  const factory TestCustomGenNotValidAnnotation(TestCustomGenNotValidAnnotationValues v) = _$TestCustomGenNotValidAnnotation;
}