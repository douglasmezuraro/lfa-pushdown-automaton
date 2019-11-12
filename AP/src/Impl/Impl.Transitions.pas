unit Impl.Transitions;

interface

uses
  Impl.Types, System.SysUtils;

type
  TTransition = record
    Source: TState;
    Target: TState;
    Symbol: TSymbol;
    Push: TSymbol;
    Pop: TSymbol;
  end;

  TTransitions = record
  private
    FTransitions: TArray<TTransition>;
  public
    function IsEmpty: Boolean;
    function ToArray: TArray<TTransition>;
    function HasTransition(const State: TState; const Symbol, Top: TSymbol): Boolean;
    function Transition(const State: TState; const Symbol, Top: TSymbol): TTransition;
    procedure Add(const Transition: TTransition);
    procedure Clear;
  end;

implementation

{ TTransitions }

procedure TTransitions.Add(const Transition: TTransition);
begin
  SetLength(FTransitions, Length(FTransitions) + 1);
  FTransitions[High(FTransitions)] := Transition;
end;

procedure TTransitions.Clear;
begin
  SetLength(FTransitions, 0);
end;

function TTransitions.HasTransition(const State: TState; const Symbol, Top: TSymbol): Boolean;
var
  LTransition: TTransition;
begin
  Result := False;
  try
    LTransition := Transition(State, Symbol, Top);
    Result := True;
  except
    on Exception: EArgumentNilException do
      Result := False;
  end;
end;

function TTransitions.ToArray: TArray<TTransition>;
begin
  Result := FTransitions;
end;

function TTransitions.Transition(const State: TState; const Symbol, Top: TSymbol): TTransition;
var
  Transition: TTransition;
begin
  for Transition in FTransitions do
  begin
    if not Transition.Source.Equals(State) then
      Continue;

    if not Transition.Symbol.Equals(Symbol) then
      Continue;

    if not Transition.Push.Equals(Top) then
      Continue;

    Exit(Transition);
  end;

  raise EArgumentNilException.Create('Transition not found.');
end;

function TTransitions.IsEmpty: Boolean;
begin
  Result := Length(FTransitions) = 0;
end;

end.

