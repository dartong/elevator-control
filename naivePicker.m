function [carIndex, sums] = naivePicker(t, config, cars, call)
% Parameters:
%  t (number): the current elapsed time (s)
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
% Authors: Callie Doyle

sums = []; % this algorithm doesn't use sums, but we have to return something

%% Find car that is closest to the call
distance = inf; % initially set to infinity so everything will be smaller

for iCar = 1:config.NUM_CARS
    fromY = call.fromFloor * config.FLOOR_HEIGHT; 
    
    difference = abs(cars(iCar).y - fromY);
    
    if difference < distance
        distance = difference;
        carIndex = iCar;
    end
    
end

end
