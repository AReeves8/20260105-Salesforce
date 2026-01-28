trigger InventoryTrigger on Inventory__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    /**
     * DO NOT PUT BUSINESS LOGIC INSIDE OF TRIGGERS
     * 
     * MOVE THEM TO HANDLER CLASSES
     */

    switch on Trigger.operationType {
        when BEFORE_INSERT {

        }
        when BEFORE_UPDATE {
            
        }
        when BEFORE_DELETE {
            
        }
        when AFTER_INSERT {
            // check if warehouse can store all of the inventory
            InventoryTriggerHandler.CheckWarhouseCapacity(Trigger.new, Trigger.oldMap);

            // update product capacity
        }
        when AFTER_UPDATE {
            // check if warehouse can store all of the inventory
            InventoryTriggerHandler.CheckWarhouseCapacity(Trigger.new, Trigger.oldMap);

            // update product capacity
        }
        when AFTER_DELETE {
            
        }
        when AFTER_UNDELETE {
            
        }
    }
}