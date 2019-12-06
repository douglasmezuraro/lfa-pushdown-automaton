unit Impl.Transitions;

interface

uses
  Impl.Transition, Impl.Types, System.SysUtils, system.Character;

type
  TTransitions = class sealed
  strict private
    FTransitions: TArray<TTransition>;
  public
    destructor Destroy; override;
    function Count: Integer;
    function IsEmpty: Boolean;
    function ToArray: TArray<TTransition>;
    function Transition(const State: TState; const Symbol, Top: TSymbol): TTransition;
    procedure Add(const Transition: TTransition);
    procedure Clear;
  end;

implementation

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
    if Transition.Source <> State then
      Continue;

    if Transition.Symbol <> Symbol then
      Continue;

    if not Transition.Pop.EndsWith(Top) then
      Continue;

    Exit(Transition);
  end;
end;

function TTransitions.IsEmpty: Boolean;
begin
  Result := Count = 0;
end;

end.

