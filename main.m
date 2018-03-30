% main.m
% 
% Controls overall functionality of the program.
%
% Authors: Stephen Hannon

clear

%% set constants

pickerAlg = @naivePicker; % which algorithm to test. Either naivePicker or fastPicker.
                          % The @ sign is needed to create a function handle

ITERATIONS = 10; % number of times to run through (seconds)

config.NUM_FLOORS = 14;
config.NUM_CARS = 2;
config.FLOOR_HEIGHT = 1;
config.BOARDING_TIME = 10; % time elevator doors stay open for boarding (s)
config.MAX_VELOCITY = 10; % m/s
config.ACCELERATION = 1.5; % m/s^2

%% set variables

passengers = struct();
cars = struct();

for icar = 1:config.NUM_CARS
    cars(icar).y = randi(config.NUM_FLOORS) * config.FLOOR_HEIGHT;
    cars(icar).velocity = 0;
    cars(icar).doorsOpen = false;
    cars(icar).destinations = []; % Next floors this car wants to travel to.
                                  % First number goes first, and so on.
end

%% run simulation

for it = 1:ITERATIONS
    call = makeRandCall(config.NUM_FLOORS);
    debugT = ['t=', num2str(it), ': '];
    
    if call.fromFloor % fromFloor == 0 if there is no call
        disp([debugT, 'from ', num2str(call.fromFloor), ' to ', num2str(call.toFloor)]);
        
        % The picker can't know the destination, just the direction (up/down).
        % This limitation keeps it more realistic.
        callSanitized.fromFloor = call.fromFloor;
        callSanitized.direction = call.direction;
    
        responder = pickerAlg(it, config, cars, callSanitized);
        cars(responder).destinations = [cars(responder).destinations, call.fromFloor];
        % TODO: let pickerAlg change the destination queue
        
        % add data to passengers struct array
        passengers(end+1).startTime = it;
        passengers(end).fromFloor = call.fromFloor;
        passengers(end).toFloor = call.toFloor;
        passengers(end).responder = responder;
    else
        disp([debugT, 'No call made']);
    end
    
    % TODO: update all elevator positions
    
    
end

%% display statistics

disp('----- END OF RUN -----');
disp(['Iterations: ', num2str(ITERATIONS)]);
disp(['Passengers: ', num2str(length(passengers) - 1)]);
