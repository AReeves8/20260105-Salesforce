/**
 * Data Manipulation Language (DML)
 *      - built in directly to Apex
 *      - persist data INTO your salesforce org
 * 
 *      - six DML statements
 *          - insert
 *          - update
 *          - upsert (combo of insert and update)
 *          - delete
 *          - undelete (pull records out of your orgs recycle bin)
 *          - merge (combo of update and delete)
 * 
 *      - governor limits:
 *          - 150 statements per transaction
 *          - 10000 rows persisted per transaction
 */

List<Contact> contactsWithoutLeadSource = [SELECT Id FROM Contact WHERE LeadSource = null];
for (Contact con : contactsWithoutLeadSource) {
    con.LeadSource = 'Other';
}

// use DML statements on either a single sObject or a List/Set of them
update contactsWithoutLeadSource;


// UPDATE and UPSERT matching
// a complete override of any data that is set during code
// matches on a Salesforce ID OR a field marked as 'External Id'
// if there is one match, then that record is updated, if there's multiple matches found an error is thrown
// if no match then no update (unless upsert - then new record being created)



// --- HANDLING DML ERRORS -----------------------------------------------------------------------------------------------------

String name;                        // ALL PRIMITIVE TYPES DEFAULT TO NULL
Contact noName = new Contact();
noName.LastName = name;             // LastName is a required field on Contact
insert noName;                      // DmlException because record did not ahve a Last Name set.

Contact withName = new Contact(LastName = 'Reeves');
insert withName;                    // no exception


Contact noName = new Contact();
try {
    insert noName;
} catch (DmlException e) {
    
    String error = e.getDmlMessage(0);
    System.debug('Contact could not be created. Error: ' + error);

    if(error.contains('Required fields')) {
        noName.LastName = 'Default Name';
    }
    insert noName;
} catch (Exception e) {
    System.debug('Something unintended went wrong.');
} finally {
    System.debug('This always runs, wether or not an excpetion was thrown.');
}


// --- PARTIAL PROCESSING ----------------------------------------------------------------------------------------

List<Contact> contacts = new List<Contact>();
contacts.add(new Contact(LastName = 'Guthy'));
contacts.add(new Contact());
insert contacts;        // standalone DML statements are ALL OR NOTHING, all records persist successfully, or none do


// Database Static Methods For Each DML Operation
Database.insert(contacts);          // does the exact same thing as standalone DML

List<Contact> contacts = new List<Contact>();
contacts.add(new Contact(LastName = 'Guthy'));
contacts.add(new Contact());
Database.insert(contacts, false);   // Disable allOrNothing functionality - allowing partial processing
// result - Guthy contact is inserted successfully


// can use Database.SaveResult to get information on Database transactions
List<Contact> contacts = new List<Contact>();
contacts.add(new Contact(LastName = 'Scheidler'));
contacts.add(new Contact());
List<Database.SaveResult> saveResults = Database.insert(contacts, false);
for (Database.SaveResult sr : saveResults) {
    
    // one save result per record

    // if a record failed, find out why
    if(!sr.isSuccess()) {
        List<Database.Error> errors = sr.getErrors();
        for (Database.Error err : errors) {
            // process errors that occured
            System.debug(err);


            // send to global error logger
        }
    }else {
        System.debug('Contact was inserted. ID: ' + sr.getId());    // gets newly generated 18-character ID
    }
}


/**
 * SALESFORCE IDS
 *      15-character ID (case sensitive)
 *      18-character ID (case insensitive)
 * 
 *      only saves the 15-char ID into the database
 *          BUT every time you access a record, salesforce runs an operation to generate the final three characters
 * 
 *      003g5000002GaDZAA0
 *      003g5000002GaDZABC
 *      003g5000002GADZABD
 */



for (List<Opportunity> opps : [SELECT Name, Amount, StageName FROM Opportunity]) {  // will run 7 times
    for (Opportunity opp : opps) {      // loop still runs 1245 times in total
        // process each opp as needed

        // DO NOT DO DML STATEMENTS IN LOOPS

    }
    // bulkify your code - insert many records at once instead of one at a time
    // will run 7 DML statements - trade off for not hitting Heap Size limit
    insert opps;    

    // this way, you only have 200 records on your heap at a time - saving your heap size limit!
}



// Strict Equality Operator (===)
// checks values AND data types
// equality operator (==) only checks values

Boolean bool;   // null
if(bool == false) {
    System.debug('True! because of auto-unboxing!');
}   

// null value cannot use strict equalit operator - doesn't compile
// if(bool === false) {
//     System.debug('False! because data type is different');
// }

Contact con1 = new Contact(LastName = 'Austin');
Contact con2 = new Contact(LastName = 'Austin');

if(con1 === con2) {
    System.debug('Contacts are equal!');        // doesn't happen
}

con2 = con1;
if(con1 === con2) {
    System.debug('Contacts are equal now!');   
}
