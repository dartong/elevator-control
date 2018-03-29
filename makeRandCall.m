function call = makeRandCall(NUM_FLOORS)
    % Simulates random traffic for elevator
    
    CALL_FREQUENCY = 0.9; % number of calls per iteration
    call = struct();
    
    if rand() < CALL_FREQUENCY
        call.fromFloor = randi(NUM_FLOORS);
        
        call.toFloor = randi(NUM_FLOORS);
        % make sure toFloor isn't the same as fromFloor
        while call.toFloor == call.fromFloor
            call.toFloor = randi(NUM_FLOORS);
        end
        
        % 1 for heading up, -1 for down
        call.direction = sign(call.toFloor - call.fromFloor);
    else
        call.fromFloor = 0; % no call made
    end
end