unit Test.List;

interface

uses
  Helper.TestFramework, Impl.List, System.SysUtils, TestFramework;

type
  TListTest = class sealed(TTestCase)
  strict private
    FList: TList;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAddOneElement;
    procedure TestAddMoreThanOneElement;
    procedure TestIsEmptyWhenListIsEmpty;
    procedure TestIsEmptyWhenListIsNotEmpty;
    procedure TestClearWhenListIsEmpty;
    procedure TestClearWhenListHasOneElement;
    procedure TestClearWhenListHasMoreThanOneElement;
    procedure TestCountWhenListIsEmpty;
    procedure TestCountWhenListHasOneElement;
    procedure TestCountWhenListHasMoreThanOneElement;
    procedure TestContainsWhenListContainsTheElement;
    procedure TestContainsWhenListNotContainsTheElement;
    procedure TestToStringWhenListIsEmpty;
    procedure TestToStringWhenListHasOneElement;
    procedure TestToStringWhenListHasMoreThanOneElement;
    procedure TestValuesWhenListIsEmpty;
    procedure TestValuesWhenListHasOneElement;
    procedure TestToArrayWhenListHasMoreThanOneElement;
    procedure TestHasDuplicatedWhenListDoesntHaveDuplicatedElement;
    procedure TestHasDuplicatedWhenListHaveOneDuplicatedElement;
  end;

implementation

procedure TListTest.SetUp;
begin
  FList := TList.Create;
end;

procedure TListTest.TearDown;
begin
  FList.Free;
end;

procedure TListTest.TestAddOneElement;
begin
  FList.Add('q0');
  CheckEquals(1, FList.Count);
end;

procedure TListTest.TestAddMoreThanOneElement;
begin
  FList.Add(['q0', 'q1', 'q2']);
  CheckEquals(3, FList.Count);
end;

procedure TListTest.TestIsEmptyWhenListIsEmpty;
begin
  CheckTrue(FList.IsEmpty);
end;

procedure TListTest.TestIsEmptyWhenListIsNotEmpty;
begin
  FList.Add('q0');
  CheckFalse(FList.IsEmpty);
end;

procedure TListTest.TestClearWhenListIsEmpty;
begin
  FList.Clear;
  CheckTrue(FList.IsEmpty);
end;

procedure TListTest.TestClearWhenListHasOneElement;
begin
  FList.Add('q0');
  FList.Clear;
  CheckTrue(FList.IsEmpty);
end;

procedure TListTest.TestClearWhenListHasMoreThanOneElement;
begin
  FList.Add(['q0', 'q1', 'q2']);
  FList.Clear;
  CheckTrue(FList.IsEmpty);
end;

procedure TListTest.TestHasDuplicatedWhenListDoesntHaveDuplicatedElement;
var
  Duplicated: TList;
begin
  FList.Add(['q0', 'q1', 'q2', 'q3', 'q4']);

  Duplicated := FList.Duplicated;
  try
    CheckTrue(Duplicated.IsEmpty);
  finally
    Duplicated.Free;
  end;
end;

procedure TListTest.TestHasDuplicatedWhenListHaveOneDuplicatedElement;
var
  Duplicated: TList;
begin
  FList.Add(['q0', 'q1', 'q2', 'q3', 'q1', 'q4']);

  Duplicated := FList.Duplicated;
  try
    CheckEquals(['q1'], Duplicated.Values);
  finally
    Duplicated.Free;
  end;
end;

procedure TListTest.TestCountWhenListIsEmpty;
begin
  CheckEquals(0, FList.Count);
end;

procedure TListTest.TestCountWhenListHasOneElement;
begin
  FList.Add('q0');
  CheckEquals(1, FList.Count);
end;

procedure TListTest.TestCountWhenListHasMoreThanOneElement;
begin
  FList.Add(['q0', 'q1', 'q2', 'q3']);
  CheckEquals(4, FList.Count);
end;

procedure TListTest.TestContainsWhenListContainsTheElement;
begin
  FList.Add(['q0', 'q1', 'q2', 'q3']);
  CheckTrue(FList.Contains('q2'));
end;

procedure TListTest.TestContainsWhenListNotContainsTheElement;
begin
  FList.Add(['q0', 'q1', 'q2']);
  CheckFalse(FList.Contains('q3'));
end;

procedure TListTest.TestToStringWhenListIsEmpty;
begin
  CheckEquals('[]', FList.ToString);
end;

procedure TListTest.TestToStringWhenListHasOneElement;
begin
  FList.Add('q0');
  CheckEquals('[q0]', FList.ToString);
end;

procedure TListTest.TestToStringWhenListHasMoreThanOneElement;
begin
  FList.Add(['q0', 'q1', 'q2', 'q3']);
  CheckEquals('[q0, q1, q2, q3]', FList.ToString);
end;

procedure TListTest.TestValuesWhenListIsEmpty;
begin
  CheckEquals([], FList.Values);
end;

procedure TListTest.TestValuesWhenListHasOneElement;
begin
  FList.Add('q0');
  CheckEquals(['q0'], FList.Values);
end;

procedure TListTest.TestToArrayWhenListHasMoreThanOneElement;
begin
  FList.Add(['q0', 'q1', 'q2', 'q3', 'q4']);
  CheckEquals(['q0', 'q1', 'q2', 'q3', 'q4'], FList.Values);
end;

initialization
  RegisterTest(TListTest.Suite);

end.

