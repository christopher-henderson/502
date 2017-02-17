/*
Goldbach's conjecture says that every positive even number greater than 2 is the
sum of two prime numbers. Example: 28 = 5 + 23. It is one of the most famous facts
in number theory that has not been proved to be correct in the general case. It has
been numerically confirmed up to very large numbers (much larger than we can go
with our Prolog system). Write a predicate to find the two prime numbers that sum
up to a given even integer.
6
Sample Run:
?- goldbach(28, L).
L = [5,23]
?- goldbach(30, L).
L = [17,13]
*/

% Given a starting value, divide it by two. Those are our first candidates.
goldbach(Value, Primes) :- V is Value div 2,
                            Candidates = [V, V],
                            goldbach(Value, Primes, Candidates).
% The two candidates, A and B, sum to Value and are both prime.
goldbach(Value, Primes, Candidates) :- sum_list(Candidates, Value),
                                       all_prime(Candidates),
                                       Primes = Candidates.
% Take the previous candidates and add/subtract 1 from them. These are your
% new candidates.
goldbach(Value, Primes, Candidates) :- nth0(0, Candidates, A),
                                       nth0(1, Candidates, B),
                                       A1 is A - 1,
                                       B1 is B + 1,
                                       A1 > 1, B1 < Value,
                                       goldbach(Value, Primes, [A1, B1]).

all_prime([]).
all_prime([H|T]) :- is_prime(H),
                    all_prime(T).
% From class notes.
is_prime(2).
is_prime(3).
is_prime(N) :- (N mod 2) =\= 0, \+ has_factor(3, N).
has_factor(X, N) :- (N mod X) =:= 0.
has_factor(X, N):- (N mod X) =\= 0,
                    X * X < N,
                    X1 is X + 2,
                    has_factor(X1, N).


/*
Didn't turn out to be useful, but I don't have the heart to delete it. Generates all primes.
find_prime(Prime) :- find_prime(Prime, 2).
find_prime(Prime, Candidate) :- is_prime(Candidate),
                                Prime is Candidate.
find_prime(Prime, Candidate) :- Candidate2 is Candidate + 1,
                                find_prime(Prime, Candidate2).
*/
