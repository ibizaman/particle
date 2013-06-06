-module(vector_tests).
-include_lib("eunit/include/eunit.hrl").

approximatively_equal(A, B, Epsilon) ->
    abs(A - B) < Epsilon.

getter_test() ->
    V = vector:new(1,2),
    ?assertEqual(1, vector:x(V)),
    ?assertEqual(2, vector:y(V)).

add_test() ->
    V1 = vector:new(1,2),
    V2 = vector:new(3,-1),
    ?assertEqual(vector:new(4,1), vector:add(V1,V2)).

substract_test() ->
    V1 = vector:new(1,2),
    V2 = vector:new(3,-1),
    ?assertEqual(vector:new(-2,3), vector:substract(V1,V2)).

negate_test() ->
    V = vector:new(1,-1),
    ?assertEqual(vector:new(-1,1), vector:negate(V)).

multiply_test() ->
    V = vector:new(1,-2),
    ?assertEqual(vector:new(2,-4), vector:multiply(V, 2)).

len_test() ->
    V = vector:new(3,4),
    ?assert(approximatively_equal(math:sqrt(3*3+4*4), vector:len(V), 1.0e-5)).

unitLength_test() ->
    V = vector:unitLength(vector:new(3,4)),
    ?assert(approximatively_equal(1, vector:len(V), 1.0e-5)).
