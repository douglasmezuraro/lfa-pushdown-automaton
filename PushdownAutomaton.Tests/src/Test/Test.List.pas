unit Test.List;

interface

uses
  Impl.List, System.SysUtils, TestFramework;

type
  TListTest = class(TTestCase)
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
    procedure TestToArrayWhenListIsEmpty;
    procedure TestToArrayWhenListHasOneElement;
    procedure TestToArrayWhenListHasMoreThanOneElement;
    procedure TestHasDuplicatedWhenListDoesntHaveDuplicatedElement;
    procedure TestHasDuplicatedWhenListHaveDuplicatedElement;
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
  FList.Add('Q0');
  CheckEquals(1, FList.Count);
end;

procedure TListTest.TestAddMoreThanOneElement;
begin
  FList.Add(['Q0', 'Q1', 'Q2']);
  CheckEquals(3, FList.Count);
end;

procedure TListTest.TestIsEmptyWhenListIsEmpty;
begin
  CheckTrue(FList.IsEmpty);
end;

procedure TListTest.TestIsEmptyWhenListIsNotEmpty;
begin
  FList.Add('Q0');
  CheckFalse(FList.IsEmpty);
end;

procedure TListTest.TestClearWhenListIsEmpty;
begin
  FList.Clear;
  CheckTrue(FList.IsEmpty);
end;

procedure TListTest.TestClearWhenListHasOneElement;
begin
  FList.Add('Q0');
  FList.Clear;
  CheckTrue(FList.IsEmpty);
end;

procedure TListTest.TestClearWhenListHasMoreThanOneElement;
begin
  FList.Add(['Q0', 'Q1', 'Q2']);
  FList.Clear;
  CheckTrue(FList.IsEmpty);
end;

procedure TListTest.TestHasDuplicatedWhenListDoesntHaveDuplicatedElement;
var
  Element: string;
begin
  FList.Add(['Q0', 'Q1', 'Q2', 'Q3', 'Q1', 'Q4']);
  CheckTrue(Flist.HasDuplicated(Element));
  CheckEquals('Q1', Element);
end;

procedure TListTest.TestHasDuplicatedWhenListHaveDuplicatedElement;
var
  Element: string;
begin
  FList.Add(['Q0', 'Q1', 'Q2', 'Q3', 'Q4']);
  CheckFalse(Flist.HasDuplicated(Element));
  CheckEquals(string.Empty, Element);
end;

procedure TListTest.TestCountWhenListIsEmpty;
begin
  CheckEquals(0, FList.Count);
end;

procedure TListTest.TestCountWhenListHasOneElement;
begin
  FList.Add('Q0');
  CheckEquals(1, FList.Count);
end;

procedure TListTest.TestCountWhenListHasMoreThanOneElement;
begin
  FList.Add(['Q0', 'Q1', 'Q2', 'Q3']);
  CheckEquals(4, FList.Count);
end;

procedure TListTest.TestContainsWhenListContainsTheElement;
begin
  FList.Add(['Q0', 'Q1', 'Q2', 'Q3']);
  CheckTrue(FList.Contains('Q2'));
end;

procedure TListTest.TestContainsWhenListNotContainsTheElement;
begin
  FList.Add(['Q0', 'Q1', 'Q2']);
  CheckFalse(FList.Contains('Q3'));
end;

procedure TListTest.TestToStringWhenListIsEmpty;
begin
  CheckEquals('[]', FList.ToString);
end;

procedure TListTest.TestToStringWhenListHasOneElement;
begin
  FList.Add('Q0');
  CheckEquals('[Q0]', FList.ToString);
end;

procedure TListTest.TestToStringWhenListHasMoreThanOneElement;
begin
  FList.Add(['Q0', 'Q1', 'Q2', 'Q3']);
  CheckEquals('[Q0, Q1, Q2, Q3]', FList.ToString);
end;

procedure TListTest.TestToArrayWhenListIsEmpty;
begin
  CheckEquals(0, Length(FList.ToArray));
end;

procedure TListTest.TestToArrayWhenListHasOneElement;
begin
  FList.Add('Q0');

  CheckEquals('Q0', FList.ToArray[0]);
end;

procedure TListTest.TestToArrayWhenListHasMoreThanOneElement;
begin
  FList.Add(['Q0', 'Q1', 'Q2', 'Q3', 'Q4']);

  CheckEquals('Q0', FList.ToArray[0]);
  CheckEquals('Q1', FList.ToArray[1]);
  CheckEquals('Q2', FList.ToArray[2]);
  CheckEquals('Q3', FList.ToArray[3]);
  CheckEquals('Q4', FList.ToArray[4]);
end;

initialization
  RegisterTest(TListTest.Suite);

end.

