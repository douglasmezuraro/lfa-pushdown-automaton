unit Test.Exercises;

interface

uses
  TestFramework, Impl.PushdownAutomaton, Impl.Transition, Impl.Types;

type
  TExercisesTest = class sealed(TTestCase)
  strict private
    FAutomaton: TPushdownAutomaton;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    // L1 = {(a^n)(b^n)/n>=0}
    procedure ExerciseOne;
  end;

implementation

procedure TExercisesTest.SetUp;
begin
  FAutomaton := TPushdownAutomaton.Create;
end;

procedure TExercisesTest.TearDown;
begin
  FAutomaton.Free;
end;

procedure TExercisesTest.ExerciseOne;
const
  MustAccept: TArray<TWord> = ['ʎ', 'ab', 'aabb', 'aaabbb', 'aaaabbbb', 'aaaaabbbbb'];
  MustNotAccept: TArray<TWord> = ['a', 'b', 'ba', 'bbaa', 'aab', 'aaabb', 'abb', 'aabbb'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['ʎ', 'a', 'b'];
  FAutomaton.States := ['q0', 'q1', 'q2'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  // Source ; Target ; Symbol ; Pop ; Push
  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', 'ʎ', 'Z', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'X'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'q1', 'a', 'X', 'XX'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'q2', 'b', 'X', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q2', 'q2', 'b', 'X', 'ʎ'));

  for Word in MustAccept do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in MustNotAccept do
    CheckFalse(FAutomaton.Accept(Word));
end;

initialization
  RegisterTest(TExercisesTest.Suite);

end.
