function [carIndex, sums] = naivePicker(t, config, cars, call)
%% Create scoring system, set up basic parameters

num_cars = config.NUM_CARS; 
sums = zeros(1,num_cars);   
distanceFracBase = 20;  


%% Sum totals
distance=1000000000
for iCar = 1:num_cars
    %% simplify structs
    % car data
    currentPos = cars(iCar).y;
    % call data
    fromY = call.fromFloor * config.FLOOR_HEIGHT; 
    % distanceFracBase
    difference = abs(currentPos - fromY);
    %sums(iCar) = sums(iCar) + distanceFracBase*(1 - (difference/config.NUM_FLOORS));
    if difference < distance;
        distance = difference;
        carIndex=iCar;
    end
    
end

%% determine best car,
%[~, idx] = max(sums);
%carIndex = idx;
end
