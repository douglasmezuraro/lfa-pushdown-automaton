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

function TTransitions.ToArray: TArray<TTransition>;
begin
  Result := FTransitions;
end;

function TTransitions.IsEmpty: Boolean;
begin
  Result := Length(FTransitions) = 0;
end;

end.

