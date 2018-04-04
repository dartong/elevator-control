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

config.CALL_FREQUENCY = 0.1; % average number of calls per iteration
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
    cars(icar).y = randi(config.NUM_FLOORS) * config.FLOOR_HEIGHT; % position of TOP of car
    cars(icar).velocity = 0;
    cars(icar).doorsOpen = false;
    cars(icar).destinations = []; % Next floors this car wants to travel to.
                                  % First number goes first, and so on.
end

%% run simulation

for it = 1:ITERATIONS
    disp(['--- t = ', num2str(it), ' ---']);
    
    if it == 1 || rand() < config.CALL_FREQUENCY % always make a call the first time through
        call = makeRandCall(config.NUM_FLOORS);
        
        % The picker can't know the destination, just the direction (up/down).
        % This limitation keeps it more realistic.
        callSanitized.fromFloor = call.fromFloor;
        callSanitized.direction = call.direction;
    
        responder = pickerAlg(it, config, cars, callSanitized);
        cars(responder).destinations = [cars(responder).destinations, call.fromFloor];
        % TODO: let pickerAlg change the destination queue
        
        disp(['new call from ', num2str(call.fromFloor), ' to ',...
            num2str(call.toFloor), ', taken by car ', num2str(responder)]);
        
        % add data to passengers struct array
        passengers(end+1).startTime = it;
        passengers(end).fromFloor = call.fromFloor;
        passengers(end).toFloor = call.toFloor;
        passengers(end).responder = responder;
        passengers(end).pickedUp = false;
        passengers(end).droppedOff = false;
    else
        disp('No call made');
    end
    
    % TODO: update all elevator positions:
    for icar = 1:config.NUM_CARS
        car = cars(icar);
        [cars(icar).y, cars(icar).velocity] = updateY(config, car);
        
        disp(['CAR ', num2str(icar), ':']);
        disp(['  to y = ', num2str(car.y)])
        
        % if car is stopped at a floor that is a destination
        if car.velocity == 0 && ismember(car.y, car.destinations * config.FLOOR_HEIGHT)
            disp(['  arrived at y = ', num2str(car.y)]);
            
            % adjust the relevant passenger struct(s)
            % start at 2 because the first is empty
            for ipass = 2:length(passengers)
                if passengers(ipass).pickedUp % drop passenger off
                    if passengers(ipass).toFloor * config.FLOOR_HEIGHT == car.y
                        passengers(ipass).droppedOff = true;
                        passengers(ipass).dropOffTime = it;
                        passengers(ipass).totalTime = it - passengers(ipass).startTime;
                        
                        disp(['  dropped off passenger ', num2str(ipass-1),...
                            '. Total waiting time: ', num2str(passengers(ipass).totalTime)]);
                        
                        % add new destination to queue and remove current floor
                        toFiltered = cars(icar).destinations ~= passengers(ipass).toFloor;
                        cars(icar).destinations = cars(icar).destinations(toFiltered);
                    end
                else % pick passenger up
                    if passengers(ipass).fromFloor * config.FLOOR_HEIGHT == car.y
                        disp(['  picked up passenger ', num2str(ipass-1)]);
                        
                        passengers(ipass).pickedUp = true;
                        passengers(ipass).pickUpTime = it;
                        passengers(ipass).pickUpCar = icar;
                        
                        % add new destination to queue and remove current floor
                        fromFiltered = cars(icar).destinations ~= passengers(ipass).fromFloor;
                        cars(icar).destinations = [passengers(ipass).toFloor,...
                            cars(icar).destinations(fromFiltered)];
                    end
                end
            end % end for
        end
        
        disp(['  destinations: ', num2str(cars(icar).destinations)]);
    end
    
end

%% display statistics

disp(' ');
disp('----- END OF RUN -----');
disp(['Iterations: ', num2str(ITERATIONS)]);
disp(['Passengers: ', num2str(length(passengers) - 1)]);
