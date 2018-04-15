function [newY, newV] = updateY(config, car)
% Parameters:
%  config (struct): contains configuration constants defined in main.m,
%  including MAX_VELOCITY and ACCELERATION
%  car (struct): contains data for the current car to be processed
%
% Return:
%  newY (number between 1 and NUM_FLOORS)
%  newV (number): new velocity of car (negative is down)
% 
% Authors: idiut

newY = car.y;

% Overview:
    % FIRST IF: Decides whether the car needs to move
    % SECOND IF: Decides which direction (up/down) the car needs to move)
    % THIRD IF: Decides whether the car must speed up or slow down
        % Uses the equation (v_f^2) = 2*a*x + (v_0^2)
        % If v_f=0, rearranged and with a=1.5, v_0 = sqrt(3x)
            % x is car.destination-car.y or car.y-car.destination
            % depending on direction
        % I really, really hope this part works.
    % FOURTH IF: Makes sure than abs(v) <= 10 at all times.
        % config.MAX_VELOCITY-config.ACCELERATION = 8.5 as of now
% Notes: Using words instead of numbers makes this really hard to
% understand. 
% This was written as car.velocity gets the value of newV after each run
% through. If that's not the case...well...dang it.

if ~isempty(car.destinations)
    deltaY = car.destinations(1)*config.FLOOR_HEIGHT - car.y;

    if car.destinations(1) > car.y       % HEAD UP
        if car.velocity < sqrt(2*config.ACCELERATION * deltaY)  % SPEED UP, HEADING UP
            newV = car.velocity + config.ACCELERATION;
            
            % make sure we're not above max velocity
            if car.velocity > config.MAX_VELOCITY
                newV = config.MAX_VELOCITY;
            end
            newY = car.y + newV;
        else                            % SLOW DOWN, HEADING UP
            newV = car.velocity - config.ACCELERATION;
            newY = car.y + newV;
        end

    elseif car.destinations(1) < car.y  % HEAD DOWN
        if car.velocity > sqrt(2*config.ACCELERATION * -deltaY) % SPEED UP, HEADING DOWN
            newV = car.velocity - config.ACCELERATION;
            
            % make sure we're not above max velocity
            if car.velocity < -config.MAX_VELOCITY
                newV = -config.MAX_VELOCITY;
            end
            newY = car.y + newV;
        else                            % SLOW DOWN, HEADING UP
            newV = car.velocity + config.ACCELERATION;
            newY = car.y + newV;
        end

    else % stop
        newV = 0;
    end
else
    newV = 0;
end
