unit Impl.Stack;

interface

uses
  System.SysUtils;

type
  TStack = class sealed
  private
    FStack: TArray<string>;
    function GetCount: Integer;
    function GetIsEmpty: Boolean;
  public
    procedure Clear;
    procedure Push(const Value: string);
    function Pop: string;
    function ToArray: TArray<string>;
    property Count: Integer read GetCount;
    property IsEmpty: Boolean read GetIsEmpty;
  end;

implementation

{ TStack }

procedure TStack.Clear;
begin
  SetLength(FStack, 0);
end;

function TStack.GetCount: Integer;
begin
  Result := Length(FStack);
end;

function TStack.GetIsEmpty: Boolean;
begin
  Result := Count = 0;
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

end.
