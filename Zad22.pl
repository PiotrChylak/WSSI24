:- set_prolog_flag(occurs_check, error).
:- set_prolog_stack(global, limit(8 000 000)).
:- set_prolog_stack(local,  limit(2 000 000)).

parent(piotrek, szymon).
parent(patrycja, szymon).
parent(bogdan, piotrek).
parent(agnieszka, piotrek).
parent(leszczek, mateusz).
parent(ewa, matuesz).

male(piotrek).
male(bogdan).
male(mateusz).
male(leszek).
male(szymon).

person(patrycja).
person(agnieszka).
person(malgosia).
person(ewa).

female(X) :- 
  \+ male(X).

father(X, Y) :-
  male(X),
  parent(X, Y),
  X \= Y.

mother(X, Y) :-
  female(X),
  parent(X, Y),
  X \= Y.

son(X, Y) :-
  male(X),
  parent(Y, X),

daughter(X, Y) :-
  female(X),
  parent(Y, X).

brother(X, Y) :-
  male(X),
  parent(D, X),
  parent(D, Y),
  parent(M, X),
  parent(M, Y),
  X /= Y.

sister(X, Y) :-
  female(X),
  parent(D, X),
  parent(D, Y),
  parent(M, X),
  parent(M, Y),
  X /= Y.

step_brother(X, Y) :-
  male(X),
  (father(D, X), mother(M, Y), \+ father(D, Y), \+ mother(M, X));
  (mother(M, X), father(D, Y), \+ mother(M, Y), \+ father(D, X)),
  X \= Y.

cousin(X, Y) :-
  parent(R, X),
  parent(P, Y),
  (sister(P, R); brother(P, R)),
  P \= R.

grandfather_from_father_site(X,Y) :-
    father(X,D),father(D,Y),
	  X\= Y,
	  D\=Y,
	  X\=D.
grandfather_from_mother_site(X,Y) :-
    father(X,M), mother(M,Y),
	  X \= M,
	  Y \= M,
	  X \= Y.

grandfather(X,Y) :-
    (grandfather_from_father_site(X,Y);
    grandfather_from_mother_site(X,Y)),
    X \= Y.

grandmother(X,Y) :-
    (mother(X,D),father(D,Y); mother(X,M),
    mother(M,Y)),
    X \= Y.
