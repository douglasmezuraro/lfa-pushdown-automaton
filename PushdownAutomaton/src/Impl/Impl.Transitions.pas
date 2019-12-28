unit Impl.Transitions;

interface

uses
  Impl.Transition, Impl.Types, System.SysUtils;

type
  TTransitions = class sealed
  strict private
    FTransitions: TArray<TTransition>;
  public
    destructor Destroy; override;
  public
    function Add(const Transition: TTransition): TTransitions; overload;
    function Add(const Transitions: TArray<TTransition>): TTransitions; overload;
    function Count: Integer;
    function IsEmpty: Boolean;
    function ToArray: TArray<TTransition>;
    function Transition(const State: TState; const Symbol, Top: TSymbol): TTransition;
    procedure Clear;
  end;

implementation

destructor TTransitions.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TTransitions.Add(const Transition: TTransition): TTransitions;
begin
  SetLength(FTransitions, Length(FTransitions) + 1);
  FTransitions[High(FTransitions)] := Transition;

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

procedure TTransitions.Clear;
var
  Transition: TTransition;
begin
  for Transition in FTransitions do
    Transition.Free;

  FTransitions := nil;
end;

function TTransitions.Count: Integer;
begin
  Result := Length(FTransitions);
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

    if not Transition.Pop.EndsWith(Top) then
      Continue;

    Exit(Transition);
  end;
end;

function TTransitions.IsEmpty: Boolean;
begin
  Result := FTransitions = nil;
end;

end.

