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
  Impl.List in '..\..\PushdownAutomaton\src\Impl\Impl.List.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

