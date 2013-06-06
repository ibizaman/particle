-module(position_tests).
-include_lib("eunit/include/eunit.hrl").

getter_test() ->
    P = position:new(1,2),
    ?assertEqual(1, position:x(P)),
    ?assertEqual(2, position:y(P)).

move_test() ->
    P = position:new(1,2),
    NP = position:move(P, vector:new(-1,2)),
    ?assertEqual(position:new(0,4), NP).

distance_test() ->
    P1 = position:new(1,2),
    P2 = position:new(0,2),
    ?assertEqual(1.0, position:distance(P1, P2)).
