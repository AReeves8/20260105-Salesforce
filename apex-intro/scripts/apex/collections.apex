/**
 * COLLECTIONS
 *      store multiple values in one variable
 * 
 *      
 *      - List: an array, holds multiple values
 *      - Set: unordered, not allow duplicate values
 *      - Map: key-value pairs, keys must be unique (no dupes), values can be anything
 */


// LISTS
List<String> fruits = new List<String>();

// adding values with .add()
fruits.add('tomato');
fruits.add('strawberry');
fruits.add('orange');
fruits.add('banana');
System.debug(fruits);


// access values with wither .get(index) OR [index]
System.debug(fruits.get(1));    // strawberry
System.debug(fruits[2]);        // orange

// insert at a specific location with .add()
fruits.add(1, 'apple');
System.debug(fruits.get(1));    // apple

// update a specific index with .set()
fruits.set(0, 'grapes');
System.debug(fruits.get(0));    // grapes, not tomato

System.debug(fruits);

System.debug('Index of banana: ' + fruits.indexOf('banana'));   // returns index of banana in list
System.debug('Index of banana: ' + fruits.indexOf('tomato'));   // returns -1 if value does not exist

fruits.remove(2);               // removes strawberry
System.debug(fruits);

// size for number of elements in list
System.debug(fruits.size());    


// SETS
Set<String> names = new Set<String>();
names.add('Austin');
names.add('Gavin');
names.add('Pavitra');
names.add('Jason');
names.add('Jason');     // second Jason replaces the original Jason
System.debug('ALL NAMES ' + names);     // System.debug automatically sorts Sets. 

// similar methods to Lists

// copies everything in one list/set to the current list/set
names.addAll(fruits);
System.debug('ALL NAMES ' + names);

// delete everything in this list/set that matches in another list/set
names.removeAll(fruits);
System.debug('ALL NAMES ' + names);


// MAPS
Map<String,Integer> people = new Map<String,Integer>();

// insert .put()
people.put('Austin', 26);
people.put('Jon', 32);
people.put('Jason', 29);
people.put('Gavin', 21);
System.debug(people);

people.put('Gavin', 22);    // inserting a key that already exists will update the value for that key
System.debug(people);

// use .get(key) to access the value at that key
System.debug('Austin age: ' + people.get('Austin'));

// returns a Set of all keys
Set<String> peopleNames = people.keySet();
System.debug('ALL NAMES: ' + peopleNames);

// return a List of all values
List<Integer> peopleAges = people.values();
System.debug('ALL AGES: ' + peopleAges);

// use .remove(key) to delete a key-value pair from the map
people.remove('Austin');
System.debug(people);