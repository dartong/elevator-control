% main.m
% 
% Controls overall functionality of the program.
%
% Authors: Stephen Hannon

clear, clf;

%% set constants

PLOTTING = true; % if true, display a plot of the car positions each iteration

% which algorithm to test. Either naivePicker or goodPicker.
% The @ sign is needed to create a function handle
pickerAlg = @goodPicker; 

ITERATIONS = 10; % number of times to run through (seconds)

config.DELTA_T = 0.5; % seconds between updates (smaller means smoother but slower)
config.CALL_FREQUENCY = 0.2; % average number of calls per second (between 0 and 1)
config.NUM_FLOORS = 14;
config.NUM_CARS = 4;
config.FLOOR_HEIGHT = 3; % m
config.BOARDING_TIME = 1; % time elevator doors stay open for boarding (s)
config.MAX_VELOCITY = 10; % m/s
config.ACCELERATION = 1.5; % m/s^2
config.PLOT_SPEED = 5; % times faster to do the simulation (bigger is faster)

%% set variables

passengers = struct();
cars = struct();

heights = zeros(1, config.NUM_CARS);

numDroppedOff = 0; % number of passengers successfully dropped off
numPickedUp = 0; % passengers currently in an elevator
numWaiting = 0; % passengers waiting for an elevator to arrive

for icar = 1:config.NUM_CARS
    cars(icar).y = randi(config.NUM_FLOORS) * config.FLOOR_HEIGHT; % position of TOP of car
    cars(icar).velocity = 0;
    cars(icar).doorsOpen = false;
    cars(icar).destinations = []; % Next floors this car wants to travel to.
                                  % First number goes first, and so on.
    cars(icar).timeRemaining = 0; % how long to wait before it can leave
    
    msg(['Car ', num2str(icar), ' at y = ', num2str(cars(icar).y)]);
end

%% run simulation

for it = 1:config.DELTA_T:ITERATIONS
    % clear the figure so we can put down the next positions
    if PLOTTING && it ~= 1
        pause(config.DELTA_T / config.PLOT_SPEED);
        clf; % clf(ax);
    end
    
    msg(['--- t = ', num2str(it), ' ---']);
    
    % Randomly decide if we should make a call, based on CALL_FREQUENCY.
    % Always make a call the first time through
    if it == 1 || rand() < config.CALL_FREQUENCY * config.DELTA_T
        call = makeRandCall(config.NUM_FLOORS);
        numWaiting = numWaiting + 1;
        
        % The picker can't know the destination, just the direction (up/down).
        % This limitation keeps it more realistic.
        callSanitized.fromFloor = call.fromFloor;
        callSanitized.direction = call.direction;
    
        [responder, scores] = pickerAlg(it, config, cars, callSanitized);
        cars(responder).destinations = [cars(responder).destinations, call.fromFloor];
        % TODO: let pickerAlg change the destination queue
        
        msg(['new call from ', num2str(call.fromFloor*config.FLOOR_HEIGHT), ' to ',...
            num2str(call.toFloor*config.FLOOR_HEIGHT), ', taken by car ', num2str(responder)]);
        msg(['Car scores: ', num2str(scores)]);
        
        % add data to passengers struct array
        passengers(end+1).startTime = it;
        passengers(end).fromFloor = call.fromFloor;
        passengers(end).toFloor = call.toFloor;
        passengers(end).responder = responder;
        passengers(end).pickedUp = false;
        passengers(end).droppedOff = false;
    else
        msg('No call made');
    end
    
    % --- update all elevator positions ---
    for icar = 1:config.NUM_CARS
        car = cars(icar);
        msg(['CAR ', num2str(icar), ':']);
        
        % If the car still has to wait, don't call updateY. Instead,
        % decrement the time the car has to remain waiting
        if cars(icar).timeRemaining > 0
            msg(['  Waiting for ', num2str(cars(icar).timeRemaining), ' more second(s)']);
            cars(icar).timeRemaining = cars(icar).timeRemaining - config.DELTA_T;
        elseif ~isempty(cars(icar).destinations)
            deltaY = cars(icar).destinations(1)*config.FLOOR_HEIGHT - cars(icar).y;
            if deltaY ~= 0
                if cars(icar).velocity == 0
                    cars(icar).tLeave = it;
                    cars(icar).deltaYLeave = deltaY;
                end
                [cars(icar).y, cars(icar).velocity] = updateY(it, config, cars(icar));
            end
        end
        msg(['  at y = ', num2str(cars(icar).y)]);
        
        
        % if car is stopped at a floor that is a destination
        if cars(icar).velocity == 0 &&...
                ismember(cars(icar).y, cars(icar).destinations * config.FLOOR_HEIGHT)
            msg(['  arrived at y = ', num2str(cars(icar).y)]);
            
            % adjust the relevant passenger struct(s)
            % start at 2 because the first is empty
            for ipass = 2:length(passengers)
                if passengers(ipass).pickedUp % drop passenger off
                    if passengers(ipass).toFloor * config.FLOOR_HEIGHT == cars(icar).y && ...
                            passengers(ipass).responder == icar
                        numDroppedOff = numDroppedOff + 1;
                        numPickedUp = numPickedUp - 1;
                        %disp(numPickedUp);
                        
                        passengers(ipass).droppedOff = true;
                        passengers(ipass).dropOffTime = it;
                        passengers(ipass).totalTime = it - passengers(ipass).startTime;
                        
                        msg(['  dropped off passenger ', num2str(ipass-1),...
                            '. Total waiting time: ', num2str(passengers(ipass).totalTime)]);
                        
                        % add new destination to queue and remove current floor
                        toFiltered = cars(icar).destinations ~= passengers(ipass).toFloor;
                        cars(icar).destinations = cars(icar).destinations(toFiltered);
                        
                        cars(icar).timeRemaining = config.BOARDING_TIME;
                    end
                else % pick passenger up
                    if passengers(ipass).fromFloor * config.FLOOR_HEIGHT == cars(icar).y
                        numPickedUp = numPickedUp + 1;
                        numWaiting = numWaiting - 1;
                        %disp(numPickedUp);
                        
                        passengers(ipass).pickedUp = true;
                        passengers(ipass).pickUpTime = it;
                        passengers(ipass).pickUpCar = icar;
                        
                        msg(['  picked up passenger ', num2str(ipass-1)]);
                        msg([numPickedUp, passengers(ipass).pickedUp]);
                        
                        % add new destination to queue and remove current floor
                        fromFiltered = cars(icar).destinations ~= passengers(ipass).fromFloor;
                        cars(icar).destinations = [passengers(ipass).toFloor,...
                            cars(icar).destinations(fromFiltered)];
                        
                        cars(icar).timeRemaining = config.BOARDING_TIME;
                    end
                end
            end % end for
        end
        
        msg(['  destinations: ', num2str(cars(icar).destinations * config.FLOOR_HEIGHT)]);
        
        if PLOTTING
            width = 0.4;
            pos = [icar - width/2, cars(icar).y - config.FLOOR_HEIGHT, width, config.FLOOR_HEIGHT];
            rectangle('Position', pos, 'FaceColor', 'blue');
        end
        heights(icar) = cars(icar).y;
    end
    

    if PLOTTING
        ax = gca; % get curent axes
        
        yyaxis(ax, 'right');
        % on the right y-axis, display floor numbers
        ylim(ax, [0.5, config.NUM_FLOORS + 0.5]);
        hold on;
        
        for ipass = 2:length(passengers)
            pass = passengers(ipass);
            if ~pass.pickedUp
                if pass.toFloor - pass.fromFloor > 0
                    % call is heading up
                    marker = '^';
                else
                    marker = 'v';
                end
                
                plot(pass.responder, pass.fromFloor,...
                    'Marker', marker,...
                    'MarkerSize', 10,...
                    'MarkerFaceColor', 'black',...
                    'MarkerEdgeColor', 'none'...
                    );
            end
        end
        
        hold off;
        ax.YTick = 1:config.NUM_FLOORS;
        ylabel(ax, 'Floor number');
        
        yyaxis(ax, 'left');
        axis([0.5, config.NUM_CARS+0.5, 0, config.FLOOR_HEIGHT*config.NUM_FLOORS]);
        ylabel('Height (m)');
        xlabel('Elevator car number');
        ax.YTick = 0 : config.FLOOR_HEIGHT : config.FLOOR_HEIGHT*config.NUM_FLOORS;
        ax.XTick = 1:config.NUM_CARS; % force plot to display only integers
        grid(ax, 'on'); % display only y (horizontal) gridlines
        
        drawnow;
    end
end

%% display statistics

msg(' ');
disp('----- END OF RUN -----');
disp(['Iterations: ', num2str(ITERATIONS)]);
disp(['Total passengers: ', num2str(length(passengers) - 1)]);
disp(['  Passengers waiting for car: ', num2str(numWaiting)]);
disp(['  Passengers riding elevator: ', num2str(numPickedUp)]);
disp(['  Passengers dropped off:     ', num2str(numDroppedOff)]);

% displays detailed debug messages to the command window. This
% significantly slows running, so set to 0 for more than a few dozen
% iterations
function msg(message)
    if 1
        disp(message);
    end
end
