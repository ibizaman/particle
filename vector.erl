-module(vector).

-export([new/2, x/1, y/1, add/2, substract/2, negate/1, multiply/2, len/1, unitLength/1]).

-record(vector, {x = 0, y = 0}).

new(X, Y) when is_number(X), is_number(Y) ->
    #vector{x = X, y = Y};
new(PosA, PosB) ->
    #vector{
        x = position:x(PosB)-position:x(PosA),
        y = position:y(PosB)-position:x(PosA)
    }.

x(#vector{x = X}) ->
    X.

y(#vector{y = Y}) ->
    Y.

add(#vector{x = Ax, y = Ay}, #vector{x = Bx, y = By}) ->
    new(Ax+Bx, Ay+By).

substract(#vector{x = Ax, y = Ay}, #vector{x = Bx, y = By}) ->
    new(Ax-Bx, Ay-By).

negate(#vector{x = X, y = Y}) ->
    new(-X, -Y).

multiply(#vector{x = X, y = Y}, N) ->
    new(X*N, Y*N).

len(#vector{x = X, y = Y}) ->
    math:sqrt(X*X + Y*Y).

unitLength(V=#vector{x = X, y = Y}) ->
    Length = len(V),
    new(X/Length, Y/Length).
