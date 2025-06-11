passaro(tweety).
peixe(goldie).
minhoca(molie).

gosta(passaro, minhoca).
gosta(gato, peixe).
gosta(gato, passaro).

amigo(X, Y) :- amigo(Y, X).
amigo(eu, silvester).

come(X, Y) :- gosta(X, Y).
come(silvester, Z) :- gosta(gato, Z).
