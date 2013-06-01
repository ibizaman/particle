-module(inertia).

-export([new/2, mass/1, position/1, speed/1, move/2, applyForce/3]).

-record(inertia, {mass = 0, position = position:new(0,0), speed = vector:new(0,0)}).

new(Mass, {X,Y}) ->
    #inertia{mass = Mass, position = position:new(X,Y)}.

mass(#inertia{mass = Mass}) ->
    Mass.
position(#inertia{position = Position}) ->
    Position.
speed(#inertia{speed = Speed}) ->
    Speed.

move(Inertia = #inertia{position = Position, speed = Speed}, Dt) ->
    NPosition = position:move(Position, vector:multiply(Speed, Dt)),
    Inertia#inertia{position = NPosition}.

applyForce(Inertia = #inertia{speed = Speed, mass = Mass}, Force, Dt) ->
    Acceleration = vector:multiply(force:direction(Force), force:intensity(Force) / Mass),
    NSpeed = vector:add(Speed, vector:multiply(Acceleration, Dt)),
    Inertia#inertia{speed = NSpeed}.
