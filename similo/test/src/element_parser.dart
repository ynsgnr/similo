import 'package:similo/src/element_parser.dart';
import 'package:test/test.dart';

void test_element_parser() {
  group("Element Parser Unit Tests", () {
    group("getBetween", () {
      test("Empty string", () {
        expect(
          ElementParser.getBetween(
            "",
            "{",
            "}",
          ).trim(),
          "",
        );
      });
      test("Random string without indicators", () {
        expect(
          ElementParser.getBetween(
            ";as[sad[;f.as'd.[asfsd[.f[aspf",
            "{",
            "}",
          ).trim(),
          "",
        );
      });
      test("Random string with indicators", () {
        expect(
          ElementParser.getBetween(
            "{;as[sad[;f.as'd.[asfsd[.f[aspf}",
            "{",
            "}",
          ).trim(),
          ";as[sad[;f.as'd.[asfsd[.f[aspf",
        );
      });
      test("Random string with indicators inside", () {
        expect(
          ElementParser.getBetween(
            ";as[sad[;f.a{s'd.[asfsd}[.f[aspf}",
            "{",
            "}",
          ).trim(),
          "s'd.[asfsd",
        );
      });
      test("Class", () {
        expect(
          ElementParser.getBetween(
            """
                class Test{
                  //Comments

                  int values;
                  int defaultValues;

                  void emptyFunctions(){

                  };

                  void functions(int value){
                    return value+1;
                  }
                }
              """,
            "{",
            "}",
          ).trim(),
          """//Comments

                  int values;
                  int defaultValues;

                  void emptyFunctions(){

                  };

                  void functions(int value){
                    return value+1;
                  }""",
        );
      });
      test("Empty Function Definitions", () {
        expect(
          ElementParser.getBetween(
            """
              void emptyFunctions(){

              };
              """,
            "{",
            "}",
          ).trim(),
          """""",
        );
      });
      test("Function Definitions", () {
        expect(
          ElementParser.getBetween(
            """
              String functions(String v, int intv){
                return v+intv.toString();
              };
              """,
            "{",
            "}",
          ).trim(),
          """return v+intv.toString();""",
        );
      });
      test("Multiple child", () {
        expect(
          ElementParser.getBetween(
            """
              void testFunction(){
                  {
                    test
                    {
                      inside test
                    }
                    test
                  }
              };
              """,
            "{",
            "}",
          ).trim(),
          """{
                    test
                    {
                      inside test
                    }
                    test
                  }""",
        );
      });
    });
  });
}

void main() {
  test_element_parser();
}
