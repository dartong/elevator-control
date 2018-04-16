function [newY, newV] = updateY(config, car)
% Parameters:
%  config (struct): contains configuration constants defined in main.m,
%  including MAX_VELOCITY and ACCELERATION
%  car (struct): contains data for the current car to be processed
%
% Return:
%  newY (number between 1 and NUM_FLOORS * FLOOR_HEIGHT)
%  newV (number): new velocity of car (negative is down)
% 
% Authors: Connor Lucey, Stephen Hannon

newY = car.y; %this will be overwritten if velocity is changed

% Overview:
    % FIRST IF: Decides whether the car needs to move
    % SECOND IF: Decides which direction (up/down) the car needs to move)
    % THIRD IF: Decides whether the car must speed up or slow down
        % Uses the equation (v_f^2) = 2*a*x + (v_0^2)
        % If v_f=0, rearranged and with a=1.5, v_0 = sqrt(3x)
            % x is car.destination-car.y or car.y-car.destination
            % depending on direction
    % FOURTH IF: Makes sure than abs(v) <= 10 at all times.
% Notes: Using words instead of numbers makes this really hard to
% understand.

if ~isempty(car.destinations)
    deltaY = car.destinations(1)*config.FLOOR_HEIGHT - car.y;
    deltaYStop = car.velocity^2 / (2*config.ACCELERATION); % stopping distance
    
    if deltaY > 0       % HEAD UP
        newV = car.velocity + config.ACCELERATION * config.DELTA_T;

        % make sure we're not above max velocity
        if newV > config.MAX_VELOCITY
            newV = config.MAX_VELOCITY;
        end
            
        if newV < sqrt(config.ACCELERATION * deltaY)  % SPEED UP, HEADING UP
        % if deltaY > deltaYStop % stopping distance
            disp('Heading up, speeding up');
            newY = car.y + newV * config.DELTA_T;
        else                            % SLOW DOWN, HEADING UP
            newV = sqrt(config.ACCELERATION * deltaY); %car.velocity - config.ACCELERATION * config.DELTA_T;
            disp('Heading up');
            newY = car.y + newV * config.DELTA_T;
        end

    elseif deltaY < 0  % HEAD DOWN
        newV = car.velocity - config.ACCELERATION * config.DELTA_T;

        % make sure we're not above max velocity
        if newV < -config.MAX_VELOCITY
            newV = -config.MAX_VELOCITY;
        end
            
        if newV > -sqrt(config.ACCELERATION * -deltaY) % SPEED UP, HEADING DOWN
        % if deltaY < -deltaYStop
            disp('Heading down, speeding up');
            newY = car.y + newV * config.DELTA_T;
        else                            % SLOW DOWN, HEADING UP
            disp('Heading down');
            % newV = car.velocity + config.ACCELERATION * config.DELTA_T;
            newV = -sqrt(config.ACCELERATION * -deltaY);
            newY = car.y + newV * config.DELTA_T;
        end

    else % stop
        newV = 0;
    end
    
    % if we can stop at the destination floor, do so
    if car.velocity > 0 && car.velocity / config.DELTA_T <= config.ACCELERATION && deltaY <= deltaYStop
        newV = 0;
        newY = car.destinations(1) * config.FLOOR_HEIGHT;
    end
    
    disp(['  deltaY = ', num2str(deltaY), ', v = ', num2str(newV)]);
else
    newV = 0;
end
