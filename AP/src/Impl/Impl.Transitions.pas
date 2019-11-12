unit Impl.Transitions;

interface

uses
  Impl.Types, System.SysUtils;

type
  TTransition = class sealed
  strict private
    FSymbol: TSymbol;
    FSource: TState;
    FPush: TSymbol;
    FTarget: TState;
    FPop: TSymbol;
  public
    property Source: TState read FSource write FSource;
    property Target: TState read FTarget write FTarget;
    property Symbol: TSymbol read FSymbol write FSymbol;
    property Push: TSymbol read FPush write FPush;
    property Pop: TSymbol read FPop write FPop;
  end;

  TTransitions = class sealed
  strict private
    FTransitions: TArray<TTransition>;
  public
    destructor Destroy; override;
    function IsEmpty: Boolean;
    function ToArray: TArray<TTransition>;
    function HasTransition(const State: TState; const Symbol, Top: TSymbol): Boolean;
    function Transition(const State: TState; const Symbol, Top: TSymbol): TTransition;
    procedure Add(const Transition: TTransition);
    procedure Clear;
  end;

implementation

{ TTransitions }

destructor TTransitions.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TTransitions.Add(const Transition: TTransition);
begin
  SetLength(FTransitions, Length(FTransitions) + 1);
  FTransitions[High(FTransitions)] := Transition;
end;

procedure TTransitions.Clear;
var
  Transition: TTransition;
begin
  for Transition in FTransitions do
    Transition.Free;

  SetLength(FTransitions, 0);
end;

function TTransitions.HasTransition(const State: TState; const Symbol, Top: TSymbol): Boolean;
var
  Transition: TTransition;
begin
  Transition := Self.Transition(State, Symbol, Top);
  Result := Assigned(Transition);
end;

function TTransitions.ToArray: TArray<TTransition>;
begin
  Result := FTransitions;
end;

function TTransitions.Transition(const State: TState; const Symbol, Top: TSymbol): TTransition;
var
  Transition: TTransition;
begin
  Result := nil;
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
end;

function TTransitions.IsEmpty: Boolean;
begin
  Result := Length(FTransitions) = 0;
end;

end.

