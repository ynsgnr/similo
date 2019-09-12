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

  //Getters
  get exampleWithDefault => _values.exampleWithDefault;
  get _hiddenValue => _values.hiddenValue;
  get scaleThis => _values.scaleThis;
  get dontScaleThis => _values.dontScaleThis;
}

//Values
class ExampleValues {
  //Define variables with types
  final String exampleWithDefault;
  final String hiddenValue;
  final double scaleThis;
  final double dontScaleThis;

  //Write const constructor
  const ExampleValues({
    this.exampleWithDefault = "this is a default value",
    this.hiddenValue = "hidden",
    this.scaleThis,
    this.dontScaleThis,
  });
}
