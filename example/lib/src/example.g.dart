// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// Generator: ClassDefiner
// **************************************************************************

class _$Example implements Example {
  final ExampleValues _values;

  const _$Example(ExampleValues v) : this._values = v;
  String testFunction(String toAdd) {
    return example + toAdd;
  }

  String testHiddenFunction(String toAdd) {
    return _hiddenValue + toAdd;
  }

  //Getters
  get example => _values.example;
  get exampleWithDefault => _values.exampleWithDefault;
  get _hiddenValue => _values.hiddenValue;
}

//Values
class ExampleValues {
  //Define variables with types
  final String example;
  final String exampleWithDefault;
  final String hiddenValue;

  //Write const constructor
  const ExampleValues({
    this.example,
    this.exampleWithDefault = "this is a default value",
    this.hiddenValue = "hidden",
  });
}
