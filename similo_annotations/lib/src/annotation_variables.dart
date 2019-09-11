import 'package:similo_annotations/src/annotations.dart';
import 'package:similo_annotations/src/similo_base.dart';

const Const = ConstAnnotation();
const CopyWith = CopyWithAnnotation();
const Scale = ScaleAnnotation();
const NonScallable = NonScallableAnnotation();

class ConstNamed extends ConstAnnotation {
  final String className;
  final String valuesName;

  //These should be same with variable names
  static const CLASSNAME = "className";
  static const VALUESNAME = "valuesName";

  const ConstNamed({String className, String valuesName})
      : this.className = className,
        this.valuesName = valuesName;
}

const Width = true;
const Height = false;

class ScallableWith extends SimiloVariableBase{
  final bool width;
  final bool height;

  const ScallableWith(bool direction):this.width=direction,this.height=!direction;
}