-module(position).

-export([new/2, x/1, y/1, move/2, distance/2]).

-record(position, {x = 0, y = 0}).

new(X, Y) when is_number(X), is_number(Y) ->
    #position{x = X, y = Y}.

x(#position{x = X}) ->
    X.

y(#position{y = Y}) ->
    Y.

move(#position{x = X, y = Y}, D)  ->
    new(X + vector:x(D), Y + vector:y(D)).

distance(#position{x = Ax, y = Ay}, #position{x = Bx, y = By}) ->
    math:sqrt(math:pow(Ax-Bx, 2) + math:pow(Ay-By, 2)).
