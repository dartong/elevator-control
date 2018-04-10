
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
%       
%
% Return:
%  carIndex (integer between 1 and NUM_CARS) that will respond to this call
% 
% Authors: 
    

%% Create scoring system
% Gives set values for scores, numbers can be tweaked as necessary
% If a fraction is included, that fraction is multiplied by the score value

floorCorrect = 100;     % same floor as call
directionCorrect = 70;  % same direction
destinationFracBase = 50;     % fraction of calls towards the same destination/all calls
distanceFracBase = 20;      % 1 - fraction of distance/building height
stopsFracBase = -150;      % fraction of stops/number of floors

%% Sums each car's point total
% does so via for loop from 1 to num_cars


%% determine best car, return as carIndex

% carIndex = randi(config.NUM_CARS); % for testing purposes
end
