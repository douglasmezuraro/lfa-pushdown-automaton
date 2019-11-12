unit Impl.List;

interface

uses
  System.SysUtils;

type
  TList = class sealed
  strict private
    FList: TArray<string>;
  public
    constructor Create(const Values: TArray<string>); overload;
    function Contains(const Item: string): Boolean;
    function Count: Integer;
    function IsEmpty: Boolean;
    function ToArray: TArray<string>;
    function ToString: string; override;
    function HasDuplicated(out Item: string): Boolean;
    procedure Add(const Item: string); overload;
    procedure Add(const Items: TArray<string>); overload;
    procedure Clear;
  end;

implementation

constructor TList.Create(const Values: TArray<string>);
begin
  Add(Values);
end;

function TList.HasDuplicated(out Item: string): Boolean;
var
  A, B: string;
  Count: Integer;
begin
  for A in FList do
  begin
    Count := 0;
    for B in FList do
    begin
      if not A.Equals(B) then
        Continue;

      Inc(Count);

      if Count > 1 then
      begin
        Item := A;
        Exit(True);
      end;
    end;
  end;

  Result := False;
end;

procedure TList.Add(const Item: string);
begin
  SetLength(FList, Count + 1);
  FList[High(FList)] := Item;
end;

procedure TList.Add(const Items: TArray<string>);
var
  A: string;
begin
  for A in Items do
    Add(A);
end;

procedure TList.Clear;
begin
  SetLength(FList, 0);
end;

function TList.Contains(const Item: string): Boolean;
var
  LItem: string;
begin
  for LItem in FList do
  begin
    if LItem.Equals(Item) then
      Exit(True);
  end;

  Result := False;
end;

function TList.Count: Integer;
begin
  Result := Length(FList);
end;

function TList.IsEmpty: Boolean;
begin
  Result := Count = 0;
end;

function TList.ToArray: TArray<string>;
begin
  Result := FList;
end;

function TList.ToString: string;
var
  Item: string;
begin
  for Item in FList do
  begin
    if Result.Trim.IsEmpty then
      Result := Item
    else
      Result := Result + ', ' + Item;
  end;

  Result := '[' + Result + ']';
end;

end.

