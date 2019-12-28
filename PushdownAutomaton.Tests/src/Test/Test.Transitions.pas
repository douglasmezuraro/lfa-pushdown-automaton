unit Test.Transitions;

interface

uses
  TestFramework, Helper.TestFramework, Impl.Transition, Impl.Transitions;

type
  TTransitionsTest = class sealed(TTestCase)
  strict private
    FTransitions: TTransitions;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAdd;
    procedure TestClearWhenHasMoreThanOneTransition;
    procedure TestClearWhenHasOneTransition;
    procedure TestClearWhenIsEmpty;
    procedure TestCountWhenHasMoreThenOneTransition;
    procedure TestCountWhenHasOneTransition;
    procedure TestCountWhenIsEmpty;
    procedure TestIsEmptyWhenHasMoreThanOneTransition;
    procedure TestIsEmptyWhenHasOneTransition;
    procedure TestIsEmptyWhenIsEmpty;
    procedure TestValuesWhenHasMoreThanOneTransition;
    procedure TestValuesWhenHasOneTransition;
    procedure TestValuesWhenIsEmpty;
    procedure TestTransitionWhenTransitionExists;
    procedure TestTransitionWhenTransitionNotExists;
  end;

implementation

procedure TTransitionsTest.SetUp;
begin
  FTransitions := TTransitions.Create;
end;

procedure TTransitionsTest.TearDown;
begin
  FTransitions.Free;
end;

procedure TTransitionsTest.TestAdd;
begin
  FTransitions.Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'XXX'));
  CheckFalse(FTransitions.IsEmpty)
end;

procedure TTransitionsTest.TestClearWhenHasMoreThanOneTransition;
begin
  FTransitions.Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'XXX'))
              .Add(TTransition.Create('q1', 'q1', 'a', 'X', 'XXX'))
              .Add(TTransition.Create('q1', 'q2', 'b', 'X', 'ʎ'))
              .Add(TTransition.Create('q2', 'q2', 'b', 'X', 'ʎ'));

  FTransitions.Clear;

  CheckTrue(FTransitions.IsEmpty);
end;

procedure TTransitionsTest.TestClearWhenHasOneTransition;
begin
  FTransitions.Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'XXX'));
  FTransitions.Clear;

  CheckTrue(FTransitions.IsEmpty);
end;

procedure TTransitionsTest.TestClearWhenIsEmpty;
begin
  FTransitions.Clear;
  CheckTrue(FTransitions.IsEmpty);
end;

procedure TTransitionsTest.TestCountWhenHasMoreThenOneTransition;
begin
  FTransitions.Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'XXX'))
              .Add(TTransition.Create('q1', 'q1', 'a', 'X', 'XXX'))
              .Add(TTransition.Create('q1', 'q2', 'b', 'X', 'ʎ'))
              .Add(TTransition.Create('q2', 'q2', 'b', 'X', 'ʎ'));

  CheckEquals(4, FTransitions.Count);
end;

procedure TTransitionsTest.TestCountWhenHasOneTransition;
begin
  FTransitions.Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'XXX'));
  CheckEquals(1, FTransitions.Count);
end;

procedure TTransitionsTest.TestCountWhenIsEmpty;
begin
  CheckEquals(0, FTransitions.Count);
end;

procedure TTransitionsTest.TestIsEmptyWhenHasMoreThanOneTransition;
begin
  FTransitions.Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'XXX'))
              .Add(TTransition.Create('q1', 'q1', 'a', 'X', 'XXX'))
              .Add(TTransition.Create('q1', 'q2', 'b', 'X', 'ʎ'))
              .Add(TTransition.Create('q2', 'q2', 'b', 'X', 'ʎ'));

  CheckFalse(FTransitions.IsEmpty);
end;

procedure TTransitionsTest.TestIsEmptyWhenHasOneTransition;
begin
  FTransitions.Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'XXX'));
  CheckFalse(FTransitions.IsEmpty);
end;

procedure TTransitionsTest.TestIsEmptyWhenIsEmpty;
begin
  CheckTrue(FTransitions.IsEmpty);
end;

procedure TTransitionsTest.TestValuesWhenHasMoreThanOneTransition;
var
  A, B, C, D: TTransition;
begin
  A := TTransition.Create('q0', 'q1', 'a', 'Z', 'XXX');
  B := TTransition.Create('q1', 'q1', 'a', 'X', 'XXX');
  C := TTransition.Create('q1', 'q2', 'b', 'X', 'ʎ');
  D := TTransition.Create('q2', 'q2', 'b', 'X', 'ʎ');

  FTransitions.Add(A);
  FTransitions.Add(B);
  FTransitions.Add(C);
  FTransitions.Add(D);

  CheckEquals(A, FTransitions.Values[0]);
  CheckEquals(B, FTransitions.Values[1]);
  CheckEquals(C, FTransitions.Values[2]);
  CheckEquals(D, FTransitions.Values[3]);
end;

procedure TTransitionsTest.TestValuesWhenHasOneTransition;
var
  Transition: TTransition;
begin
  Transition := TTransition.Create('q0', 'q1', 'a', 'Z', 'XXX');
  FTransitions.Add(Transition);

  CheckEquals(Transition, FTransitions.Values[0]);
end;

procedure TTransitionsTest.TestValuesWhenIsEmpty;
begin
  CheckEquals(0, Length(FTransitions.Values));
end;

procedure TTransitionsTest.TestTransitionWhenTransitionExists;
var
  A, B: TTransition;
begin
  A := TTransition.Create('q0', 'q1', 'a', 'Z', 'XXX');
  FTransitions.Add(A);
  B := FTransitions.Transition('q0', 'a', 'Z');

  CheckEquals(A, B);
end;

procedure TTransitionsTest.TestTransitionWhenTransitionNotExists;
var
  A, B: TTransition;
begin
  A := TTransition.Create('q0', 'q1', 'a', 'Z', 'XXX');
  FTransitions.Add(A);
  B := FTransitions.Transition('q0', 'a', 'Y');

  CheckNotEquals(A, B);
end;

initialization
  RegisterTest(TTransitionsTest.Suite);

end.
