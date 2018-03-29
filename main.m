% main.m
% 
% Controls overall functionality of the program.
%
% Authors: Stephen Hannon

clear

%% set constants

%alg = naivePicker; % which algorithm to test. Either naivePicker or fastPicker.

ITERATIONS = 4; % number of times to run through (seconds)
NUM_FLOORS = 14;
NUM_ELEVATORS = 1;
FLOOR_HEIGHT = 1;

%% set variables

passengers(1).fromFloor = 0;
cars = struct();

for icar = 1:NUM_ELEVATORS
    cars(icar).y = randi(NUM_FLOORS) * FLOOR_HEIGHT;
    cars(icar).velocity = 0;
    cars(icar).doorsOpen = false;
    cars(icar).destination = 0; % next floor this car wants to travel to
end

%% run simulation

for it = 1:ITERATIONS
    call = makeRandCall(NUM_FLOORS);
    
    if call.fromFloor
        disp(['from ', num2str(call.fromFloor), ' to ', num2str(call.toFloor)]);
    
        % TODO: call alg to get responding elevator
        
        disp([passengers]);
        passengers(end+1).fromFloor = call.fromFloor;
    else
        disp('No call made');
    end
    
    % TODO: update all elevator positions
end

%% display statistics

disp(['Ran ', num2str(ITERATIONS), ' times']);