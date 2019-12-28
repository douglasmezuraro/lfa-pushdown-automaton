unit Impl.List;

interface

uses
  System.SysUtils;

type
  TList = class sealed
  strict private
    FList: TArray<string>;
  public
    function Add(const Item: string): TList; overload;
    function Add(const Items: TArray<string>): TList; overload;
    function Contains(const Item: string): Boolean;
    function Count: Integer;
    function Duplicated: TList;
    function IsEmpty: Boolean;
    function ToArray: TArray<string>;
    function ToString: string; override;
    procedure Clear;
  end;

implementation

function TList.Add(const Item: string): TList;
begin
  SetLength(FList, Count + 1);
  FList[High(FList)] := Item;

  Result := Self;
end;

function TList.Add(const Items: TArray<string>): TList;
var
  Element: string;
begin
  for Element in Items do
    Add(Element);

  Result := Self;
end;

procedure TList.Clear;
begin
  FList := nil;
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

function TList.Duplicated: TList;
var
  A, B: string;
  Count: Integer;
  List: TList;
begin
  List := TList.Create;
  for A in FList do
  begin
    Count := 0;
    for B in FList do
    begin
      if not A.Equals(B) then
        Continue;

      Inc(Count);

      if (Count > 1) and (not List.Contains(A)) then
      begin
        List.Add(A);
      end;
    end;
  end;
  Result := List;
end;

function TList.IsEmpty: Boolean;
begin
  Result := FList = nil;
end;

function TList.ToArray: TArray<string>;
begin
  Result := FList;
end;

function TList.ToString: string;
const
  Separator: string = ', ';
var
  Element: string;
  Builder: TStringBuilder;
begin
  if IsEmpty then
    Exit('[]');

  Builder := TStringBuilder.Create('[');
  try
    for Element in FList do
    begin
      Builder.Append(Element).Append(Separator);
    end;

    Result := Builder.Remove(Builder.Length - Separator.Length, Separator.Length).Append(']').ToString;
  finally
    Builder.Free;
  end;
end;

end.

