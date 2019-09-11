library similoannotations;

class SimiloBase {

  static const String COPYWITHCLASS = "CopyWithAnnotation";
  static const String SCALECLASS = "ScaleAnnotation";
  static const String CONSTCLASS = "ConstAnnotation";
  static const String CONSTNAMEDCLASS = "ConstNamed";
  static const String CUSTOMCLASS = "SimiloCustom";

  const SimiloBase();
}

class SimiloVariableBase {
  const SimiloVariableBase();
}

class ConstAnnotation extends SimiloBase {
  const ConstAnnotation();
}

class CopyWithAnnotation extends SimiloBase {
  const CopyWithAnnotation();
}

class SimiloCustom extends SimiloBase {
  const SimiloCustom();
}

class ScaleAnnotation extends SimiloCustom {
  const ScaleAnnotation();
}

class NonScallableAnnotation extends SimiloVariableBase{
  const NonScallableAnnotation();
}

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
