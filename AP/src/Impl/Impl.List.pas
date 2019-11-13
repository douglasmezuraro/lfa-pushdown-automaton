unit Impl.List;

interface

uses
  System.SysUtils;

type
  TList = class sealed
  strict private
    FList: TArray<string>;
  public
    function Contains(const Item: string): Boolean;
    function Count: Integer;
    function HasDuplicated(out Item: string): Boolean;
    function IsEmpty: Boolean;
    function ToArray: TArray<string>;
    function ToString: string; override;
    procedure Add(const Item: string); overload;
    procedure Add(const Items: TArray<string>); overload;
    procedure Clear;
  end;

implementation

procedure TList.Add(const Item: string);
begin
  SetLength(FList, Count + 1);
  FList[High(FList)] := Item;
end;

procedure TList.Add(const Items: TArray<string>);
var
  Element: string;
begin
  for Element in Items do
    Add(Element);
end;

procedure TList.Clear;
begin
  SetLength(FList, 0);
end;

function TList.Contains(const Item: string): Boolean;
var
  Element: string;
begin
  for Element in FList do
  begin
    if Element.Equals(Item) then
      Exit(True);
  end;

  Result := False;
end;

function TList.Count: Integer;
begin
  Result := Length(FList);
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
  Element: string;
begin
  for Element in FList do
  begin
    if Result.Trim.IsEmpty then
      Result := Element
    else
      Result := Result + ', ' + Element;
  end;

  Result := '[' + Result + ']';
end;

end.

