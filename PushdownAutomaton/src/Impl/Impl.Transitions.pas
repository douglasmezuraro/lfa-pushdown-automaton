unit Impl.Transitions;

interface

uses
  Impl.Transition, Impl.Types, System.SysUtils;

type
  TTransitions = class sealed
  strict private
    FValues: TArray<TTransition>;
  public
    destructor Destroy; override;
  public
    function Add(const Transition: TTransition): TTransitions; overload;
    function Add(const Transitions: TArray<TTransition>): TTransitions; overload;
    function Clear: TTransitions;
    function Count: Integer;
    function IsEmpty: Boolean;
    function Transition(const State: TState; const Symbol, Top: TSymbol): TTransition;
    property Values: TArray<TTransition> read FValues write FValues;
  end;

implementation

destructor TTransitions.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TTransitions.Add(const Transition: TTransition): TTransitions;
begin
  SetLength(FValues, Length(FValues) + 1);
  FValues[High(FValues)] := Transition;

  Result := Self;
end;

function TTransitions.Add(const Transitions: TArray<TTransition>): TTransitions;
var
  Transition: TTransition;
begin
  for Transition in Transitions do
    Add(Transition);

  Result := Self;
end;

function TTransitions.Clear: TTransitions;
var
  Transition: TTransition;
begin
  for Transition in FValues do
    Transition.Free;

  FValues := nil;

  Result := Self;
end;

function TTransitions.Count: Integer;
begin
  Result := Length(FValues);
end;

function TTransitions.Transition(const State: TState; const Symbol, Top: TSymbol): TTransition;
var
  Transition: TTransition;
begin
  Result := nil;
  for Transition in FValues do
  begin
    if not Transition.Source.Equals(State) then
      Continue;

    if not Transition.Symbol.Equals(Symbol) then
      Continue;

    if not Transition.Pop.EndsWith(Top) then
      Continue;

    Exit(Transition);
  end;
end;

function TTransitions.IsEmpty: Boolean;
begin
  Result := FValues = nil;
end;

end.

