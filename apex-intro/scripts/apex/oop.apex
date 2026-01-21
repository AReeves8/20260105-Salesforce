/**
 * PLOYMORPHISM
 *      - covariance - allows a child class to act in place of a parent class
 */
Vehicle kia = new Car('2020', 'Kia', 'Rio');
kia.start();
kia.drive();              // uses the 'Car' implementation of drive()
//kia.openTrunk();        // kia is a 'Vehicle' and openTrunk only exists on 'Car'
System.debug(kia);

List<Vehicle> cars = new List<Vehicle>();
cars.add(kia);
System.debug(cars);

// kia is of type 'Vehicle' so it cannot be used as a 'Car'
// List<Car> cars2 = new List<Car>();
// cars2.add(kia);
// System.debug(cars2);

// casting kia as a 'Car'
Car kia2 = (Car) kia;
System.debug(kia2);
kia2.openTrunk();