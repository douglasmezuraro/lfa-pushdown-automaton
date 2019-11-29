unit Helper.TestFramework;

interface

uses
  TestFramework, System.SysUtils;

type
  TTestFrameworkHelper = class Helper for TAbstractTest
  private
    function EqualsArray(const A, B: TArray<string>): Boolean;
  public
    procedure CheckEquals(const Expected, Actual: TArray<string>; const Msg: string = string.Empty); overload;
    procedure CheckEquals(const Method: TProc; const ExpectedClass: ExceptionClass; const Msg: string = string.Empty); overload;
  end;

implementation

procedure TTestFrameworkHelper.CheckEquals(const Method: TProc; const ExpectedClass: ExceptionClass; const Msg: string);
begin
  StartExpectingException(ExpectedClass);
  Method;
  StopExpectingException(Msg);
end;

procedure TTestFrameworkHelper.CheckEquals(const Expected, Actual: TArray<string>; const Msg: string);
begin
  CheckTrue(EqualsArray(Expected, Actual), Msg);
end;

function TTestFrameworkHelper.EqualsArray(const A, B: TArray<string>): Boolean;
var
  Index: Integer;
begin
  if Length(A) <> Length(B) then
    Exit(False);

  for Index := Low(A) to High(A) do
  begin
    if not A[Index].Equals(B[Index]) then
      Exit(False);
  end;

  Result := True;
end;

end.

