unit Helper.TestFramework;

interface

uses
  TestFramework, System.StrUtils, System.SysUtils;

type
  TTestFrameworkHelper = class Helper for TAbstractTest
  private
    function EqualsArray(const A, B: TArray<string>): Boolean;
  public
    procedure CheckEquals(const Expected, Actual: TArray<string>; const Msg: string = string.Empty); overload;
    procedure CheckEquals(const Expected, Actual: TObject; const Msg: string = string.Empty); overload;
    procedure CheckEquals(const Method: TProc; const ExpectedClass: ExceptionClass; const Msg: string = string.Empty); overload;
    procedure CheckNotEquals(const Expected, Actual: TArray<string>; const Msg: string = string.Empty); overload;
    procedure CheckNotEquals(const Expected, Actual: TObject; const Msg: string = string.Empty); overload;
  end;

implementation

procedure TTestFrameworkHelper.CheckEquals(const Method: TProc; const ExpectedClass: ExceptionClass; const Msg: string);
begin
  StartExpectingException(ExpectedClass);
  Method;
  StopExpectingException(Msg);
end;

procedure TTestFrameworkHelper.CheckNotEquals(const Expected, Actual: TObject; const Msg: string);
const
  ERROR_MESSAGE = 'The objects matches.';
var
  LMessage: string;
begin
  LMessage := IfThen(Msg.Trim.IsEmpty, ERROR_MESSAGE, Msg.Trim);
  CheckFalse(Expected.Equals(Actual), LMessage);
end;

procedure TTestFrameworkHelper.CheckNotEquals(const Expected, Actual: TArray<string>; const Msg: string);
const
  ERROR_MESSAGE = 'The arrays matches.';
var
  LMessage: string;
begin
  LMessage := IfThen(Msg.Trim.IsEmpty, ERROR_MESSAGE, Msg.Trim);
  CheckFalse(EqualsArray(Expected, Actual), LMessage);
end;

procedure TTestFrameworkHelper.CheckEquals(const Expected, Actual: TArray<string>; const Msg: string);
const
  ERROR_MESSAGE = 'The arrays do not match.';
var
  LMessage: string;
begin
  LMessage := IfThen(Msg.Trim.IsEmpty, ERROR_MESSAGE, Msg.Trim);
  CheckTrue(EqualsArray(Expected, Actual), LMessage);
end;

procedure TTestFrameworkHelper.CheckEquals(const Expected, Actual: TObject; const Msg: string);
const
  ERROR_MESSAGE = 'The objects do not match.';
var
  LMessage: string;
begin
  LMessage := IfThen(Msg.Trim.IsEmpty, ERROR_MESSAGE, Msg.Trim);
  CheckTrue(Expected.Equals(Actual), LMessage);
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

