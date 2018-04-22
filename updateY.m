function [newY, newV] = updateY(t, config, car)
% Parameters:
%  t (number): the current elapsed time (s)
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

if ~isempty(car.destinations) % car only needs to move if it has destinations
    deltaY = car.destinations(1)*config.FLOOR_HEIGHT - car.y;
    deltaYStop = car.velocity^2 / (2*config.ACCELERATION); % stopping distance
    deltaT = t - car.tLeave + config.DELTA_T;
    vMaxMag = sqrt(config.ACCELERATION * abs(car.deltaYLeave));
    
    if deltaT < vMaxMag / config.ACCELERATION
        newV = config.ACCELERATION * deltaT;
    else
        newV = 2 * vMaxMag - config.ACCELERATION * deltaT;
    end
    
    if deltaY < 0
        newV = -newV;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%
    
    % derived from y = y_0 + v_0*t + 1/2 a t^2
    newY = (car.y) + (car.velocity * config.DELTA_T) + (0.5 * (newV-car.velocity) * config.DELTA_T);
    
    % if we can stop at the destination floor, do so.
    % If we are decelerating, and
    % the acceleration required to bring the car to a stop within this
    % timeframe is greater than the minimum acceleration to stop at the
    % correct destination
    if car.velocity ~= 0 && deltaT > vMaxMag / config.ACCELERATION && ...
            config.ACCELERATION > abs(car.velocity) / config.DELTA_T > car.velocity^2 / (2*abs(deltaY))
            %abs(car.velocity) / config.DELTA_T <= config.ACCELERATION && ...
            %abs(deltaY) <= abs(deltaYStop)
        disp('  Autostopping...');
        newV = 0;
        newY = car.destinations(1) * config.FLOOR_HEIGHT;
    end
    
    disp(['  dy = ', num2str(deltaY), ', v = ', num2str(newV),...
        ...', t_half = ', num2str(vMaxMag / config.ACCELERATION),...
        ', dy_stop = ', num2str(deltaYStop),...
        ', a_min = ', num2str(car.velocity^2 / (2 * abs(deltaY)))]);
else
    newV = 0;
end
