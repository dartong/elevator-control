function carIndex = naivePicker(t, config, cars, call)
% Parameters:
%  t (integer): the current elapsed time (s)
%  config (struct): contains configuration constants defined in main.m
%  cars (struct array): data for each of the elevator cars
%  call (struct): data about this call
%
% Return:
%  carIndex (integer between 1 and NUM_CARS) that will respond to this call
% 
% Authors: 
    
    carIndex = randi(config.NUM_CARS); % for testing purposes
end