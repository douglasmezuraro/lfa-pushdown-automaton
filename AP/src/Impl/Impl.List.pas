unit Impl.List;

interface

uses
  System.SysUtils, System.Generics.collections;

type
  TList = class sealed
  private
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

{ TList }

constructor TList.Create(const Values: TArray<string>);
begin
  Add(Values);
end;

function TList.HasDuplicated(out Item: string): Boolean;
var
  Dic: TDictionary<string, Integer>;
  Pair: TPair<string, Integer>;
  Key: string;
begin
  Dic := TDictionary<string, Integer>.Create;
  try
    for Key in ToArray do
    begin
      if Dic.ContainsKey(Key) then
        Dic.AddOrSetValue(Key, Dic.Items[Key] + 1)
      else
        Dic.Add(Key, 1);
    end;

    for Pair in Dic.ToArray do
    begin
      if Pair.Value > 1 then
      begin
        Item := Pair.Key;
        Exit(True);
      end;
    end;

    Result := False;
  finally
    Dic.Free;
  end;
end;

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

