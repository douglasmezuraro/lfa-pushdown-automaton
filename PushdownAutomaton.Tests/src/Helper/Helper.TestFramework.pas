unit Helper.TestFramework;

interface

uses
  TestFramework, System.StrUtils, System.SysUtils;

type
  TTestFrameworkHelper = class Helper for TAbstractTest
  private
    function EqualsArray(const A, B: TArray<string>): Boolean;
  public
    procedure CheckEquals(const Method: TProc; const ExpectedClass: ExceptionClass); overload;
    procedure CheckEquals(const Expected, Actual: TArray<string>); overload;
    procedure CheckEquals(const Expected, Actual: TObject); overload;
    procedure CheckNotEquals(const Expected, Actual: TArray<string>); overload;
    procedure CheckNotEquals(const Expected, Actual: TObject); overload;
  end;

implementation

procedure TTestFrameworkHelper.CheckEquals(const Method: TProc; const ExpectedClass: ExceptionClass);
begin
  StartExpectingException(ExpectedClass);
  Method;
  StopExpectingException('Mismatch expcetion classes');
end;


procedure TTestFrameworkHelper.CheckNotEquals(const Expected, Actual: TObject);
begin
  CheckFalse(Expected.Equals(Actual), 'The objects matches.');
end;

procedure TTestFrameworkHelper.CheckNotEquals(const Expected, Actual: TArray<string>);
begin
  CheckFalse(EqualsArray(Expected, Actual), 'The arrays matches.');
end;

procedure TTestFrameworkHelper.CheckEquals(const Expected, Actual: TArray<string>);
begin
  CheckTrue(EqualsArray(Expected, Actual), 'The arrays do not match.');
end;

procedure TTestFrameworkHelper.CheckEquals(const Expected, Actual: TObject);
begin
  CheckTrue(Expected.Equals(Actual), 'The objects do not match.');
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

