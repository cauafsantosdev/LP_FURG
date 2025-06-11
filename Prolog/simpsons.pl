% Gêneros
mulher(marge).
mulher(selma).
mulher(patty).
mulher(lisa).
mulher(maggie).
mulher(jackie).
mulher(mona).
mulher(ling).

homem(abraham).
homem(homer).
homem(bart).
homem(herb).
homem(clancy).
homem(maridoSelma).

% Parentescos diretos
pai(clancy, marge).
pai(clancy, selma).
pai(clancy, patty).
pai(abraham, herb).
pai(abraham, homer).
pai(homer, bart).
pai(homer, lisa).
pai(homer, maggie).
pai(maridoSelma, ling).


mae(jackie, marge).
mae(jackie, selma).
mae(jackie, patty).
mae(mona, homer).
mae(mona, herb).
mae(marge, bart).
mae(marge, lisa).
mae(marge, maggie).
mae(selma, ling).

% Casamentos
casado(abraham, mona).
casado(clancy, jackie).
casado(homer, marge).
casado(maridoSelma, selma).

% Regras derivadas
irmao(X, Y) :- pai(P, X), pai(P, Y), mae(M, X), mae(M, Y), X \= Y.
irma(X, Y) :- irmao(X, Y), mulher(X).

tio(X, Y) :- irmao(X, Z), pai(Z, Y).
tio(X, Y) :- irmao(X, Z), mae(Z, Y).
tia(X, Y) :- irma(X, Z), mae(Z, Y).
tia(X, Y) :- irma(X, Z), pai(Z, Y).

tioAfinidade(X, Y) :- casado(X, T), tia(T, Y), homem(X).
tiaAfinidade(X, Y) :- casado(X, T), tio(T, Y), mulher(X).

primo(X, Y) :- pai(P1, X), pai(P2, Y), irmao(P1, P2), homem(X).
primo(X, Y) :- mae(M1, X), mae(M2, Y), irma(M1, M2), homem(X).
prima(X, Y) :- pai(P1, X), pai(P2, Y), irmao(P1, P2), mulher(X).
prima(X, Y) :- mae(M1, X), mae(M2, Y), irma(M1, M2), mulher(X).
