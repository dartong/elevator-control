# Simulation of Elevator Control Algorithms

Group Project for EG 10102

Contains code for our elevator project. Run `elevatorTool.m` in MATLAB to use the GUI, or run `main.m` with default parameter `[]` (an empty vector).

This program will be split into four core parts - physics simulation, elevator simulation, traffic control, and GUI.
### Contributors
- Connor Lucey
- Stephen Hannon
- Callie Doyle
- Darren Tong

## Elevator Simulation - `main.m`
Simulates the building. This includes several core features, and allows the functions to work together.
#### Features
- Building Details
- Elevator Specs
- Calls functions to simulate physics, elevator choosing, and traffic control

## Traffic Control
Chooses which elevator will be called to respond to a call.

`naivePicker.m` is simpler algorithm that just picks whatever car is closest to the call.

`goodPicker.m` uses a `for` loop to sum up a score which determines the best elevator.
#### Scoring Factors
- `floorCorrect`: same floor as call
- `directionCorrect`: same direction as where call is to
- `directionFracBase`: fraction of (calls towards the same direction/all calls)
- `distanceFracBase`: 1 &minus; fraction of (distance/building height)
- `stopsFracbase`: fraction of (stops/number of floors)


## Physics Simulation - `updateY.m`
Simulates features such as acceleration, deceleration, etc. Essentially, it simulates general movement of the elevator.

## GUI
Provides a visual method for the user to interact with the elevator, see where it is, and change certain variables. Here are screenshots of the GUI in action after running 50,000 simulations.

### `goodPicker.m`
![Simulation of goodPicker.m](https://cdn.rawgit.com/player13245/elevator-control/2344e45a/trial-50000-goodPicker.png)

### `naivePicker.m`
![Simulation of naivePicker.m](https://cdn.rawgit.com/player13245/elevator-control/2344e45a/trial-50000-naivePicker.png)
