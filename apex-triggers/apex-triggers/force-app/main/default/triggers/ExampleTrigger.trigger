/**
 * TRIGGERS
 *      run in response to some DML event
 *          apart of our save order of execution
 *              before triggers happen right after before flows
 *              after triggers happen right after initial save
 * 
 *      implicitly run in batches!
 *          - batch size: 200 records!
 *              ex: Trigger.new will never have more than 200 records
 */
trigger ExampleTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    /**
     * Design Pattern:
     *  ONE TRIGGER PER OBJECT
     * 
     * Design Choice:
     *  some people will ALWAYS put all 7 events in their trigger definitions. 
     *  some people will only put in the ones they're using. 
     */



    /**
     * TRIGGER CONTEXT VARIABLES
     *      give info about the currently running transaction
     *          (the records being manipulated, the dml event that is occuring)
     * 
     * 
     *      to learn about the DML event: 
     *          boolean variables: Trigger.isInsert, Trigger.isBefore, Trigger.isAfter, etc.
     *          static enum Trigger.operationType: BEFORE_INSERT, BEFORE_UPDATE, AFTER_DELETE, etc.
     * 
     * 
     *      to get access to records:
     *          can get a list or map (id as key, and sObject as value)
     *              Trigger.new - the state of the records, after the DML event occurred as a List
     *                  - before insert, before update, after insert, after update after undelete 
     *              Trigger.newMap - the state of the records, after the DML event occurred as a Map
     *                  - before update, after update, after insert, after undelete
     *              Trigger.old - the state of the records, before the DML event occurred as a List
     *                  - before update, before delete, after update, after delete
     *              Trigger.oldMap - the state of the records, before the DML event occurred as a Map
     *                  - before update, before delete, after update, after delete
     */
    switch on Trigger.operationType {
        when BEFORE_INSERT, BEFORE_UPDATE {
            // sometimes, you might have the same code you want to run during inserts AND updates
            for(Account acc : Trigger.new) {    

                // give an error in before insert because oldMap is null
                Account oldAcc = Trigger.oldMap?.get(acc.Id);    // use save navigation operator (?.) to check if oldMap is null

                if(oldAcc != null) {
                    // check if the account was NOT hot before and IS hot now
                    if(oldAcc.Rating != 'Hot' && acc.Rating == 'Hot') {
                        // send an email alert to the account owner to let them know their account has been updated to Hot
                    }
                }
                else if(acc.Rating == 'Hot') {
                    // send an email alert to the account owner to let them know their account has been updated to Hot
                }
            }
        }
        when BEFORE_DELETE {
            
        }
        when AFTER_INSERT {

        }
        when AFTER_UPDATE {
            
        }
        when AFTER_DELETE {
            
        }
        when AFTER_UNDELETE {
            
        }
    }

}