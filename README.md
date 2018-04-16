# elevator-control

Group Project for EG-10102
Contains code for our elevator project. Still very much a work in progress. Run `main.m` in MATLAB.
This program will be split into four core parts - physics simulation, elevator simulation, traffic control, and GUI.
### Contributors
- Connor Lucey
- Stephen Hannon
- Callie Doyle
- Darren Tong

## Elevator Simulation - main.m
Simulates the building. This includes several core features, and allows the functions to work together.
#### Features
- Building Details
- Elevator Specs
- Calls functions to simulate physics, elevator choosing, and traffic control

## Traffic Control - naivePicker.m
Chooses which elevator will be called to respond to a call.
Uses a 'for' loop to sum up a score which determines the best elevator.
#### Scoring Factors
- 'floorCorrect': same floor as call
- 'directionCorrect': same direction as where call is to
- 'directionFracBase': fraction of (calls towards the same direction/all calls)
- 'distanceFracBase': 1 - fraction of (distance/building height)
- 'stopsFracbase': fraction of (stops/number of floors)


## Physics Simulation
Simulates features such as acceleration, deceleration, etc. Essentially, it simulates general movement of the elevator. 
#### Simulated factors
- to be completed

## GUI
Provides a visual method for the user to interact with the elevator, see where it is, and change certain variables.
Currrently a work in progress. 


Naturally, it will be coded in the *best* language - MATLAB...
