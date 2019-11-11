unit Impl.Transitions;

interface

uses
  Impl.Types, System.RegularExpressions, System.SysUtils;

type
  TSplitter = record
  private
    FValue: string;
    function IndexOf(const Character: Char; const Occur: Integer = 1): Integer;
    function Slice(const Start, Finish: Integer): string;
  public
    constructor Create(const Value: string);
    function Source: TState;
    function Target: TState;
    function Symbol: TSymbol;
    function Push: TSymbol;
    function Pop: TSymbol;
  end;

  TTransition = record
  public
    Source: TState;
    Target: TState;
    Symbol: TSymbol;
    Push: TSymbol;
    Pop: TSymbol;
    constructor Create(const Splitter: TSplitter);
  end;

  TTransitions = class sealed
  private
    FTransitions: TArray<TTransition>;
    function FormatIsValid(const Transition: string): Boolean;
  public
    procedure Add(const Transition: string); overload;
    procedure Add(const Transition: TTransition); overload;
    procedure Clear;
  end;

implementation

{ TTransitions }

procedure TTransitions.Add(const Transition: TTransition);
begin
  SetLength(FTransitions, Length(FTransitions) + 1);
  FTransitions[High(FTransitions)] := Transition;
end;

procedure TTransitions.Add(const Transition: string);
begin
  if not FormatIsValid(Transition) then
    raise EInvalidFormat.CreateFmt('"%" is not a valid transition.', [Transition]);

  Add(TTransition.Create(TSplitter.Create(Transition)));
end;

procedure TTransitions.Clear;
begin
  SetLength(FTransitions, 0);
end;

function TTransitions.FormatIsValid(const Transition: string): Boolean;
const
  Pattern = '\(\w+\,\w+\,(\w+|\λ)\)\=\(\w+\,(\w+|\λ)\)';
begin
  Result := TRegEx.Create(Pattern).IsMatch(Transition);
end;

{ TSplitter }

constructor TSplitter.Create(const Value: string);
begin
  FValue := Value;
end;

function TSplitter.IndexOf(const Character: Char; const Occur: Integer): Integer;
var
  LValue: string;
  LOccur: Integer;
  Index: Integer;
begin
  Index := -1;
  LValue := FValue;
  LOccur := 0;

  while LOccur <> Occur do
  begin
    Index := LValue.IndexOf(Character);
    if Index <> -1 then
      Inc(LOccur);
  end;

  Result := Index;
end;

function TSplitter.Slice(const Start, Finish: Integer): string;
var
  Index: Integer;
begin
  Result := string.Empty;
  for Index := 0 to Length(FValue) - 1 do
  begin
    if (Index >= Start) and (Index <= Finish) then
      Result := FValue.Chars[Index];
  end;
end;

function TSplitter.Pop: TSymbol;
begin
  Result := Slice(IndexOf(',', 2) + 1, IndexOf(')') - 1);
end;

function TSplitter.Push: TSymbol;
begin
  Result := Slice(IndexOf(',', 3) + 1, IndexOf(')', 2) -1);
end;

function TSplitter.Source: TState;
begin
  Result := Slice(IndexOf('(') + 1, IndexOf(',') - 1);
end;

function TSplitter.Symbol: TSymbol;
begin
  Result := Slice(IndexOf(',') + 1, IndexOf(',', 2) - 1);
end;

function TSplitter.Target: TState;
begin
  Result := Slice(IndexOf('(', 2), IndexOf(',', 3) - 1);
end;

{ TTransition }

constructor TTransition.Create(const Splitter: TSplitter);
begin
  Source := Splitter.Source;
  Target := Splitter.Target;
  Symbol := Splitter.Symbol;
  Push   := Splitter.Push;
  Pop    := Splitter.Pop;
end;

end.
