// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// Generator: ClassDefiner
// **************************************************************************

class _$Example implements Example {
  final ExampleValues _values;

  const _$Example(ExampleValues v) : this._values = v;
  testFunction(String toAdd) {
    return exampleWithDefault + toAdd;
  }

  testHiddenFunction(String toAdd) {
    return _hiddenValue + toAdd;
  }

  Example copyObject(ExampleValues v) {
    return _$Example(ExampleValues(
      example: v.example != null ? v.example : this._values.example,
      exampleWithDefault: v.exampleWithDefault != "this is a default value"
          ? v.exampleWithDefault
          : this._values.exampleWithDefault,
      hiddenValue:
          v.hiddenValue != "hidden" ? v.hiddenValue : this._values.hiddenValue,
      scaleThis: v.scaleThis != null ? v.scaleThis : this._values.scaleThis,
      dontScaleThis: v.dontScaleThis != null
          ? v.dontScaleThis
          : this._values.dontScaleThis,
    ));
  }

  scaleFun(ScreenUtils screenUtils) {
    return copyObject(ExampleValues(
      scaleThis: screenUtils.setWidth(scaleThis),
    ));
  }

  //Getters
  get example => _values.example;
  get exampleWithDefault => _values.exampleWithDefault;
  get _hiddenValue => _values.hiddenValue;
  get scaleThis => _values.scaleThis;
  get dontScaleThis => _values.dontScaleThis;
}

//Values
class ExampleValues {
  //Define variables with types
  final String example;
  final String exampleWithDefault;
  final String hiddenValue;
  final double scaleThis;
  final double dontScaleThis;

  //Write const constructor
  const ExampleValues({
    this.example,
    this.exampleWithDefault = "this is a default value",
    this.hiddenValue = "hidden",
    this.scaleThis,
    this.dontScaleThis,
  });
}
