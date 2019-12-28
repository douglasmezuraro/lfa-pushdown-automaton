unit Impl.Stack;

interface

uses
  System.SysUtils, Impl.Types;

type
  TStack = class sealed
  strict private
    FStack: TArray<string>;
  public
    function Clear: TStack;
    function Count: Integer;
    function IsEmpty: Boolean;
    function Peek: string;
    function Pop: string;
    function Push(const Value: string): TStack;
    function ToArray: TArray<string>;
    function ToString: string; override;
  end;

implementation

function TStack.Clear: TStack;
begin
  FStack := nil;
  Result := Self;
end;

function TStack.Count: Integer;
begin
  Result := Length(FStack);
end;

function TStack.IsEmpty: Boolean;
begin
  Result := FStack = nil;
end;

function TStack.Peek: string;
begin
  if IsEmpty then
    Exit(Lambda);

  Result := FStack[High(FStack)];
end;

function TStack.Pop: string;
begin
  if IsEmpty then
    Exit(string.Empty);

  Result := FStack[High(FStack)];
  SetLength(FStack, Count - 1);
end;

function TStack.Push(const Value: string): TStack;
begin
  SetLength(FStack, Count + 1);
  FStack[High(FStack)] := Value;

  Result := Self;
end;

function TStack.ToArray: TArray<string>;
begin
  Result := FStack;
end;

function TStack.ToString: string;
var
  Element: string;
begin
  for Element in FStack do
  begin
    if Result.Trim.IsEmpty then
      Result := Element
    else
      Result := Result + ', ' + Element;
  end;

  Result := '[' + Result + ']';
end;

end.

