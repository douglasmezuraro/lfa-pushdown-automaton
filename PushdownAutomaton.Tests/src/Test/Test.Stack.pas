unit Test.Stack;

interface

uses
  Helper.TestFramework, Impl.Stack, TestFramework;

type
  TStackTest = class sealed(TTestCase)
  strict private
    FStack: TStack;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestPushWhenStackIsEmpty;
    procedure TestPushWhenStackIsNotEmpty;
    procedure TestPeekWhenStackIsEmpty;
    procedure TestPeekWhenStackIsNotEmpty;
    procedure TestPopWhenStackIsEmpty;
    procedure TestPopWhenStackIsNotEmpty;
    procedure TestIsEmptyWhenStackIsEmpty;
    procedure TestIsEmptyWhenStackIsNotEmpty;
    procedure TestClearWhenStackIsEmpty;
    procedure TestClearWhenStackHasOneElement;
    procedure TestClearWhenStackHasMoreThanOneElement;
    procedure TestCountWhenStackIsEmpty;
    procedure TestCountWhenStackHasOneElement;
    procedure TestCountWhenStackHasMoreThanOneElement;
    procedure TestToStringWhenStackIsEmpty;
    procedure TestToStringWhenStackHasOneElement;
    procedure TestToStringWhenStackHasMoreThanOneElement;
    procedure TestToArrayWhenStackIsEmpty;
    procedure TestToArrayWhenStackHasOneElement;
    procedure TestToArrayWhenStackHasMoreThanOneElement;
  end;

implementation

procedure TStackTest.SetUp;
begin
  FStack := TStack.Create;
end;

procedure TStackTest.TearDown;
begin
  FStack.Free;
end;

procedure TStackTest.TestClearWhenStackHasMoreThanOneElement;
begin
  FStack.Push('Q0');
  FStack.Push('Q1');
  FStack.Push('Q2');
  FStack.Push('Q3');
  FStack.Push('Q4');

  FStack.Clear;

  CheckTrue(FStack.IsEmpty);
end;

procedure TStackTest.TestClearWhenStackHasOneElement;
begin
  FStack.Push('Q0');
  FStack.Clear;

  CheckTrue(FStack.IsEmpty);
end;

procedure TStackTest.TestClearWhenStackIsEmpty;
begin
  FStack.Clear;
  CheckTrue(FStack.IsEmpty);
end;

procedure TStackTest.TestCountWhenStackHasMoreThanOneElement;
begin
  FStack.Push('Q0');
  FStack.Push('Q1');
  FStack.Push('Q2');
  FStack.Push('Q3');
  FStack.Push('Q4');

  CheckEquals(5, FStack.Count);
end;

procedure TStackTest.TestCountWhenStackHasOneElement;
begin
  FStack.Push('Q0');
  CheckEquals(1, FStack.Count);
end;

procedure TStackTest.TestCountWhenStackIsEmpty;
begin
  CheckEquals(0, FStack.Count);
end;

procedure TStackTest.TestIsEmptyWhenStackIsEmpty;
begin
  CheckTrue(FStack.IsEmpty);
end;

procedure TStackTest.TestIsEmptyWhenStackIsNotEmpty;
begin
  FStack.Push('Q0');
  CheckFalse(FStack.IsEmpty);
end;

procedure TStackTest.TestPeekWhenStackIsEmpty;
begin
  FStack.Push('Q0');
  CheckEquals('Q0', FStack.Peek);
end;

procedure TStackTest.TestPeekWhenStackIsNotEmpty;
begin
  FStack.Push('Q0');
  FStack.Push('Q1');
  CheckEquals('Q1', FStack.Peek);
end;

procedure TStackTest.TestPopWhenStackIsEmpty;
var
  Element: string;
begin
  Element := FStack.Pop;
  CheckEquals('', Element);
  CheckEquals(0, FStack.Count);
end;

procedure TStackTest.TestPopWhenStackIsNotEmpty;
var
  Element: string;
begin
  FStack.Push('Q0');
  FStack.Push('Q1');
  FStack.Push('Q2');

  Element := FStack.Pop;

  CheckEquals('Q2', Element);
  CheckEquals(2, FStack.Count);
end;

procedure TStackTest.TestPushWhenStackIsEmpty;
begin
  FStack.Push('Q0');
  CheckEquals(1, FStack.Count);
end;

procedure TStackTest.TestPushWhenStackIsNotEmpty;
begin
  FStack.Push('Q0');
  FStack.Push('Q1');
  FStack.Push('Q2');

  CheckEquals(3, FStack.Count);
end;

procedure TStackTest.TestToArrayWhenStackHasMoreThanOneElement;
begin
  FStack.Push('Q0');
  FStack.Push('Q1');
  FStack.Push('Q2');
  FStack.Push('Q3');
  FStack.Push('Q4');

  CheckEquals('Q0', FStack.ToArray[0]);
  CheckEquals('Q1', FStack.ToArray[1]);
  CheckEquals('Q2', FStack.ToArray[2]);
  CheckEquals('Q3', FStack.ToArray[3]);
  CheckEquals('Q4', FStack.ToArray[4]);
end;

procedure TStackTest.TestToArrayWhenStackHasOneElement;
begin
  FStack.Push('Q0');
  CheckEquals('Q0', FStack.ToArray[0]);
end;

procedure TStackTest.TestToArrayWhenStackIsEmpty;
begin
  CheckEquals([], FStack.ToArray);
end;

procedure TStackTest.TestToStringWhenStackHasMoreThanOneElement;
begin
  FStack.Push('Q0');
  CheckEquals('[Q0]', FStack.ToString);
end;

procedure TStackTest.TestToStringWhenStackHasOneElement;
begin
  FStack.Push('Q0');
  CheckEquals('[Q0]', FStack.ToString);
end;

procedure TStackTest.TestToStringWhenStackIsEmpty;
begin
  CheckEquals('[]', FStack.ToString);
end;

initialization
  RegisterTest(TStackTest.Suite);

end.
