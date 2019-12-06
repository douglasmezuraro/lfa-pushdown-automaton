unit Test.Validator;

interface

uses
  TestFramework, Impl.Validator;

type
  TValidatorTest = class sealed(TTestCase)
  strict private
    FValidator: TValidator;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAcceptWhenAutomatonSymbolsIsNotDefined;
    procedure TestAcceptWhenAutomatonHasDuplicatedSymbol;

    procedure TestAcceptWhenAutomatonStatesIsNotDefined;
    procedure TestAcceptWhenAutomatonHasDuplicatedState;

    procedure TestAcceptWhenAutomatonInitialStateIsNotDefined;
    procedure TestAcceptWhenAutomatonInitialStateIsNotFound;

    procedure TestAcceptWhenAutomatonAuxSymbolsIsNotDefined;
    procedure TestAcceptWhenAutomatonHasDuplicatedAuxSymbol;

    procedure TestAcceptWhenAutomatonBaseIsNotDefined;
    procedure TestAcceptWhenAutomatonBaseIsNotFound;

    procedure TestAcceptWhenAutomatonTransitionsIsNotDefined;

    procedure TestAcceptWhenTheTransitionSourceIsNotDefined;
    procedure TestAcceptWhenTheTransitionSourceIsNotFound;

    procedure TestAcceptWhenTheTransitionTargetIsNotDefined;
    procedure TestAcceptWhenTheTransitionTargetIsNotFound;

    procedure TestAcceptWhenTheTransitionSymbolIsNotDefined;
    procedure TestAcceptWhenTheTransitionSymbolIsNotFound;

    procedure TestAcceptWhenTheTransitionPopSymbolIsNotDefined;
    procedure TestAcceptThenTheTransitionPopSymbolIsNotFound;

    procedure TestAcceptWhenTheTransitionPushSymbolIsNotDefined;
    procedure TestAcceptWhenTheTransitionPushSymbolIsNotFound;

    procedure TestAcceptWhenTheAutomatonIsValid;
  end;

implementation

procedure TValidatorTest.SetUp;
begin
  FValidator := TValidator.Create;
end;

procedure TValidatorTest.TearDown;
begin
  FValidator.Free;
end;

procedure TValidatorTest.TestAcceptThenTheTransitionPopSymbolIsNotFound;
begin

end;

procedure TValidatorTest.TestAcceptWhenAutomatonAuxSymbolsIsNotDefined;
begin

end;

procedure TValidatorTest.TestAcceptWhenAutomatonBaseIsNotDefined;
begin

end;

procedure TValidatorTest.TestAcceptWhenAutomatonBaseIsNotFound;
begin

end;

procedure TValidatorTest.TestAcceptWhenAutomatonHasDuplicatedAuxSymbol;
begin

end;

procedure TValidatorTest.TestAcceptWhenAutomatonHasDuplicatedState;
begin

end;

procedure TValidatorTest.TestAcceptWhenAutomatonHasDuplicatedSymbol;
begin

end;

procedure TValidatorTest.TestAcceptWhenAutomatonInitialStateIsNotDefined;
begin

end;

procedure TValidatorTest.TestAcceptWhenAutomatonInitialStateIsNotFound;
begin

end;

procedure TValidatorTest.TestAcceptWhenAutomatonStatesIsNotDefined;
begin

end;

procedure TValidatorTest.TestAcceptWhenAutomatonSymbolsIsNotDefined;
begin

end;

procedure TValidatorTest.TestAcceptWhenAutomatonTransitionsIsNotDefined;
begin

end;

procedure TValidatorTest.TestAcceptWhenTheAutomatonIsValid;
begin

end;

procedure TValidatorTest.TestAcceptWhenTheTransitionPopSymbolIsNotDefined;
begin

end;

procedure TValidatorTest.TestAcceptWhenTheTransitionPushSymbolIsNotDefined;
begin

end;

procedure TValidatorTest.TestAcceptWhenTheTransitionPushSymbolIsNotFound;
begin

end;

procedure TValidatorTest.TestAcceptWhenTheTransitionSourceIsNotDefined;
begin

end;

procedure TValidatorTest.TestAcceptWhenTheTransitionSourceIsNotFound;
begin

end;

procedure TValidatorTest.TestAcceptWhenTheTransitionSymbolIsNotDefined;
begin

end;

procedure TValidatorTest.TestAcceptWhenTheTransitionSymbolIsNotFound;
begin

end;

procedure TValidatorTest.TestAcceptWhenTheTransitionTargetIsNotDefined;
begin

end;

procedure TValidatorTest.TestAcceptWhenTheTransitionTargetIsNotFound;
begin

end;

initialization
  RegisterTest(TValidatorTest.Suite);

end.
