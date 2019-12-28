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
    procedure TestValuesWhenStackIsEmpty;
    procedure TestValuesWhenStackHasOneElement;
    procedure TestValuesWhenStackHasMoreThanOneElement;
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
  FStack.Push('q0');
  FStack.Push('q1');
  FStack.Push('q2');
  FStack.Push('q3');
  FStack.Push('q4');

  FStack.Clear;

  CheckTrue(FStack.IsEmpty);
end;

procedure TStackTest.TestClearWhenStackHasOneElement;
begin
  FStack.Push('q0');
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
  FStack.Push('q0');
  FStack.Push('q1');
  FStack.Push('q2');
  FStack.Push('q3');
  FStack.Push('q4');

  CheckEquals(5, FStack.Count);
end;

procedure TStackTest.TestCountWhenStackHasOneElement;
begin
  FStack.Push('q0');
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
  FStack.Push('q0');
  CheckFalse(FStack.IsEmpty);
end;

procedure TStackTest.TestPeekWhenStackIsEmpty;
begin
  FStack.Push('q0');
  CheckEquals('q0', FStack.Peek);
end;

procedure TStackTest.TestPeekWhenStackIsNotEmpty;
begin
  FStack.Push('q0');
  FStack.Push('q1');
  CheckEquals('q1', FStack.Peek);
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
  FStack.Push('q0');
  FStack.Push('q1');
  FStack.Push('q2');

  Element := FStack.Pop;

  CheckEquals('q2', Element);
  CheckEquals(2, FStack.Count);
end;

procedure TStackTest.TestPushWhenStackIsEmpty;
begin
  FStack.Push('q0');
  CheckEquals(1, FStack.Count);
end;

procedure TStackTest.TestPushWhenStackIsNotEmpty;
begin
  FStack.Push('q0');
  FStack.Push('q1');
  FStack.Push('q2');

  CheckEquals(3, FStack.Count);
end;

procedure TStackTest.TestValuesWhenStackHasMoreThanOneElement;
begin
  FStack.Push('q0');
  FStack.Push('q1');
  FStack.Push('q2');
  FStack.Push('q3');
  FStack.Push('q4');

  CheckEquals('q0', FStack.Values[0]);
  CheckEquals('q1', FStack.Values[1]);
  CheckEquals('q2', FStack.Values[2]);
  CheckEquals('q3', FStack.Values[3]);
  CheckEquals('q4', FStack.Values[4]);
end;

procedure TStackTest.TestValuesWhenStackHasOneElement;
begin
  FStack.Push('q0');
  CheckEquals('q0', FStack.Values[0]);
end;

procedure TStackTest.TestValuesWhenStackIsEmpty;
begin
  CheckEquals([], FStack.Values);
end;

procedure TStackTest.TestToStringWhenStackHasMoreThanOneElement;
begin
  FStack.Push('q0');
  CheckEquals('[q0]', FStack.ToString);
end;

procedure TStackTest.TestToStringWhenStackHasOneElement;
begin
  FStack.Push('q0');
  CheckEquals('[q0]', FStack.ToString);
end;

procedure TStackTest.TestToStringWhenStackIsEmpty;
begin
  CheckEquals('[]', FStack.ToString);
end;

initialization
  RegisterTest(TStackTest.Suite);

end.

