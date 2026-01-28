/**
 * ALL CODE MUST BE TESTED TO BE DEPLOYED TO A PRODUCTION ENVIRONMENT
 *      - minimum 75% code coverage requirement to allow Apex code to be deployed to prod
 *          - 75% of all lines being deployed. 
 *              - technically not every Apex Class has to have coverage
 *                  - EXCEPTION: Apex Triggers. EVERY SINGLE APEX TRIGGER HAS TO HAVE AT LEAST ONE LINE OF COVERAGE 
 *      - AND the code must compile
 */

@isTest
private class OrderProcecessor_Test {
   
    // test classes and methods must be private
    // methods need to be static and return void and take in no arguments

    @isTest
    private static void processTest() {
        String result = OrderProcessor.process();
        
        // assertion methods from system class are the old way
        //System.Assert(); 

        // the new way!
        Assert.areEqual('Order is processed', result, 'Results did not match in processor test.');  // includes message to print of failure
    }

}