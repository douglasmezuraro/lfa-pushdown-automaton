unit Impl.Validator;

interface

uses
  Impl.List, Impl.PushdownAutomaton, Impl.Transition, Impl.Transitions, Impl.Types, System.SysUtils;

type
  TValidator = class sealed
  strict private
    FAuxSymbols: TList;
    FBase: TSymbol;
    FMessage: TMessage;
    FInitialState: TState;
    FStates: TList;
    FSymbols: TList;
    FTransitions: TTransitions;
  private
    function ValidateAuxSymbols: Boolean;
    function ValidateBase: Boolean;
    function ValidateInitialState: Boolean;
    function ValidateStates: Boolean;
    function ValidateSymbols: Boolean;
    function ValidateTransitions: Boolean;
    procedure Setup(const Automaton: TPushdownAutomaton);
  public
    constructor Create;
    destructor Destroy; override;
    function Validate(const Automaton: TPushdownAutomaton): TValidationResult;
  end;

implementation

constructor TValidator.Create;
begin
  FSymbols := TList.Create;
  FStates := TList.Create;
  FAuxSymbols := TList.Create;
  FInitialState := TState.Empty;
  FBase := TSymbol.Empty;
  FMessage := string.Empty;
end;

destructor TValidator.Destroy;
begin
  FSymbols.Free;
  FStates.Free;
  FAuxSymbols.Free;
  inherited Destroy;
end;

procedure TValidator.Setup(const Automaton: TPushdownAutomaton);
begin
  FSymbols.Add(Automaton.Symbols);
  FStates.Add(Automaton.States);
  FAuxSymbols.Add(Automaton.AuxSymbols);
  FInitialState := Automaton.InitialState;
  FBase := Automaton.Base;
  FTransitions := Automaton.Transitions;
end;

function TValidator.Validate(const Automaton: TPushdownAutomaton): TValidationResult;
begin
  Setup(Automaton);

  if not ValidateSymbols then
    Exit(TValidationResult.Create(False, FMessage));

  if not ValidateStates then
    Exit(TValidationResult.Create(False, FMessage));

  if not ValidateInitialState then
    Exit(TValidationResult.Create(False, FMessage));

  if not ValidateAuxSymbols then
    Exit(TValidationResult.Create(False, FMessage));

  if not ValidateBase then
    Exit(TValidationResult.Create(False, FMessage));

  if not ValidateTransitions then
    Exit(TValidationResult.Create(False, FMessage));

  Result := TValidationResult.Create(True, TMessage.Empty);
end;

function TValidator.ValidateAuxSymbols: Boolean;
var
  Duplicated: TList;
begin
  Result := False;

  if FSymbols.IsEmpty then
  begin
    FMessage := 'The aux symbols is not defined.';
    Exit;
  end;

  Duplicated := FSymbols.Duplicated;
  try
    if not Duplicated.IsEmpty then
    begin
      FMessage := Format('The aux symbols %s is duplicated.', [Duplicated.ToString]);
      Exit;
    end;
  finally
    Duplicated.Free;
  end;

  Result := True;
end;

function TValidator.ValidateBase: Boolean;
begin
  Result := False;

  if FBase.IsEmpty then
  begin
    FMessage := 'The base is not defined.';
    Exit;
  end;

  if not FAuxSymbols.Contains(FBase) then
  begin
    FMessage := Format('The base %s is not in aux symbols %s.', [FBase.QuotedString, FAuxSymbols.ToString]);
    Exit;
  end;

  Result := True;
end;

function TValidator.ValidateInitialState: Boolean;
begin
  Result := False;

  if FInitialState.IsEmpty then
  begin
    FMessage := 'The initial state is not defined.';
    Exit;
  end;

  if not FStates.Contains(FInitialState) then
  begin
    FMessage := Format('The state %s is not in states list %s.', [FInitialState.QuotedString, FStates.ToString]);
    Exit;
  end;

  Result := True;
end;

function TValidator.ValidateStates: Boolean;
var
  Duplicated: TList;
begin
  Result := False;

  if FStates.IsEmpty then
  begin
    FMessage := 'The states is not defined.';
    Exit;
  end;

  Duplicated := FStates.Duplicated;
  try
    if not Duplicated.IsEmpty then
    begin
      FMessage := Format('The states %s is duplicated.', [Duplicated.ToString]);
      Exit;
    end;
  finally
    Duplicated.Free;
  end;

  Result := True;
end;

function TValidator.ValidateSymbols: Boolean;
var
  Duplicated: TList;
begin
  Result := False;

  if FSymbols.IsEmpty then
  begin
    FMessage := 'The symbols is not defined.';
    Exit;
  end;

  Duplicated := FSymbols.Duplicated;
  try
    if not Duplicated.IsEmpty then
    begin
      FMessage := Format('The symbols %s is duplicated.', [FSymbols.ToString]);
      Exit;
    end;
  finally
    Duplicated.Free;
  end;

  Result := True;
end;

function TValidator.ValidateTransitions: Boolean;
var
  Transition: TTransition;
  Symbol: TSymbol;
begin
  Result := False;

  if FTransitions.IsEmpty then
  begin
    FMessage := 'The transitions has been not defined.';
    Exit;
  end;

  for Transition in FTransitions.ToArray do
  begin
    if not FStates.Contains(Transition.Source) then
    begin
      FMessage := Format('The source state %s is not in states list %s.', [Transition.Source.QuotedString, FStates.ToString]);
      Exit;
    end;

    if (not Transition.Symbol.Equals(TSymbol.Empty)) and (not FSymbols.Contains(Transition.Symbol)) then
    begin
      FMessage := Format('The symbol %s is not in symbols list %s.', [Transition.Symbol.QuotedString, FSymbols.ToString]);
      Exit;
    end;

    for Symbol in Transition.Pop do
    begin
      if Symbol.Equals(TSymbol.Empty) then
        Continue;

      if not FAuxSymbols.Contains(Symbol) then
      begin
        FMessage := Format('The pop symbol %s is not in aux symbols list %s.', [Symbol.QuotedString, FAuxSymbols.ToString]);
        Exit;
      end;
    end;

    if not FStates.Contains(Transition.Target) then
    begin
      FMessage := Format('The target state %s is not in states list %s.', [Transition.Target.QuotedString, FStates.ToString]);
      Exit;
    end;

    for Symbol in Transition.Push do
    begin
      if Symbol.Equals(TSymbol.Empty) then
        Continue;

      if not FAuxSymbols.Contains(Symbol) then
      begin
        FMessage := Format('The push symbol %s is not in aux symbols list %s.', [Symbol.QuotedString, FAuxSymbols.ToString]);
        Exit;
      end;
    end;
  end;

  Result := True;
end;

end.

