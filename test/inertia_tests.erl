-module(inertia_tests).
-include_lib("eunit/include/eunit.hrl").

getter_test() ->
    I = inertia:new(1, {1,2}),
    ?assertEqual(1, inertia:mass(I)),
    ?assertEqual(position:new(1,2), inertia:position(I)),
    ?assertEqual(vector:new(0,0), inertia:speed(I)).

applyForce_test() ->
    I = inertia:new(1, {1,2}),
    Force = force:new({1,0}, 2),
    ?assertEqual(vector:new(4.0,0.0), inertia:speed(inertia:applyForce(I, Force, 2))).

move_test() ->
    I = inertia:new(1, {1,2}),
    ?assertEqual(position:new(1,2), inertia:position(inertia:move(I, 2))),
    I2 = inertia:applyForce(I, force:new({1,0}, 2), 2),
    ?assertEqual(position:new(9.0,2.0), inertia:position(inertia:move(I2, 2))).
