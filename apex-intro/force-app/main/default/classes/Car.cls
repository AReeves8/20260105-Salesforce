/**
 * .cls is a class file. need this plus the associated metadata file to deploy to org. 
 * 
 * 
 * SHARING
 *      - references RECORD access settings
 *          - the class implicitly checks if it should respect a user's record access when accessing Salesforce data
 * 
 *      - with sharing: respects record access settings
 *      - without sharing: ignore record access settings
 *      - inherited sharing: use the with/without of the class that invokes this class
 *      - [nothing] aka default sharing: same as inherited except for the following:
 *          - called from EA, then respects entire sharing model (object, record, and field)
 *          - tests, trigger, webservice - ignore record access settings
 * 
 */
/**
 * INHERITANCE
 *      - passing related state and bahvior down to a child class
 *      - extends keyword for classes
 *          - only works on classes decalred as abstract or virtual
 *          - can only extend one class
 *      - implements keyword for interfaces
 *          - can implement multiple interfaces
 */
public inherited sharing class Car extends Vehicle {        
    
    
    /**
     * ENCAPSULATION
     *      - wrapping up related state and behavior into a single class
     *      - control how that state and behavior is modified and accessed
     *          - access modifiers:
     *              - private: only this class can access
     *              - protected: only this class, an inner class, or a child class can access
     *              - public: everyone in the SAME namespace can access
     *              - global: everyone everywhere can access
     */
    private String year;
    private String make;
    private String model;

    /**
     * FINAL AND STATIC
     *      - final:
     *          - once the value is set, it cannot be changed
     *          - the value must be set at declaration or in ALL constructors
     *      - static: 
     *          - once it is loaded into memory, it stays loaded in memory
     *              - if the same variable is referenced in the same transaction, the value will be maintained
     *          - allows public methods/variable to be accessed without creating an object first
     *      
     *      - put these two together, you get a constant. 
     */
    private final static Integer NUM_AXLES = 2;

    /**
     * POLYMORPHISM
     *      overloading
     *          - constructor overloading - where you have multiple constructors with different params
     *          - method overloading - multiple methods with the same signature but different params
     */

    // no arg constructor (if you don't define any constructos in your class, Apex will give you a no-arg constructor)
    public Car() {
    
    }

    // parameterized constructor
    public Car(String year, String make, String model) {
        
        /**
         * SUPER() AND THIS()
         *      - used to call other constructors (constructor chaining)  
         *      - both of these MUST be the first line of the constructor
         * 
         *      - this() - calls another constructor in the same class
         *      - super() - calls a constructor in a parent class
         *          - it will be added by default IF this() isn't used. 
         * 
         * 
         *      every class inherits from a default SObject class that contains default state and behavior, like a toString()
         */ 
        super('v6 engine');
        
        this.year = year;
        this.make = make;
        this.model = model;
    }

    // GETTERS AND SETTERS
    public String getYear() {
        return year;
    }
    public Void setYear(String year) {

        // cars must be made in the 1900's or 2000's
        if (year.startsWith('19') || year.startsWith('20')) {
            this.year = year;
        }
    }

    public String getMake() {
        return make;
    }
    public Void setMake(String make) {
        this.make = make;
    }

    public String getModel() {
        return model;
    }
    public Void setModel(String model) {
        this.model = model;
    }

    public Void openTrunk() {
        System.debug('..pop..');
    }

    
    /**
     * POLYMORPHISM
     *      - method overriding: changing implementation of a method from a parent class in a child class
     *          - have to override keyword
     * 
     */
    public override Void drive() {
        System.debug('vroom vroom');
    }

    // adding implementation for abstract method in parent
    public override Void start() {
        System.debug('Turn the key to start the ' + this.year + ' ' + this.make + ' ' + this.model + '!');
    }

    

}