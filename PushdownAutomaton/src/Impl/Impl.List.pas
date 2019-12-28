unit Impl.List;

interface

uses
  System.SysUtils;

type
  TList = class sealed
  strict private
    FValues: TArray<string>;
  public
    function Add(const Item: string): TList; overload;
    function Add(const Items: TArray<string>): TList; overload;
    function Contains(const Item: string): Boolean;
    function Count: Integer;
    function Duplicated: TList;
    function IsEmpty: Boolean;
    function ToString: string; override;
    function Clear: TList;
    property Values: TArray<string> read FValues write FValues;
  end;

implementation

function TList.Add(const Item: string): TList;
begin
  SetLength(FValues, Count + 1);
  FValues[High(FValues)] := Item;

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

function TList.Clear: TList;
begin
  FValues := nil;
  Result := Self;
end;

function TList.Contains(const Item: string): Boolean;
var
  Element: string;
begin
  for Element in FValues do
  begin
    if Element.Equals(Item) then
      Exit(True);
  end;

  Result := False;
end;

function TList.Count: Integer;
begin
  Result := Length(FValues);
end;

function TList.Duplicated: TList;
var
  A, B: string;
  Count: Integer;
  List: TList;
begin
  List := TList.Create;
  for A in FValues do
  begin
    Count := 0;
    for B in FValues do
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
  Result := FValues = nil;
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
    for Element in FValues do
    begin
      Builder.Append(Element).Append(Separator);
    end;

    Result := Builder.Remove(Builder.Length - Separator.Length, Separator.Length).Append(']').ToString;
  finally
    Builder.Free;
  end;
end;

end.

