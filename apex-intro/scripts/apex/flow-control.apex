/**
 * BRANCHING
 *      - executes different blocks of code based on some boolean condition(s)
 * 
 *      - if-else
 *      - ternary operator
 *      - switch 
 */

// IF ELSE

Integer age = 9;

// logic is wrong, so switch it around
if(age >= 16) {
    System.debug('Old enough to drive');
}
else if(age >= 18) {
    System.debug('Old enough to vote');
}
else if(age >= 21) {
    System.debug('Old enough to purchase alcohol');
}
else if(age >= 65) {
    System.debug('Old enough to retire');
}
else {
    System.debug('really really old');
}


if(age >= 65) {
    System.debug('Old enough to retire');
}
else if(age >= 21) {
    System.debug('Old enough to purchase alcohol');
}
else if(age >= 18) {
    System.debug('Old enough to vote');
}
else if(age >= 16) {
    System.debug('Old enough to drive');
}
else {
    System.debug('really really young');
}


// TERNARY OPERATOR
//                condition ?    result_if_true     :   result_if_false
String message = (age >= 16 ? 'Old enough to drive' : 'really really young');
System.debug(message);


// SWITCH

String day = 'Saturday';
switch on day {
    when 'Monday' {
        System.debug('You\'re just getting started');       // use \ as the escape charcter in strings
        // no break statement needed
    }
    when 'Tuesday' {
        System.debug('One down, four to go');       
    }
    when 'Wednesday' {
        System.debug('You\'re halfway there');       
    }
    when 'Thursday' {
        System.debug('Don\t give up now!');       
    }
    when 'Friday' {
        System.debug('It\'s almost here!');       
    }
    when 'Saturday', 'Sunday' {                 // can have multiple in one branch
        System.debug('IT\'S THE WEEKEND');
    }
    when else {                                 // default branch if non of the other values match
        System.debug('not a day of the week');
    }
}


/**
 * LOOPS
 *      allow you to execute the same block of code over and over again based on some condition
 * 
 *      - while
 *      - do-while
 *      - for
 *      - iteration for (aka for each, enhanced for in other languages)
 */

Integer age = 13;
while (age < 16) {
    System.debug('Not old enough to drive at age ' + age);
    age++;      // increment and decrement operator do exist in Apex
}
System.debug('old enough to drive at age ' + age);  // plus sign for string concatenation

// runs code first, then checks condition
do {
    System.debug('Not old enough to vote at age ' + age);
    age++;
} while (age < 18);
System.debug('old enough to vote at age ' + age);

// iterating/looping a specific number of times
for(Integer i = 5; i < 10; i++) {
    System.debug('i = ' + i);
}

List<Integer> ages = new List<Integer>{17, 81, 32, 4};

for (Integer age : ages) {
    if(age >= 65) {
        System.debug(age + ' is old enough to retire');
    }
    else if(age >= 21) {
        System.debug(age + ' is old enough to purchase alcohol');
    }
    else if(age >= 18) {
        System.debug(age + ' is old enough to vote');
    }
    else if(age >= 16) {
        System.debug(age + ' is old enough to drive');
    }
    else {
        System.debug(age + ' is really really young');
    }
}