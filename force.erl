-module(force).

-export([new/2, intensity/1, direction/1, invertDirection/1, add/2, compute/3, electrostatic/3, gravity/3]).

-record(force, {intensity = 0, direction = vector:new(0,0)}).

-define(Kc, 8.9875517873681764e9).
-define(G, 6.67384e-11).

new({X,Y}, Intensity) when is_number(Intensity) ->
    #force{intensity = Intensity, direction = vector:unitLength(vector:new(X,Y))};
new(Vector, Intensity) ->
    new({vector:x(Vector), vector:y(Vector)}, Intensity).

intensity(#force{intensity = Intensity}) ->
    Intensity.
direction(#force{direction = Direction}) ->
    Direction.

invertDirection(Force) ->
    Force#force{direction = vector:negate(direction(Force))}.

add(ForceA, ForceB) ->
    Vector = vector:add(asVector(ForceA), asVector(ForceB)),
    new(vector:unitLength(Vector), vector:len(Vector)).

asVector(Force) ->
    vector:multiply(direction(Force), intensity(Force)).

% Helper function to compute a force between two positions
compute(ForceType, {PositionA, PropertiesA}, {PositionB, PropertiesB}) ->
    Vector = vector:fromTo(PositionA, PositionB),
    Distance = position:distance(PositionA, PositionB),
    Intensity = force:ForceType(Distance, PropertiesA, PropertiesB),
    Force = new(Vector, Intensity),
    {invertDirection(Force), Force}.

electrostatic(Distance, ChargeA, ChargeB) ->
    ChargeA * ChargeB * ?Kc / math:pow(Distance, 3).

gravity(Distance, MassA, MassB) ->
    MassA * MassB * ?G / math:pow(Distance, 2).
