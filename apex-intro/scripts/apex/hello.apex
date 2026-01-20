/*
	Execute Anonymous

		a spot where you can write and run code
		Apex, doesn't have a main method
		
		not available in prod
		
		it CAN affect your org data

		User Mode vs System Mode
			user mode - run code while respecting a user's object, field, and record level access
				- ensures that a user cannot access data they shouldn't
				- EA runs in user mode
			system mode - ignore a user's acess permissions
				- this code will always be able to run
					- if a user does not have access in User Mode, then the code will not work
					- does a user really see the data in the code??
				MOST of Apex code runs in System Mode by default


    // Use .apex files to store anonymous Apex.
    // You can execute anonymous Apex in VS Code by selecting the
    //     apex text and running the command:
    //     SFDX: Execute Anonymous Apex with Currently Selected Text
    // You can also execute the entire file by running the command:
    //     SFDX: Execute Anonymous Apex with Editor Contents
*/


// single line comments

String helloWorld = 'Hello World!';		// strings are single quotes
System.debug(helloWorld);				// standard print statement - creates a "debug" level log message 

/*
	logging levels
		fine	
		debug *
		info
		warn
		error
*/

// Apex is case insensitive so its up to you to follow best practices
string tempvar = 'Austin';

//String string = 'string';             // does not compile
//System.debug(string);

// TYPES
String s = 'string';                    // avoid using AWFUL variable names
Boolean isReady = true;
Integer num1 = 1;
Long num2 = 1000000000L;
Decimal dec1 = 13.1234;
Double dec2 = 14.1234;
Date currentDate = Date.today();
Date aprilFools = Date.newInstance(2026, 4, 1);
// also have Time and Datetime 
Id accountId = '001g5000006WTYYAA4';    // Id value for Drfitwood Marine Account

// OBJECTS AND FIELDS - use API names 
Account acc = new Account();
Warehouse__c warehouse = new Warehouse__c();

acc.AnnualRevenue = 5000;
acc.Name = 'Test Account';

warehouse.Name = 'Test Warehouse';
warehouse.Max_Capacity__c = 500000;

System.debug(acc);
System.debug(warehouse);

// very easy to affect your org data..
insert acc;
insert warehouse;