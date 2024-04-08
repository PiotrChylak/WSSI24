# Zadanie 2.1.2
:- set_prolog_flag(occurs_check, error).
:- set_prolog_stack(global, limit(0 000 000)).
:- set_prolog_stack(local, limit(2 000 000)).

lubi(jan, pawel).
lubi(pawel, krzysztof).
lubi(pawel, jan).
lubi(jan, bartek).
lubi(bartek, jan).
lubi(jan, agnieszka)
lubi(agnieszka, jan)
lubi(krzysztof, patrycja)
lubi(bartek, patrycja)
lubi(jan, malgosie)
lubi(malgosia, krzysztof)
lubi(krzysztof, ewa)
lubi(ewa, krzysztof)

mezczyzna(jan).
mezczyzna(pawel).
mezczyzna(krzysztof).
mezczyzna(bartek).

kobieta(patrycja).
kobieta(agnieszka).
kobieta(malgosia).
kobieta(ewa).

przyjazn(X, Y) :-
  lubi(X, Y),
  lubi(Y, X).

nieprzyjazn(X, Y) :-
  \+ (lubi(X, Y),
  \+ (lubi(Y, X).

niby_przyjazn(X, Y) :-
  lubi(X, Y);
  lubi(Y, X).

milosc(X, Y) :-
  przyjazn(X, Y),
  \+ (lubi(X, Z), Z \= Y),
  \+ (lubi(Y, W), W \= X).

prawdziwa_milosc(X, Y) :-
  milosc(X, Y),
  mezczyzna(X) \= mezczyzna(Y).
