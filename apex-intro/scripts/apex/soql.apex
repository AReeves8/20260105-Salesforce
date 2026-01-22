// Square Bracket Notation
List<Account> accounts = [SELECT Id, Name, Industry FROM Account];
System.debug(accounts);

// can access a retreived property with dot notation
for(Account acc : accounts) {
    if(acc.Industry == null) {
        acc.Industry = 'Other';
    }
    System.debug(acc.Industry);      
}
System.debug('RESULT:');
for(Account acc : accounts) {
    System.debug(acc.Industry);      // changes on an individual element WILL affect the list as a whole
}

// throws an exception because the data was not retrieved
//System.debug('Annual Revenue ' + accounts[0].AnnualRevenue);


/**
 * NULL VS EMPTY
 *      - fields/properties not retrieved in a SOQL query will be EMPTY
 *          - trying to use something that is empty will throw errors
 *          - above causes SObjectException
 */

// an SObject cannot be empty, below causes QueryException 
// (if this returned multiple records, it would also cause QueryException)
//Account acc = [SELECT Name FROM Account WHERE Name = 'Austin Is Cool!'];    // BAD

// Lists CAN be empty, so ALWAYS save SOQL queries to Lists
List<Account> accounts = [SELECT Name FROM Account WHERE Name = 'Austin Is Cool!'];  // GOOD
System.debug(accounts.size());


// Nullish Coalescing Operator (??) - assigns default value if first option is null/empty
Account acc = [SELECT Name FROM Account WHERE Name = 'Austin Is Cool!'] ?? new Account(Name = 'Austin Is Awesome!');
System.debug(acc);


List<Account> accounts = [SELECT Name, Industry FROM Account];
System.debug(accounts[0].Id);               // Id is ALWAYS retrieved, even if you don't ask for it
accounts[0].AnnualRevenue = 1000000;        // you can still set new values on fields that weren't retreived
System.debug(accounts[0].AnnualRevenue);    // then the fields will no longer be empty


// Aggregated Data
Integer numWarehouses = [SELECT COUNT()    
                            FROM Warehouse__c];
System.debug(numWarehouses);


List<AggregateResult> warehouseResults = [SELECT AVG(Max_Capacity__c)    
                                    FROM Warehouse__c];


List<AggregateResult> accountResults = [SELECT Industry, COUNT(Id)
                                        FROM Account
                                        GROUP BY Industry
                                        HAVING COUNT(Id) >= 3];
Integer i = 1;
for(AggregateResult result : accountResults) {
    System.debug('RESULT ' + i++);
    System.debug(result);
}

// --- HEAP SIZE PROBLEM --------------------------------------------------------------------------------------------

// let's say this gave us 1245 opp records...
List<Opportunity> opps = [SELECT Name, Amount, StageName FROM Opportunity];
System.debug(opps.size());

// ... then this loop will run 1245 AND we have all 1245 records loaded in the heap at once
for (Opportunity opp : opps) {
    System.debug(opp);
}


// THE SOLUTION TO THIS HEAP SIZE LIMIT PROBLEM

// SOQL FOR LOOP - apex will AUTOMATICALLY process this query as BATCHES of up to 200 records
for (List<Opportunity> opps : [SELECT Name, Amount, StageName FROM Opportunity]) {  // will run 7 times
    for (Opportunity opp : opps) {      // loop still runs 1245 times in total
        // process each opp as needed
    }
    // load opps back into db - taking them off your heap

    // this way, you only have 200 records on your heap at a time - saving your heap size limit!
}
// PLUS this still only counts as 1 query against your governor limits !!!!!



// Database class static methods
String query = 'SELECT Id, Name, Location__c, Max_Capacity__c FROM Warehouse__c WHERE Location__c = \'Texas\'';
List<Warehouse__c> warehouses = Database.query(query);
System.debug(warehouses);

// could lead to SOQL injection
String stateInput = 'Texas; SELECT Id, Name FROM Contacts;';
String query = 'SELECT Id, Name, Location__c, Max_Capacity__c FROM Warehouse__c WHERE Location__c = ' + stateInput;
List<Warehouse__c> warehouses = Database.query(query);

// DATA BINDING
String realInput = 'Wisconsin';
List<Warehouse__c> warehouses = [SELECT Id, Name, Location__c, Max_Capacity__c 
                                    FROM Warehouse__c 
                                    WHERE Location__c = :realInput];
System.debug(warehouses);

// helps fight SOQL injection - this returns no data
String realInput = 'Wisconsin; SELECT Id, Name FROM Contacts;';
List<Warehouse__c> warehouses = [SELECT Id, Name, Location__c, Max_Capacity__c 
                                    FROM Warehouse__c 
                                    WHERE Location__c = :realInput];
System.debug(warehouses);



// --- RELATIONSHIP QUERIES ---------------------------------------------------------------------------------------

// child to parent w/ custom relationship
List<Inventory__c> inventories = [SELECT Id, Name, Warehouse__r.Id, Warehouse__r.Name FROM Inventory__c];
for(Inventory__c inv : inventories) {
    inv.Warehouse__r.Name += ' TEST';       // still need to use __r in Apex to get/use related data from query
    System.debug(inv.Warehouse__r.Name);
    
    // gives instance of the related record
    Warehouse__c newWarehouse = inv.Warehouse__r;
    System.debug(inv.Warehouse__r);         

    // gives ID of related record
    Id warehouseId = inv.Warehouse__c;
    System.debug(inv.Warehouse__c);         
}
System.debug(inventories);


// child to parent w/ standard relationship
List<Contact> contacts = [SELECT Id, Name, Account.Id, Account.Name FROM Contact];
for(Contact con : contacts) {
    con.Account.Name += ' TEST';       
    System.debug(con.Account.Name);

    // gives instance of the related record
    Account newAccount = con.Account;
    System.debug(con.Account);              

    // gives ID of related record
    Id accId = con.AccountId;
    System.debug(con.AccountId);            
}
System.debug(contacts);


// parent to child counts subqueries differently. can do 300 per transaction
// https://developer.salesforce.com/docs/atlas.en-us.salesforce_app_limits_cheatsheet.meta/salesforce_app_limits_cheatsheet/salesforce_app_limits_platform_apexgov.htm


// parent to child w/ standard relationship
List<Account> accountsAndContacts = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account];
for(Account acc : accountsAndContacts) {

    // all those contacts are stored in a LIST
    List<Contact> contacts = acc.Contacts;   
    for (Contact con : acc.Contacts) {
        System.debug(con);
    }
}

// parent to child w/ custom relationship
List<Warehouse__c> warehouseAndInventories = [SELECT Id, Name, (SELECT Name, Quantity__c FROM Inventories__r) FROM Warehouse__c];
for(Warehouse__c wh : warehouseAndInventories) {

    // all those contacts are stored in a LIST
    List<Inventory__c> contacts = wh.Inventories__r;   
    for (Inventory__c inv : wh.Inventories__r) {
        System.debug(inv);
    }
}
