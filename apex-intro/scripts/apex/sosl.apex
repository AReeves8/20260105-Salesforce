// SALESFORCE OBJECT SEARCH LANGUAGE (SOSL)

// has the ability to search through multiple (unrelated) objects at once
/**
 * USE CASE: 
 *      - when you don't know which object is going to have the data you're looking for
 *      - generally better for text searches than SOQL
 */
 

// ALWAYS has this return type
List<List<SObject>> results = [
        FIND 'David' 
        IN ALL FIELDS 
        RETURNING Account, Contact, Opportunity     
    ];              // will only return IDs for each record found

// order of returned objects is the same as they are listed in your Search
List<Account> accounts = results[0];
for (Account acc : accounts) {
    // process each account record
    System.debug(acc);
}
List<Contact> contacts = results[1];
for (Contact con : contacts) {
    // process each contact record
    System.debug(con);
}
List<Opportunity> opportunities = results[2];
for (Opportunity opp : opportunities) {
    // process each opportunity record record
    System.debug(opp);
}


// have to specify which fields you want if you want more than IDs
List<List<SObject>> results = [
        FIND 'David' 
        IN ALL FIELDS 
        RETURNING Account, Contact(Name, Email, Phone), Opportunity     
    ];                      // will give us Name, Email, and Phone fields for Contact

List<Contact> contacts = results[1];
for (Contact con : contacts) {
    // process each contact record
    System.debug(con);
}


// SOSL SYNTAX
/**
 * FIND clause 
 *      - where you put what you're searching for
 *      - can do expressions (and, or, not, string concatenation, variable binding (:))
 *      - wildcards
 *              * - macthes any number of characters
 *              ? - match a single character
 */
String searchText = 'David OR J*n';
List<List<SObject>> results = [
        FIND :searchText
        IN ALL FIELDS 
        RETURNING Account, Contact(Name, Email, Phone), Opportunity     
    ];
List<Contact> contacts = results[1];
for (Contact con : contacts) {
    // process each contact record
    System.debug(con);
}

/**
 * SEARCH GROUP clause aka IN clause
 *      - specify which fields to search through
 *          - ALL FIELDS (all text fields on the object)
 *          - NAME FIELDS (when nameField = true)
 *          - EMAIL FIELDS (all email fields on an object)
 *          - PHONE FIELDS (all pone fields on an object)
 */
List<List<SObject>> results = [
        FIND 'David OR J*n' 
        IN EMAIL FIELDS 
        RETURNING Account, Contact(Name, Email, Phone), Opportunity     
    ];
List<Contact> contacts = results[1];
for (Contact con : contacts) {
    // process each contact record
    System.debug(con);
}

/**
 * RETURNING clause
 *      - objects and fields you want returned
 *          - ID fields only unless you specify otherwise
 * 
 *      - filtering with WHERE conditions here
 */
List<List<SObject>> results = [
        FIND '*United*' 
        IN NAME FIELDS 
        RETURNING Account(Name, Industry WHERE Industry = 'Energy')     
    ];
List<Account> accounts = results[0];
for (Account acc : accounts) {
    // process each account record
    System.debug(acc);
}


// SEARCH STATIC METHOD - wrap search term in curly braces 
String soslSearch = 'FIND {*United*} IN NAME FIELDS RETURNING Account(Name, Industry WHERE Industry = \'Energy\')';
List<List<SObject>> results = Search.query(soslSearch);
System.debug(results);