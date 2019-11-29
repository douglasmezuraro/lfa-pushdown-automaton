unit Impl.Stack;

interface

uses
  System.SysUtils;

type
  TStack = class sealed
  strict private
    FStack: TArray<string>;
  public
    function Count: Integer;
    function IsEmpty: Boolean;
    function Peek: string;
    function Pop: string;
    function ToArray: TArray<string>;
    function ToString: string; override;
    procedure Clear;
    procedure Push(const Value: string);
  end;

implementation

procedure TStack.Clear;
begin
  SetLength(FStack, 0);
end;

function TStack.Count: Integer;
begin
  Result := Length(FStack);
end;

function TStack.IsEmpty: Boolean;
begin
  Result := Count = 0;
end;

function TStack.Peek: string;
begin
  Result := string.Empty;
  if not IsEmpty then
    Result := FStack[High(FStack)];
end;

function TStack.Pop: string;
begin
  if IsEmpty then
    Exit(string.Empty);

  Result := FStack[High(FStack)];
  SetLength(FStack, Count - 1);
end;

procedure TStack.Push(const Value: string);
begin
  SetLength(FStack, Count + 1);
  FStack[High(FStack)] := Value;
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

