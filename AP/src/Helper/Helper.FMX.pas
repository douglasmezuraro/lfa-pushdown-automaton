unit Helper.FMX;

interface

uses
  System.SysUtils, FMX.Grid, FMX.ListBox;

type
  TStringGridHelper = class Helper for TStringGrid
  private const
    FirstColumn = 0;
    FirstRow = 0;
  private
    function Eof: Boolean;
    function GetValue(const Column: TColumn): string;
  public
    function IsEmpty: Boolean;
    procedure Clear;
    procedure Delete;
    procedure ForEach(const Method: TProc);
    procedure Insert;
    property Value[Const Column: TColumn]: string read GetValue;
  end;

  TListBoxItemHelper = class Helper for TListBoxItem
  public
    procedure Check(const Checked: Boolean);
    procedure Restore;
  end;

implementation

{ TStringGridHelper }

procedure TStringGridHelper.Delete;
var
  LColumn, LRow: Integer;
begin
  if IsEmpty then
    Exit;

  if Selected <> RowCount then
  begin
    for LRow := Selected to Pred(RowCount) do
    begin
      for LColumn := FirstColumn to Pred(ColumnCount) do
      begin
        Cells[LColumn, LRow] := Cells[LColumn, Succ(LRow)];
      end;
    end;
  end;

  RowCount := Pred(RowCount);
end;

function TStringGridHelper.Eof: Boolean;
begin
  Result := Row = RowCount;
end;

procedure TStringGridHelper.ForEach(const Method: TProc);
begin
  Row := FirstRow;
  while not Eof do
  begin
    Method;
    Row := Succ(Row);
  end;
end;

function TStringGridHelper.GetValue(const Column: TColumn): string;
begin
  Result := Cells[Column.Index, Row];
end;

procedure TStringGridHelper.Clear;
begin
  RowCount := 0;
end;

procedure TStringGridHelper.Insert;
begin
  RowCount := Succ(RowCount);
  SelectCell(FirstColumn, Succ(Selected));
  EditorMode := True;
end;

function TStringGridHelper.IsEmpty: Boolean;
begin
  Result := RowCount = 0;
end;

{ TListBoxItemHelper }

procedure TListBoxItemHelper.Check(const Checked: Boolean);
begin
  IsChecked := Checked;
  Tag := Checked.ToInteger;
end;

procedure TListBoxItemHelper.Restore;
begin
  IsChecked := Tag.ToBoolean;
end;

end.

