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

    // L2 = {(a^n)(b^m)(c^n)/n>0;m>0}
    procedure ExerciseTwo;

    // L3 = {(a^n)(n^2n)/n>0}
    procedure ExerciseTree;

    // L4 = {(a^2n)(b^n)/n>=0}
    procedure ExerciseFour;

    // L5 = {(a^n)(b^m)(c^m)(d^n)/n>=0;m>=0}
    procedure ExerciseFive;

    // L6 = {wε(a,b)*/|w|a=|w|b}
    procedure ExerciseSix;

    // L7 = {(a^n)(b^3m)(c^m)(d^2n)/n>=0;m>=0}
    procedure ExerciseSeven;
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

procedure TExercisesTest.ExerciseTwo;
const
  MustAccept: TArray<TWord> = ['abc', 'abbc', 'abbbc', 'aabcc', 'aabbcc', 'aaabccc', 'aaabbccc'];
  MustNotAccept: TArray<TWord> = ['ʎ', 'a', 'b', 'c', 'ab', 'ac', 'bc', 'abcc', 'aabc', 'aabccc'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b', 'c'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'X'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'q1', 'a', 'X', 'XX'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'q2', 'b', 'X', 'X'));
  FAutomaton.Transitions.Add(TTransition.Create('q2', 'q2', 'b', 'X', 'X'));
  FAutomaton.Transitions.Add(TTransition.Create('q2', 'q3', 'c', 'X', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q3', 'q3', 'c', 'X', 'ʎ'));

  for Word in MustAccept do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in MustNotAccept do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseTree;
const
  MustAccept: TArray<TWord> = ['abb', 'aabbbb', 'aaabbbbbb', 'aaaabbbbbbbb', 'aaaaabbbbbbbbbb'];
  MustNotAccept: TArray<TWord> = ['a', 'b', 'ab', 'aabb', 'aaabbb', 'aab', 'aaaabb', 'aaaaaabbb'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['a', 'b'];
  FAutomaton.States := ['q0', 'q1'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', 'a', 'Z', 'XX'));
  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', 'a', 'X', 'XXX'));
  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q1', 'b', 'X', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'q1', 'b', 'X', 'ʎ'));

  for Word in MustAccept do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in MustNotAccept do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseFour;
const
  MustAccept: TArray<TWord> = ['ʎ', 'aab', 'aaaabb', 'aaaaaabbb', 'aaaaaaaabbbb', 'aaaaaaaaaabbbbb'];
  MustNotAccept: TArray<TWord> = ['a', 'b', 'ab', 'aabb', 'aaabbb', 'abb', 'aabbbb', 'aaabbbbbb', 'aaaabbbbbbbb', 'aaaaabbbbbbbbbb'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['ʎ', 'a', 'b'];
  FAutomaton.States := ['q0', 'q1'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', 'ʎ', 'Z', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', 'a', 'Z', 'X'));
  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', 'a', 'X', 'XX'));
  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q1', 'b', 'XX', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'q1', 'b', 'XX', 'ʎ'));

  for Word in MustAccept do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in MustNotAccept do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseFive;
const
  MustAccept: TArray<TWord> = ['ʎ', 'ad', 'bc', 'aadd', 'bbcc', 'aaaddd', 'bbbccc', 'abcd', 'aabbccdd', 'aaabbccddd', 'aaabbbcccddd', 'aaaabbbcccdddd'];
  MustNotAccept: TArray<TWord> = ['a', 'b', 'c', 'd', 'ab', 'ac', 'bd', 'cd', 'aabcd', 'abcdd', 'abbcd', 'abccd', 'aabbcdd', 'aabccdd'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['ʎ', 'a', 'b', 'c', 'd'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', 'ʎ', 'Z', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', 'a', 'Z', 'X'));
  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', 'a', 'X', 'XX'));
  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q1', 'b', 'Z', 'X'));
  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q1', 'b', 'X', 'XX'));
  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q3', 'd', 'X', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'q1', 'b', 'X', 'XX'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'q2', 'c', 'X', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q2', 'q2', 'c', 'X', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q2', 'q3', 'd', 'X', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q3', 'q3', 'd', 'X', 'ʎ'));

  for Word in MustAccept do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in MustNotAccept do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseSix;
const
  MustAccept: TArray<TWord> = ['ʎ', 'ab', 'ba', 'aabb', 'bbaa', 'abab', 'baba', 'abbaab', 'baabba', 'aabbabba'];
  MustNotAccept: TArray<TWord> = ['a', 'b', 'aab', 'bba', 'aba', 'bab', 'aaaa', 'bb', 'aa', 'abababa'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['ʎ', 'a', 'b'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3', 'q4'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', 'ʎ', 'Z', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'X'));
  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q1', 'a', 'X', 'XX'));
  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q2', 'b', 'Z', 'X'));
  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q2', 'b', 'X', 'XX'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'q1', 'a', 'X', 'XX'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'q3', 'b', 'X', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q2', 'q2', 'b', 'X', 'XX'));
  FAutomaton.Transitions.Add(TTransition.Create('q2', 'q4', 'a', 'X', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q3', 'q1', 'a', 'ʎ', 'X'));
  FAutomaton.Transitions.Add(TTransition.Create('q3', 'q1', 'a', 'X', 'XX'));
  FAutomaton.Transitions.Add(TTransition.Create('q3', 'q2', 'b', 'ʎ', 'X'));
  FAutomaton.Transitions.Add(TTransition.Create('q3', 'q3', 'b', 'X', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q4', 'q2', 'b', 'X', 'XX'));
  FAutomaton.Transitions.Add(TTransition.Create('q4', 'q2', 'b', 'ʎ', 'X'));
  FAutomaton.Transitions.Add(TTransition.Create('q4', 'q1', 'a', 'ʎ', 'X'));
  FAutomaton.Transitions.Add(TTransition.Create('q4', 'q4', 'a', 'X', 'ʎ'));

  for Word in MustAccept do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in MustNotAccept do
    CheckFalse(FAutomaton.Accept(Word));
end;

procedure TExercisesTest.ExerciseSeven;
const
  MustAccept: TArray<TWord> = ['ʎ', 'add', 'aadddd', 'aaadddddd', 'bbbc', 'bbbbbbcc', 'bbbbbbbbbccc', 'abbbcdd', 'aabbbbbbccdddd', 'aaabbbbbbbbbcccdddddd'];
  MustNotAccept: TArray<TWord> = ['a', 'b', 'c', 'd', 'abcd', 'aabbccdd', 'abcdd', 'aabcdddd', 'abbbcd', 'aabbbbbbccdd'];
var
  Word: TWord;
begin
  FAutomaton.Symbols := ['ʎ', 'a', 'b', 'c', 'd'];
  FAutomaton.States := ['q0', 'q1', 'q2', 'q3', 'q4'];
  FAutomaton.InitialState := 'q0';
  FAutomaton.AuxSymbols := ['Z', 'X'];
  FAutomaton.Base := 'Z';

  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q0', 'ʎ', 'Z', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q1', 'a', 'Z', 'XX'));
  FAutomaton.Transitions.Add(TTransition.Create('q0', 'q2', 'b', 'Z', 'X'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'q1', 'a', 'X', 'XXX'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'q4', 'd', 'X', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q1', 'q2', 'b', 'X', 'XX'));
  FAutomaton.Transitions.Add(TTransition.Create('q2', 'q2', 'b', 'X', 'XX'));
  FAutomaton.Transitions.Add(TTransition.Create('q2', 'q3', 'c', 'XXX', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q3', 'q3', 'c', 'XXX', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q3', 'q4', 'd', 'X', 'ʎ'));
  FAutomaton.Transitions.Add(TTransition.Create('q4', 'q4', 'd', 'X', 'ʎ'));

  for Word in MustAccept do
    CheckTrue(FAutomaton.Accept(Word));

  for Word in MustNotAccept do
    CheckFalse(FAutomaton.Accept(Word));
end;

initialization
  RegisterTest(TExercisesTest.Suite);

end.
