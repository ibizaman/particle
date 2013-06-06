-module(force_tests).
-include_lib("eunit/include/eunit.hrl").

approximatively_equal(A, B, Epsilon) ->
    erlang:abs(A-B) < Epsilon.

getter_test() ->
    F1 = force:new({1,2}, 3),
    F2 = force:new(vector:new(-2,1), 1),
    F3 = force:new(),
    ?assertEqual(3, force:intensity(F1)),
    ?assertEqual(1, force:intensity(F2)),
    ?assertEqual(0, force:intensity(F3)),
    ?assertEqual(vector:unitLength(vector:new(1,2)), force:direction(F1)),
    ?assertEqual(vector:unitLength(vector:new(-2,1)), force:direction(F2)).

invertDirection_test() ->
    force:invertDirection(force:new()),
    F = force:new({1,2}, 3),
    ?assertEqual(force:new({-1,-2}, 3), force:invertDirection(F)).

add_test() ->
    F1 = force:new({1,2}, 3),
    F2 = force:new({1,-1}, 1),
    Fadd = force:add(F1, F2),
    io:format("~w~n", [Fadd]),
    ?assert(approximatively_equal(0.719739, vector:x(force:direction(Fadd)), 1.0e-6)),
    ?assert(approximatively_equal(0.694244, vector:y(force:direction(Fadd)), 1.0e-6)),
    ?assert(approximatively_equal(2.846512, force:intensity(Fadd), 1.0e-6)).
