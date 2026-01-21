
/**
 * ABSTRACTION
 *      - abstract class: a class that can contain abstract methods
 *          - abstract method: a method without a concrete implementation. 
 *                  the implementation (method body) will be providing by a child class. 
 * 
 */
public abstract class Vehicle implements Drivable {
    
    private String engine;
    
    public Vehicle() {

    }
    public Vehicle(String engine) {
        this.engine = engine;
    }

    public String getEngine() {
        return engine;
    }
    public Void setEngine(String engine) {
        this.engine = engine;
    }

    // abstract method to turn a vehicle on
    public abstract Void start();

    // virtual allows this method to be overridden in child. virtual can also be used at class level to apply it to every method.
    public virtual Void drive() {           // do not need override for interface methods because you HAVE to provide implementation
        System.debug('moving along...');
    }


    public class InnerClass {
        // this is an inner class
    }
}



