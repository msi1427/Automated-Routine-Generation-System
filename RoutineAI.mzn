include "globals.mzn";
include "alldifferent.mzn";

enum COURSE;

int: periods; 
int: rooms;
int: days; 

array[1..days,1..periods] of var COURSE : timetable;



solve :: int_search([timetable[c,p] | c in 1..days, p in 1..periods], 
                     most_constrained, indomain_split, complete) satisfy;