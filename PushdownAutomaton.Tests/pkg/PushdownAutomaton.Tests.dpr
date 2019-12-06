program PushdownAutomaton.Tests;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  Impl.Stack in '..\..\PushdownAutomaton\src\Impl\Impl.Stack.pas',
  Test.Stack in '..\src\Test\Test.Stack.pas',
  Helper.TestFramework in '..\src\Helper\Helper.TestFramework.pas',
  Test.List in '..\src\Test\Test.List.pas',
  Impl.List in '..\..\PushdownAutomaton\src\Impl\Impl.List.pas',
  Test.Exercises in '..\src\Test\Test.Exercises.pas',
  Impl.PushdownAutomaton in '..\..\PushdownAutomaton\src\Impl\Impl.PushdownAutomaton.pas',
  Impl.Transition in '..\..\PushdownAutomaton\src\Impl\Impl.Transition.pas',
  Impl.Transitions in '..\..\PushdownAutomaton\src\Impl\Impl.Transitions.pas',
  Impl.Types in '..\..\PushdownAutomaton\src\Impl\Impl.Types.pas',
  Impl.Validator in '..\..\PushdownAutomaton\src\Impl\Impl.Validator.pas',
  Test.Transitions in '..\src\Test\Test.Transitions.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

