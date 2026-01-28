public without sharing class InventoryTriggerHandler {
    

    public static void CheckWarhouseCapacity(List<Inventory__c> inventoryNewList, Map<Id,Inventory__c> inventoryoldMap) {

        // using custom metadata type to check if checking warehouse capacity feature is enabled or not
        Feature_Flag__mdt checkWarehouseCapacity = Feature_Flag__mdt.getInstance('Check_Warehouse_Capacity');
        if(checkWarehouseCapacity.Is_Enabled__c) {

            // find all the warehouses associated to these inventories
            Set<Id> warehouseIds = new Set<Id>();
            for(Inventory__c inv : inventoryNewList) {
                if(inv.Warehouse__c != null) {
                    warehouseIds.add(inv.Warehouse__c);
                }
            }
            List<Warehouse__c> warehouses = [SELECT Id, Max_Capacity__c FROM Warehouse__c WHERE Id IN :warehouseIds];

            // find total space of each inventory going to a specific warehouse
            Map<Id, Double> warehouseTotals = new Map<Id, Double>();
            for(AggregateResult result : [SELECT Warehouse__c, SUM(Required_Capacity__c) reqCapacity
                                            FROM Inventory__c 
                                            WHERE Warehouse__c IN :warehouseIds
                                            GROUP BY Warehouse__c]){
                
                Id whId = (Id) result.get('Warehouse__c');
                Double requiredCapacity = (Double) result.get('reqCapacity');
                System.debug('Warehouse ' + whId + ' would need cpacity of ' + requiredCapacity);
                warehouseTotals.put(whId, requiredCapacity);                               
            }

            // check warehouse capacity against new total required capacity
            Set<Id> warehousesWithErrors = new Set<Id>();
            for(Warehouse__c warehouse : warehouses) {

                System.debug('Warehouse ' + warehouse.Id + ' has max capacity of ' + warehouse.Max_Capacity__c);

                if(warehouse.Max_Capacity__c < warehouseTotals.get(warehouse.Id)) {
                    // no space in warehouse, mark it as having an error
                    warehousesWithErrors.add(warehouse.Id);
                }
            }

            // for any inventories that cannot be saved, throw an error
            for(Inventory__c inv : inventoryNewList) {
                if(warehousesWithErrors.contains(inv.Warehouse__c)) {
                    // prevent inventory from being saved 
                    inv.addError(Label.Warehouse_Capacity_Error);   // using Custom Label from org

                    // addError displays a error message on the UI AND stops the DML event from occurring. 

                }
            }  
        } 

    }

    // TRY TO DO THIS YOURSELF FOR EXTRA PRACTICE
    public static void UpdateProductQuantity(List<Inventory__c> inventoryNewList, Map<Id,Inventory__c> inventoryoldMap) {
        // count the total number of products being stored across all warehoues and update product object with that count
    }
}