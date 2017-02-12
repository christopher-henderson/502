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

goldbach(Value, Primes) :- V is Value div 2,
                            Candidates = [V, V],
                            goldbach(Value, Primes, Candidates).
goldbach(Value, Primes, Candidates) :- nth0(0, Candidates, A),
                                       nth0(1, Candidates, B),
                                       sum_list(Candidates, Value),
                                       is_prime(A),
                                       is_prime(B),
                                       Primes = Candidates.
goldbach(Value, Primes, Candiates) :- nth0(0, Candiates, A),
                                       A1 is A - 1,
                                       nth0(1, Candiates, B),
                                       B1 is B + 1,
                                       A1 > 1, B1 < Value,
                                       goldbach(Value, Primes, [A1, B1]).

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
