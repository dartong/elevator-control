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
    
    % simplified for testing purposes (not anymore, really)
    % TODO: wait while doors open (main program will take of this)
    
    % Overview:
        % FIRST IF: Decides whether the car needs to move
        % SECOND IF: Decides which direction (up/down) the car needs to move)
        % THIRD IF: Decides whether the car must speed up or slow down
            % Uses the equation (Vf^2) = 2*a*x + (Vo^2)
            % If Vf=0, rearranged and with a=1.5, Vo = sqrt(3x)
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
        if car.destinations(1) > car.y       % HEAD UP
            if car.velocity < sqrt(3*(car.destination-car.y))  % SPEED UP, HEADING UP
                if car.velocity < config.MAX_VELOCITY-config.ACCELERATION       % MAKE SURE v <= 10
                    % So if v<8.5, it will accelerate normally
                    newV = car.velocity + config.ACCELERATION*t;
                elseif car.velocity <= config.MAX_VELOCITY && car.velocity...
                        >= config.MAX_VELOCITY-config.ACCELERATION
                    % If 8.5<=v<=10 this keeps it from going over 10
                    car.velocity = config.MAX_VELOCITY;
                end
                newY = car.y + newV*t;
            else                            % SLOW DOWN, HEADING UP
                newV = car.velocity - config.ACCELERATION*t;
                newY = car.y + newV*t;
            end
            
        elseif car.destinations(1) < car.y  % HEAD DOWN
            if car.velocity > sqrt(3*(car.y-car.destination)) % SPEED UP, HEADING DOWN
                if car.velocity > (-1*config.MAX_VELOCITY) + config.ACCELERATION    % MAKE SURE v >= -10
                    newV = car.velocity - config.ACCELERATION*t;
                elseif car.velocity >= (-1*config.MAX_VELOCITY) && car.velocity...
                        <= (-1*config.MAX_VELOCITY + config.ACCELERATION)
                    car.velocity = -1*config.MAX_VELOCITY;
                end
                newY = car.y + newV*t;
            else                            % SLOW DOWN, HEADING UP
                newV = car.velocity + config.ACCELERATION*t;
                newY = car.y + newV*t;
            end
            
        else % stop
            newV = 0;
        end
    else
        newV = 0;
    end
end