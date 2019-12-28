unit Impl.Stack;

interface

uses
  System.SysUtils, Impl.Types;

type
  TStack = class sealed
  strict private
    FValues: TArray<string>;
  public
    function Clear: TStack;
    function Count: Integer;
    function IsEmpty: Boolean;
    function Peek: string;
    function Pop: string;
    function Push(const Value: string): TStack;
    function ToString: string; override;
    property Values: TArray<string> read FValues write FValues;
  end;

implementation

function TStack.Clear: TStack;
begin
  FValues := nil;
  Result := Self;
end;

function TStack.Count: Integer;
begin
  Result := Length(FValues);
end;

function TStack.IsEmpty: Boolean;
begin
  Result := FValues = nil;
end;

function TStack.Peek: string;
begin
  if IsEmpty then
    Exit(Lambda);

  Result := FValues[High(FValues)];
end;

function TStack.Pop: string;
begin
  if IsEmpty then
    Exit(string.Empty);

  Result := FValues[High(FValues)];
  SetLength(FValues, Count - 1);
end;

function TStack.Push(const Value: string): TStack;
begin
  SetLength(FValues, Count + 1);
  FValues[High(FValues)] := Value;

  Result := Self;
end;

function TStack.ToString: string;
var
  Element: string;
begin
  for Element in FValues do
  begin
    if Result.Trim.IsEmpty then
      Result := Element
    else
      Result := Result + ', ' + Element;
  end;

  Result := '[' + Result + ']';
end;

end.

