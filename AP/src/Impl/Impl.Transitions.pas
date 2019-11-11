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
    FValues: TArray<TTransition>;
    function GetValues: TArray<TTransition>;
  public
    procedure Add(const Transition: TTransition);
    procedure Clear;
    property Values: TArray<TTransition> read GetValues;
  end;

implementation

{ TTransitions }

procedure TTransitions.Add(const Transition: TTransition);
begin
  SetLength(FValues, Length(FValues) + 1);
  FValues[High(FValues)] := Transition;
end;

procedure TTransitions.Clear;
begin
  SetLength(FValues, 0);
end;

function TTransitions.GetValues: TArray<TTransition>;
begin
  Result := FValues;
end;

end.

