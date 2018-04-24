function [carIndex, sums] = naivePicker(t, config, cars, call)
%% Create scoring system, set up basic parameters

num_cars = config.NUM_CARS; 
sums = zeros(1,num_cars);   
distanceFracBase = 20;  


%% Sum totals
for iCar = 1:num_cars
    %% simplify structs
    % car data
    currentPos = cars(iCar).y;
    destinations = cars(iCar).destinations;
    velocity = cars(iCar).velocity;
    [~,stops] = size(destinations);  % gets number of stops
    
    % call data
    fromY = call.fromFloor * config.FLOOR_HEIGHT; % we're comparing height, not floor number
    
    %% Scoring
    % distanceFracBase
    difference = abs(currentPos - fromY);
    sums(iCar) = sums(iCar) + distanceFracBase*(1 - (difference/config.NUM_FLOORS));

end

%% determine best car,
[~, idx] = max(sums);
carIndex = idx;
end
