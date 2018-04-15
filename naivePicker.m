
function [carIndex, sums] = naivePicker(t, config, cars, call)
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




%% Create scoring system, set up basic parameters
% Gives set values for scores, numbers can be tweaked as necessary
% If a fraction is included, that fraction is multiplied by the score value
num_cars = config.NUM_CARS; % simplifies config.NUM_CARS
sums = zeros(1,num_cars);   % holds the score total for each car

% Change these values to modify scoring!
floorCorrect = 100;     % same floor as call
directionCorrect = 70;  % same direction
directionFracBase = 50;     % fraction of calls towards the same direction/all calls
distanceFracBase = 20;      % 1 - fraction of distance/building height
stopsFracBase = -150;      % fraction of stops/number of floors


%% Sums each car's point total
% does so via for loop from 1 to num_cars
for iCar = 1:num_cars
    %% simplify structs
    % car data
    currentPos = cars(iCar).y;
    destinations = cars(iCar).destinations;
    velocity = cars(iCar).velocity;
    [~,stops] = size(destinations);  % gets number of stops
    
    % call data
    %toFloor = call.toFloor;
    direction = call.direction;
    fromFloor = call.fromFloor;
    
    %% start scoring for iCar
    % floorCorrect
    if currentPos == fromFloor
        sums(iCar) = sums(iCar) + floorCorrect;
    end
    
    % directionCorrect
    if sign(direction) == sign(velocity)
        % makes sure that car is headed towards call
        if sign(direction) == -1 && currentPos > fromFloor
            sums(iCar) = sums(iCar) + directionCorrect;
        elseif sign(direction) == 1 && currentPos < fromFloor
            sums(iCar) = sums(iCar) + directionCorrect;
        end
    end
    
    % directionFracBase
    if stops > 0 % only matters if there are already stops
        numSame = 0;
        % for loop checks each destination and determines the direction needed
        % to be taken
        % TODO: change comparison to be between a destination and its next
        % destination?
        for iDestinations = 1:stops
            direc = destinations(1,iDestinations) - currentPos;
            % makes sure that car is headed towards call
            if sign(direc) == sign(direction)
                if sign(direction) == -1 && currentPos > fromFloor
                    numSame = numSame + 1;
                elseif sign(direction) == 1 && currentPos < fromFloor
                    numSame = numSame + 1;
                end
            end
        end
        sums(iCar) = sums(iCar) + directionFracBase * (numSame/stops);
    end
    
    % distanceFracBase
    difference = abs(currentPos - fromFloor);
    sums(iCar) = sums(iCar) + distanceFracBase*(1 - (difference/config.NUM_FLOORS));

    % stopsFracBase
    stops = stops/num_cars;
    %disp(stops);
    sums(iCar) = sums(iCar) + stopsFracBase*stops;
    
end

%% determine best car, return as carIndex
[~, idx] = max(sums);
carIndex = idx;
end
