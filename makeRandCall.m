function call = makeRandCall(NUM_FLOORS)
    % Simulates random traffic for elevator. Only gets called if a call
    % should be made (i.e. main.m takes care of that decision)
    %
    % Authors: Stephen Hannon
    
    call = struct();
    
    call.fromFloor = randi(NUM_FLOORS);

    call.toFloor = randi(NUM_FLOORS);
    
    % make sure toFloor isn't the same as fromFloor
    while call.toFloor == call.fromFloor
        call.toFloor = randi(NUM_FLOORS);
    end

    % 1 for heading up, -1 for down
    call.direction = sign(call.toFloor - call.fromFloor);
end
