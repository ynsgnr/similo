import 'package:similo/src/custom_modifier_generator.dart';
import 'package:similo_annotations/annotations.dart';

class ScaleGen extends CustomModifier {
  ScaleGen():super({
    "TextStyle": (String variableName)=>"""$variableName.copyWith(
        fontSize: screenUtils.setSp(this.$variableName.fontSize),
      )""",
    "EdgeInsets": (String variableName)=>"""EdgeInsets.only(
        left: screenUtils.setWidth($variableName.left),
        right: screenUtils.setWidth($variableName.right),
        top: screenUtils.setHeight($variableName.top),
        bottom: screenUtils.setHeight($variableName.bottom),
      )""",
  },annotationName:SimiloBase.SCALECLASS);
}