# fpga_taxi

This is the little project using FPGA to design a taximeter.
## develop board

## key component:
### 1.AD converter: converte the analog "accelerator" input to digital signal
A on-board potentiometer works as the speed input. It's not an actually accelerator, instead, it directly defines the speed of our taxi.
### 2.Speed2mileage calculator
Calculate the integral of speed, and regulate the actual output so it corresponds to reasonable speed and mileage in real world.
There is a convert formula though. I define the max value of potentiometer as max speed of 250 km/h (or maybe not, but pretty close).
### 3.fare calculator
Pretty simple piecewise function
### 3.display system
display the result of our real speed(Or probably the milage, see more on the code) and fare using on-board LED.
