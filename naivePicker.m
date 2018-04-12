
function carIndex = naivePicker(t, config, cars, call)
% Parameters:
%  t (integer): the current elapsed time (s)
%  config (struct): contains configuration constants defined in main.m
%  cars (struct array): data for each of the elevator cars
%       This includes the following data:
%       velocity
%       doorsOpen
%       destinations
%       y                   position of car
%  call (struct): data about this call
%       fromFloor
%       toFloor
%       direction           value of 1 for up, -1 for down
%
% Return:
%  carIndex (integer between 1 and NUM_CARS) that will respond to this call
% 
% Authors: 
    

%% Gather necessary data - simplifies future coding

% config data
num_cars = config.NUM_CARS;

% car data
currentPos = cars.y;
destinations = cars.destinations;
velocity = cars.velocity;

% call data
toFloor = call.toFloor;
direction = call.direction;
fromFloor = call.fromFloor;

%% Create scoring system
% Gives set values for scores, numbers can be tweaked as necessary
% If a fraction is included, that fraction is multiplied by the score value

floorCorrect = 100;     % same floor as call
directionCorrect = 70;  % same direction
directionFracBase = 50;     % fraction of calls towards the same direction/all calls
distanceFracBase = 20;      % 1 - fraction of distance/building height
stopsFracBase = -150;      % fraction of stops/number of floors
sums = zeros(1,num_cars);   % holds the score total for each car


%% Sums each car's point total
% does so via for loop from 1 to num_cars
for iCar = 1:config.NUM_CARS
    % same floor?
    if currentPos == fromFloor
        sums(iCar) = sums(iCar) + 100;
    end;
    
    % same direction?
    if sign(direction) == sign(velocity)
        % makes sure that car is headed towards call
        if sign(direction) == -1 && currentPos > fromFloor
            sums(iCar) = sums(iCar) + 70;
        elseif sign(direction) == 1 && currentPos < fromFloor
            sums(iCar) = sums(iCar) + 70;
        end;
    end;
    
    % directionFracBase
    numSame = 0;
    while iDestinations = 1:size(destinations)
        direc = destinations(iDestinations) - currentPos;
        if sign(direc) == sign(direction)
            if sign(direction) == -1 && currentPos > fromFloor
                numSame = numSame + 1;
            elseif sign(direction) == 1 && currentPos < fromFloor
                numSame = numSame + 1;
        end;
    end;
    
    directionFracBase = directionFracBase * (numSame/destinations);
    
    %
            



%% determine best car, return as carIndex

% carIndex = randi(config.NUM_CARS); % for testing purposes
end
