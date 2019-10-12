%header files

include "globals.mzn";

%parameter definitions

%courses of 1st Semester
enum COURSE1;
%courses of 3rd Semester
enum COURSE2;
%courses of 5th Semester
enum COURSE3;
%courses of 7th Semester
enum COURSE4;
%number of periods
enum PERIODS;
enum DAYS;
%number of rooms
int : NUMROOM;

%daily periods of a course and total periods for a course in a week
array[COURSE1] of int : DAILYPERIODS1;
array[COURSE1] of int : TOTALPERIODS1;

array[COURSE2] of int : DAILYPERIODS2;
array[COURSE2] of int : TOTALPERIODS2;

array[COURSE3] of int : DAILYPERIODS3;
array[COURSE3] of int : TOTALPERIODS3;

array[COURSE4] of int : DAILYPERIODS4;
array[COURSE4] of int : TOTALPERIODS4;

%decision variable declarations

%routine table for all sections for all years
array[DAYS,PERIODS] of var COURSE1 : timetable11;
array[DAYS,PERIODS] of var COURSE1 : timetable12;
array[DAYS,PERIODS] of var COURSE2 : timetable21;
array[DAYS,PERIODS] of var COURSE2 : timetable22;
array[DAYS,PERIODS] of var COURSE3 : timetable31;
array[DAYS,PERIODS] of var COURSE3 : timetable32;
array[DAYS,PERIODS] of var COURSE4 : timetable41;
array[DAYS,PERIODS] of var COURSE4 : timetable42;

%this arrays are to find out on which day we can have which classes
array[DAYS,COURSE1] of var int : checker1;
array[DAYS,COURSE2] of var int : checker2;
array[DAYS,COURSE3] of var int : checker3;
array[DAYS,COURSE4] of var int : checker4;

%constraints

% Constraints for For Year 1

%CS1: every cell of checker can't have a bigger value than the assigned daily periods of the respective courses
constraint forall(d in DAYS) (forall(c in COURSE1)(0 <= checker1[d,c] /\ checker1[d,c] <= DAILYPERIODS1[c]) );

%CS2: this is to specify the lab classes, the lab classes will be of two periods in a day
constraint forall(d in DAYS) (forall(c in COURSE1)( if DAILYPERIODS1[c] = 2 then ( (checker1[d,c] = 0) \/ (checker1[d,c] = 2) ) endif) );

%CS3: every column of checker table won't have a sum more than TOTALPERIODS, because total periods define the number of periods required in one week.
constraint forall(c in COURSE1)( sum( d in DAYS) (checker1[d,c]) =  TOTALPERIODS1[c]);

%CS4: every row of checker table won't have a sum more than 6, because in one day there can't be more than 6 periods
constraint forall(d in DAYS)( sum( c in COURSE1) (checker1[d,c]) = 6);

%CS5: there won't be more than two lab classes in a day
constraint forall(d in DAYS)( sum( c in COURSE1) (checker1[d,c] = 2) <= 2);

%CS6: Everyday there will be at least a gap period
constraint forall(d in DAYS) (checker1[d,COURSE1[11]]>=1);

%CS7: this constraint is basically reforming timetable using checker table by equalizing the number of courses in the same day for section A
constraint forall(d in DAYS)( forall(c in COURSE1) ( sum( p in PERIODS ) ( timetable11[d,p] = c ) =  checker1[d,c]) );

%CS8: these constraints are to specify that the lab classes will be in consequent periods ignoring break time.
constraint
(timetable11[DAYS[1],PERIODS[1]]=8 /\ timetable11[DAYS[1],PERIODS[2]]=8) \/ (timetable11[DAYS[1],PERIODS[3]]=8 /\ timetable11[DAYS[1],PERIODS[4]]=8) \/ (timetable11[DAYS[1],PERIODS[5]]=8 /\ timetable11[DAYS[1],PERIODS[6]]=8) \/
(timetable11[DAYS[2],PERIODS[1]]=8 /\ timetable11[DAYS[2],PERIODS[2]]=8) \/ (timetable11[DAYS[2],PERIODS[3]]=8 /\ timetable11[DAYS[2],PERIODS[4]]=8) \/ (timetable11[DAYS[2],PERIODS[5]]=8 /\ timetable11[DAYS[2],PERIODS[6]]=8) \/
(timetable11[DAYS[3],PERIODS[1]]=8 /\ timetable11[DAYS[3],PERIODS[2]]=8) \/ (timetable11[DAYS[3],PERIODS[3]]=8 /\ timetable11[DAYS[3],PERIODS[4]]=8) \/ (timetable11[DAYS[3],PERIODS[5]]=8 /\ timetable11[DAYS[3],PERIODS[6]]=8) \/
(timetable11[DAYS[4],PERIODS[1]]=8 /\ timetable11[DAYS[4],PERIODS[2]]=8) \/ (timetable11[DAYS[4],PERIODS[3]]=8 /\ timetable11[DAYS[4],PERIODS[4]]=8) \/ (timetable11[DAYS[4],PERIODS[5]]=8 /\ timetable11[DAYS[4],PERIODS[6]]=8) \/
(timetable11[DAYS[5],PERIODS[1]]=8 /\ timetable11[DAYS[5],PERIODS[2]]=8) \/ (timetable11[DAYS[5],PERIODS[3]]=8 /\ timetable11[DAYS[5],PERIODS[4]]=8) \/ (timetable11[DAYS[5],PERIODS[5]]=8 /\ timetable11[DAYS[5],PERIODS[6]]=8);

constraint
(timetable11[DAYS[1],PERIODS[1]]=9 /\ timetable11[DAYS[1],PERIODS[2]]=9) \/ (timetable11[DAYS[1],PERIODS[3]]=9 /\ timetable11[DAYS[1],PERIODS[4]]=9) \/ (timetable11[DAYS[1],PERIODS[5]]=9 /\ timetable11[DAYS[1],PERIODS[6]]=9) \/
(timetable11[DAYS[2],PERIODS[1]]=9 /\ timetable11[DAYS[2],PERIODS[2]]=9) \/ (timetable11[DAYS[2],PERIODS[3]]=9 /\ timetable11[DAYS[2],PERIODS[4]]=9) \/ (timetable11[DAYS[2],PERIODS[5]]=9 /\ timetable11[DAYS[2],PERIODS[6]]=9) \/
(timetable11[DAYS[3],PERIODS[1]]=9 /\ timetable11[DAYS[3],PERIODS[2]]=9) \/ (timetable11[DAYS[3],PERIODS[3]]=9 /\ timetable11[DAYS[3],PERIODS[4]]=9) \/ (timetable11[DAYS[3],PERIODS[5]]=9 /\ timetable11[DAYS[3],PERIODS[6]]=9) \/
(timetable11[DAYS[4],PERIODS[1]]=9 /\ timetable11[DAYS[4],PERIODS[2]]=9) \/ (timetable11[DAYS[4],PERIODS[3]]=9 /\ timetable11[DAYS[4],PERIODS[4]]=9) \/ (timetable11[DAYS[4],PERIODS[5]]=9 /\ timetable11[DAYS[4],PERIODS[6]]=9) \/
(timetable11[DAYS[5],PERIODS[1]]=9 /\ timetable11[DAYS[5],PERIODS[2]]=9) \/ (timetable11[DAYS[5],PERIODS[3]]=9 /\ timetable11[DAYS[5],PERIODS[4]]=9) \/ (timetable11[DAYS[5],PERIODS[5]]=9 /\ timetable11[DAYS[5],PERIODS[6]]=9);

constraint
(timetable11[DAYS[1],PERIODS[1]]=10 /\ timetable11[DAYS[1],PERIODS[2]]=10) \/ (timetable11[DAYS[1],PERIODS[3]]=10 /\ timetable11[DAYS[1],PERIODS[4]]=10) \/ (timetable11[DAYS[1],PERIODS[5]]=10 /\ timetable11[DAYS[1],PERIODS[6]]=10) \/
(timetable11[DAYS[2],PERIODS[1]]=10 /\ timetable11[DAYS[2],PERIODS[2]]=10) \/ (timetable11[DAYS[2],PERIODS[3]]=10 /\ timetable11[DAYS[2],PERIODS[4]]=10) \/ (timetable11[DAYS[2],PERIODS[5]]=10 /\ timetable11[DAYS[2],PERIODS[6]]=10) \/
(timetable11[DAYS[3],PERIODS[1]]=10 /\ timetable11[DAYS[3],PERIODS[2]]=10) \/ (timetable11[DAYS[3],PERIODS[3]]=10 /\ timetable11[DAYS[3],PERIODS[4]]=10) \/ (timetable11[DAYS[3],PERIODS[5]]=10 /\ timetable11[DAYS[3],PERIODS[6]]=10) \/
(timetable11[DAYS[4],PERIODS[1]]=10 /\ timetable11[DAYS[4],PERIODS[2]]=10) \/ (timetable11[DAYS[4],PERIODS[3]]=10 /\ timetable11[DAYS[4],PERIODS[4]]=10) \/ (timetable11[DAYS[4],PERIODS[5]]=10 /\ timetable11[DAYS[4],PERIODS[6]]=10) \/
(timetable11[DAYS[5],PERIODS[1]]=10 /\ timetable11[DAYS[5],PERIODS[2]]=10) \/ (timetable11[DAYS[5],PERIODS[3]]=10 /\ timetable11[DAYS[5],PERIODS[4]]=10) \/ (timetable11[DAYS[5],PERIODS[5]]=10 /\ timetable11[DAYS[5],PERIODS[6]]=10);

%this constraint is basically reforming timetable using checker table by equalizing the number of courses in the same day for section B
constraint forall(d in DAYS)( forall(c in COURSE1) ( sum( p in PERIODS ) ( timetable12[d,p] = c ) =  checker1[d,c]) );

constraint
(timetable12[DAYS[1],PERIODS[1]]=8 /\ timetable12[DAYS[1],PERIODS[2]]=8) \/ (timetable12[DAYS[1],PERIODS[3]]=8 /\ timetable12[DAYS[1],PERIODS[4]]=8) \/ (timetable12[DAYS[1],PERIODS[5]]=8 /\ timetable12[DAYS[1],PERIODS[6]]=8) \/
(timetable12[DAYS[2],PERIODS[1]]=8 /\ timetable12[DAYS[2],PERIODS[2]]=8) \/ (timetable12[DAYS[2],PERIODS[3]]=8 /\ timetable12[DAYS[2],PERIODS[4]]=8) \/ (timetable12[DAYS[2],PERIODS[5]]=8 /\ timetable12[DAYS[2],PERIODS[6]]=8) \/
(timetable12[DAYS[3],PERIODS[1]]=8 /\ timetable12[DAYS[3],PERIODS[2]]=8) \/ (timetable12[DAYS[3],PERIODS[3]]=8 /\ timetable12[DAYS[3],PERIODS[4]]=8) \/ (timetable12[DAYS[3],PERIODS[5]]=8 /\ timetable12[DAYS[3],PERIODS[6]]=8) \/
(timetable12[DAYS[4],PERIODS[1]]=8 /\ timetable12[DAYS[4],PERIODS[2]]=8) \/ (timetable12[DAYS[4],PERIODS[3]]=8 /\ timetable12[DAYS[4],PERIODS[4]]=8) \/ (timetable12[DAYS[4],PERIODS[5]]=8 /\ timetable12[DAYS[4],PERIODS[6]]=8) \/
(timetable12[DAYS[5],PERIODS[1]]=8 /\ timetable12[DAYS[5],PERIODS[2]]=8) \/ (timetable12[DAYS[5],PERIODS[3]]=8 /\ timetable12[DAYS[5],PERIODS[4]]=8) \/ (timetable12[DAYS[5],PERIODS[5]]=8 /\ timetable12[DAYS[5],PERIODS[6]]=8);

constraint
(timetable12[DAYS[1],PERIODS[1]]=9 /\ timetable12[DAYS[1],PERIODS[2]]=9) \/ (timetable12[DAYS[1],PERIODS[3]]=9 /\ timetable12[DAYS[1],PERIODS[4]]=9) \/ (timetable12[DAYS[1],PERIODS[5]]=9 /\ timetable12[DAYS[1],PERIODS[6]]=9) \/
(timetable12[DAYS[2],PERIODS[1]]=9 /\ timetable12[DAYS[2],PERIODS[2]]=9) \/ (timetable12[DAYS[2],PERIODS[3]]=9 /\ timetable12[DAYS[2],PERIODS[4]]=9) \/ (timetable12[DAYS[2],PERIODS[5]]=9 /\ timetable12[DAYS[2],PERIODS[6]]=9) \/
(timetable12[DAYS[3],PERIODS[1]]=9 /\ timetable12[DAYS[3],PERIODS[2]]=9) \/ (timetable12[DAYS[3],PERIODS[3]]=9 /\ timetable12[DAYS[3],PERIODS[4]]=9) \/ (timetable12[DAYS[3],PERIODS[5]]=9 /\ timetable12[DAYS[3],PERIODS[6]]=9) \/
(timetable12[DAYS[4],PERIODS[1]]=9 /\ timetable12[DAYS[4],PERIODS[2]]=9) \/ (timetable12[DAYS[4],PERIODS[3]]=9 /\ timetable12[DAYS[4],PERIODS[4]]=9) \/ (timetable12[DAYS[4],PERIODS[5]]=9 /\ timetable12[DAYS[4],PERIODS[6]]=9) \/
(timetable12[DAYS[5],PERIODS[1]]=9 /\ timetable12[DAYS[5],PERIODS[2]]=9) \/ (timetable12[DAYS[5],PERIODS[3]]=9 /\ timetable12[DAYS[5],PERIODS[4]]=9) \/ (timetable12[DAYS[5],PERIODS[5]]=9 /\ timetable12[DAYS[5],PERIODS[6]]=9);

constraint
(timetable12[DAYS[1],PERIODS[1]]=10 /\ timetable12[DAYS[1],PERIODS[2]]=10) \/ (timetable12[DAYS[1],PERIODS[3]]=10 /\ timetable12[DAYS[1],PERIODS[4]]=10) \/ (timetable12[DAYS[1],PERIODS[5]]=10 /\ timetable12[DAYS[1],PERIODS[6]]=10) \/
(timetable12[DAYS[2],PERIODS[1]]=10 /\ timetable12[DAYS[2],PERIODS[2]]=10) \/ (timetable12[DAYS[2],PERIODS[3]]=10 /\ timetable12[DAYS[2],PERIODS[4]]=10) \/ (timetable12[DAYS[2],PERIODS[5]]=10 /\ timetable12[DAYS[2],PERIODS[6]]=10) \/
(timetable12[DAYS[3],PERIODS[1]]=10 /\ timetable12[DAYS[3],PERIODS[2]]=10) \/ (timetable12[DAYS[3],PERIODS[3]]=10 /\ timetable12[DAYS[3],PERIODS[4]]=10) \/ (timetable12[DAYS[3],PERIODS[5]]=10 /\ timetable12[DAYS[3],PERIODS[6]]=10) \/
(timetable12[DAYS[4],PERIODS[1]]=10 /\ timetable12[DAYS[4],PERIODS[2]]=10) \/ (timetable12[DAYS[4],PERIODS[3]]=10 /\ timetable12[DAYS[4],PERIODS[4]]=10) \/ (timetable12[DAYS[4],PERIODS[5]]=10 /\ timetable12[DAYS[4],PERIODS[6]]=10) \/
(timetable12[DAYS[5],PERIODS[1]]=10 /\ timetable12[DAYS[5],PERIODS[2]]=10) \/ (timetable12[DAYS[5],PERIODS[3]]=10 /\ timetable12[DAYS[5],PERIODS[4]]=10) \/ (timetable12[DAYS[5],PERIODS[5]]=10 /\ timetable12[DAYS[5],PERIODS[6]]=10);

%CS9: both section won't have same course on the same period of the same day
constraint forall(d in DAYS) ( forall(p in PERIODS) ( if(timetable11[d,p]!=11) then timetable11[d,p]!=timetable12[d,p] endif ));



% Constraints for For Year 2

constraint forall(d in DAYS) (forall(c in COURSE2)(0 <= checker2[d,c] /\ checker2[d,c] <= DAILYPERIODS2[c]) );

constraint forall(d in DAYS) (forall(c in COURSE2)( if DAILYPERIODS2[c] = 2 then ( (checker2[d,c] = 0) \/ (checker2[d,c] = 2) ) endif) );

constraint forall(c in COURSE2)( sum( d in DAYS) (checker2[d,c]) =  TOTALPERIODS2[c]);

constraint forall(d in DAYS)( sum( c in COURSE2) (checker2[d,c]) = 6);

constraint forall(d in DAYS)( sum( c in COURSE2) (checker2[d,c] = 2) <= 2);

constraint forall(d in DAYS) (checker2[d,COURSE2[11]]>=1);

constraint forall(d in DAYS)( forall(c in COURSE2) ( sum( p in PERIODS ) ( timetable21[d,p] = c ) =  checker2[d,c]) );

constraint 
(timetable21[DAYS[1],PERIODS[1]]=7 /\ timetable21[DAYS[1],PERIODS[2]]=7) \/ (timetable21[DAYS[1],PERIODS[3]]=7 /\ timetable21[DAYS[1],PERIODS[4]]=7) \/ (timetable21[DAYS[1],PERIODS[5]]=7 /\ timetable21[DAYS[1],PERIODS[6]]=7) \/ 
(timetable21[DAYS[2],PERIODS[1]]=7 /\ timetable21[DAYS[2],PERIODS[2]]=7) \/ (timetable21[DAYS[2],PERIODS[3]]=7 /\ timetable21[DAYS[2],PERIODS[4]]=7) \/ (timetable21[DAYS[2],PERIODS[5]]=7 /\ timetable21[DAYS[2],PERIODS[6]]=7) \/ 
(timetable21[DAYS[3],PERIODS[1]]=7 /\ timetable21[DAYS[3],PERIODS[2]]=7) \/ (timetable21[DAYS[3],PERIODS[3]]=7 /\ timetable21[DAYS[3],PERIODS[4]]=7) \/ (timetable21[DAYS[3],PERIODS[5]]=7 /\ timetable21[DAYS[3],PERIODS[6]]=7) \/ 
(timetable21[DAYS[4],PERIODS[1]]=7 /\ timetable21[DAYS[4],PERIODS[2]]=7) \/ (timetable21[DAYS[4],PERIODS[3]]=7 /\ timetable21[DAYS[4],PERIODS[4]]=7) \/ (timetable21[DAYS[4],PERIODS[5]]=7 /\ timetable21[DAYS[4],PERIODS[6]]=7) \/
(timetable21[DAYS[5],PERIODS[1]]=7 /\ timetable21[DAYS[5],PERIODS[2]]=7) \/ (timetable21[DAYS[5],PERIODS[3]]=7 /\ timetable21[DAYS[5],PERIODS[4]]=7) \/ (timetable21[DAYS[5],PERIODS[5]]=7 /\ timetable21[DAYS[5],PERIODS[6]]=7);

constraint
(timetable21[DAYS[1],PERIODS[1]]=8 /\ timetable21[DAYS[1],PERIODS[2]]=8) \/ (timetable21[DAYS[1],PERIODS[3]]=8 /\ timetable21[DAYS[1],PERIODS[4]]=8) \/ (timetable21[DAYS[1],PERIODS[5]]=8 /\ timetable21[DAYS[1],PERIODS[6]]=8) \/
(timetable21[DAYS[2],PERIODS[1]]=8 /\ timetable21[DAYS[2],PERIODS[2]]=8) \/ (timetable21[DAYS[2],PERIODS[3]]=8 /\ timetable21[DAYS[2],PERIODS[4]]=8) \/ (timetable21[DAYS[2],PERIODS[5]]=8 /\ timetable21[DAYS[2],PERIODS[6]]=8) \/
(timetable21[DAYS[3],PERIODS[1]]=8 /\ timetable21[DAYS[3],PERIODS[2]]=8) \/ (timetable21[DAYS[3],PERIODS[3]]=8 /\ timetable21[DAYS[3],PERIODS[4]]=8) \/ (timetable21[DAYS[3],PERIODS[5]]=8 /\ timetable21[DAYS[3],PERIODS[6]]=8) \/
(timetable21[DAYS[4],PERIODS[1]]=8 /\ timetable21[DAYS[4],PERIODS[2]]=8) \/ (timetable21[DAYS[4],PERIODS[3]]=8 /\ timetable21[DAYS[4],PERIODS[4]]=8) \/ (timetable21[DAYS[4],PERIODS[5]]=8 /\ timetable21[DAYS[4],PERIODS[6]]=8) \/
(timetable21[DAYS[5],PERIODS[1]]=8 /\ timetable21[DAYS[5],PERIODS[2]]=8) \/ (timetable21[DAYS[5],PERIODS[3]]=8 /\ timetable21[DAYS[5],PERIODS[4]]=8) \/ (timetable21[DAYS[5],PERIODS[5]]=8 /\ timetable21[DAYS[5],PERIODS[6]]=8);

constraint
(timetable21[DAYS[1],PERIODS[1]]=9 /\ timetable21[DAYS[1],PERIODS[2]]=9) \/ (timetable21[DAYS[1],PERIODS[3]]=9 /\ timetable21[DAYS[1],PERIODS[4]]=9) \/ (timetable21[DAYS[1],PERIODS[5]]=9 /\ timetable21[DAYS[1],PERIODS[6]]=9) \/
(timetable21[DAYS[2],PERIODS[1]]=9 /\ timetable21[DAYS[2],PERIODS[2]]=9) \/ (timetable21[DAYS[2],PERIODS[3]]=9 /\ timetable21[DAYS[2],PERIODS[4]]=9) \/ (timetable21[DAYS[2],PERIODS[5]]=9 /\ timetable21[DAYS[2],PERIODS[6]]=9) \/
(timetable21[DAYS[3],PERIODS[1]]=9 /\ timetable21[DAYS[3],PERIODS[2]]=9) \/ (timetable21[DAYS[3],PERIODS[3]]=9 /\ timetable21[DAYS[3],PERIODS[4]]=9) \/ (timetable21[DAYS[3],PERIODS[5]]=9 /\ timetable21[DAYS[3],PERIODS[6]]=9) \/
(timetable21[DAYS[4],PERIODS[1]]=9 /\ timetable21[DAYS[4],PERIODS[2]]=9) \/ (timetable21[DAYS[4],PERIODS[3]]=9 /\ timetable21[DAYS[4],PERIODS[4]]=9) \/ (timetable21[DAYS[4],PERIODS[5]]=9 /\ timetable21[DAYS[4],PERIODS[6]]=9) \/
(timetable21[DAYS[5],PERIODS[1]]=9 /\ timetable21[DAYS[5],PERIODS[2]]=9) \/ (timetable21[DAYS[5],PERIODS[3]]=9 /\ timetable21[DAYS[5],PERIODS[4]]=9) \/ (timetable21[DAYS[5],PERIODS[5]]=9 /\ timetable21[DAYS[5],PERIODS[6]]=9);

constraint
(timetable21[DAYS[1],PERIODS[1]]=10 /\ timetable21[DAYS[1],PERIODS[2]]=10) \/ (timetable21[DAYS[1],PERIODS[3]]=10 /\ timetable21[DAYS[1],PERIODS[4]]=10) \/ (timetable21[DAYS[1],PERIODS[5]]=10 /\ timetable21[DAYS[1],PERIODS[6]]=10) \/
(timetable21[DAYS[2],PERIODS[1]]=10 /\ timetable21[DAYS[2],PERIODS[2]]=10) \/ (timetable21[DAYS[2],PERIODS[3]]=10 /\ timetable21[DAYS[2],PERIODS[4]]=10) \/ (timetable21[DAYS[2],PERIODS[5]]=10 /\ timetable21[DAYS[2],PERIODS[6]]=10) \/
(timetable21[DAYS[3],PERIODS[1]]=10 /\ timetable21[DAYS[3],PERIODS[2]]=10) \/ (timetable21[DAYS[3],PERIODS[3]]=10 /\ timetable21[DAYS[3],PERIODS[4]]=10) \/ (timetable21[DAYS[3],PERIODS[5]]=10 /\ timetable21[DAYS[3],PERIODS[6]]=10) \/
(timetable21[DAYS[4],PERIODS[1]]=10 /\ timetable21[DAYS[4],PERIODS[2]]=10) \/ (timetable21[DAYS[4],PERIODS[3]]=10 /\ timetable21[DAYS[4],PERIODS[4]]=10) \/ (timetable21[DAYS[4],PERIODS[5]]=10 /\ timetable21[DAYS[4],PERIODS[6]]=10) \/
(timetable21[DAYS[5],PERIODS[1]]=10 /\ timetable21[DAYS[5],PERIODS[2]]=10) \/ (timetable21[DAYS[5],PERIODS[3]]=10 /\ timetable21[DAYS[5],PERIODS[4]]=10) \/ (timetable21[DAYS[5],PERIODS[5]]=10 /\ timetable21[DAYS[5],PERIODS[6]]=10);

constraint forall(d in DAYS)( forall(c in COURSE2) ( sum( p in PERIODS ) ( timetable22[d,p] = c ) =  checker2[d,c]) );

constraint 
(timetable22[DAYS[1],PERIODS[1]]=7 /\ timetable22[DAYS[1],PERIODS[2]]=7) \/ (timetable22[DAYS[1],PERIODS[3]]=7 /\ timetable22[DAYS[1],PERIODS[4]]=7) \/ (timetable22[DAYS[1],PERIODS[5]]=7 /\ timetable22[DAYS[1],PERIODS[6]]=7) \/ 
(timetable22[DAYS[2],PERIODS[1]]=7 /\ timetable22[DAYS[2],PERIODS[2]]=7) \/ (timetable22[DAYS[2],PERIODS[3]]=7 /\ timetable22[DAYS[2],PERIODS[4]]=7) \/ (timetable22[DAYS[2],PERIODS[5]]=7 /\ timetable22[DAYS[2],PERIODS[6]]=7) \/ 
(timetable22[DAYS[3],PERIODS[1]]=7 /\ timetable22[DAYS[3],PERIODS[2]]=7) \/ (timetable22[DAYS[3],PERIODS[3]]=7 /\ timetable22[DAYS[3],PERIODS[4]]=7) \/ (timetable22[DAYS[3],PERIODS[5]]=7 /\ timetable22[DAYS[3],PERIODS[6]]=7) \/ 
(timetable22[DAYS[4],PERIODS[1]]=7 /\ timetable22[DAYS[4],PERIODS[2]]=7) \/ (timetable22[DAYS[4],PERIODS[3]]=7 /\ timetable22[DAYS[4],PERIODS[4]]=7) \/ (timetable22[DAYS[4],PERIODS[5]]=7 /\ timetable22[DAYS[4],PERIODS[6]]=7) \/
(timetable22[DAYS[5],PERIODS[1]]=7 /\ timetable22[DAYS[5],PERIODS[2]]=7) \/ (timetable22[DAYS[5],PERIODS[3]]=7 /\ timetable22[DAYS[5],PERIODS[4]]=7) \/ (timetable22[DAYS[5],PERIODS[5]]=7 /\ timetable22[DAYS[5],PERIODS[6]]=7);


constraint
(timetable22[DAYS[1],PERIODS[1]]=8 /\ timetable22[DAYS[1],PERIODS[2]]=8) \/ (timetable22[DAYS[1],PERIODS[3]]=8 /\ timetable22[DAYS[1],PERIODS[4]]=8) \/ (timetable22[DAYS[1],PERIODS[5]]=8 /\ timetable22[DAYS[1],PERIODS[6]]=8) \/
(timetable22[DAYS[2],PERIODS[1]]=8 /\ timetable22[DAYS[2],PERIODS[2]]=8) \/ (timetable22[DAYS[2],PERIODS[3]]=8 /\ timetable22[DAYS[2],PERIODS[4]]=8) \/ (timetable22[DAYS[2],PERIODS[5]]=8 /\ timetable22[DAYS[2],PERIODS[6]]=8) \/
(timetable22[DAYS[3],PERIODS[1]]=8 /\ timetable22[DAYS[3],PERIODS[2]]=8) \/ (timetable22[DAYS[3],PERIODS[3]]=8 /\ timetable22[DAYS[3],PERIODS[4]]=8) \/ (timetable22[DAYS[3],PERIODS[5]]=8 /\ timetable22[DAYS[3],PERIODS[6]]=8) \/
(timetable22[DAYS[4],PERIODS[1]]=8 /\ timetable22[DAYS[4],PERIODS[2]]=8) \/ (timetable22[DAYS[4],PERIODS[3]]=8 /\ timetable22[DAYS[4],PERIODS[4]]=8) \/ (timetable22[DAYS[4],PERIODS[5]]=8 /\ timetable22[DAYS[4],PERIODS[6]]=8) \/
(timetable22[DAYS[5],PERIODS[1]]=8 /\ timetable22[DAYS[5],PERIODS[2]]=8) \/ (timetable22[DAYS[5],PERIODS[3]]=8 /\ timetable22[DAYS[5],PERIODS[4]]=8) \/ (timetable22[DAYS[5],PERIODS[5]]=8 /\ timetable22[DAYS[5],PERIODS[6]]=8);

constraint
(timetable22[DAYS[1],PERIODS[1]]=9 /\ timetable22[DAYS[1],PERIODS[2]]=9) \/ (timetable22[DAYS[1],PERIODS[3]]=9 /\ timetable22[DAYS[1],PERIODS[4]]=9) \/ (timetable22[DAYS[1],PERIODS[5]]=9 /\ timetable22[DAYS[1],PERIODS[6]]=9) \/
(timetable22[DAYS[2],PERIODS[1]]=9 /\ timetable22[DAYS[2],PERIODS[2]]=9) \/ (timetable22[DAYS[2],PERIODS[3]]=9 /\ timetable22[DAYS[2],PERIODS[4]]=9) \/ (timetable22[DAYS[2],PERIODS[5]]=9 /\ timetable22[DAYS[2],PERIODS[6]]=9) \/
(timetable22[DAYS[3],PERIODS[1]]=9 /\ timetable22[DAYS[3],PERIODS[2]]=9) \/ (timetable22[DAYS[3],PERIODS[3]]=9 /\ timetable22[DAYS[3],PERIODS[4]]=9) \/ (timetable22[DAYS[3],PERIODS[5]]=9 /\ timetable22[DAYS[3],PERIODS[6]]=9) \/
(timetable22[DAYS[4],PERIODS[1]]=9 /\ timetable22[DAYS[4],PERIODS[2]]=9) \/ (timetable22[DAYS[4],PERIODS[3]]=9 /\ timetable22[DAYS[4],PERIODS[4]]=9) \/ (timetable22[DAYS[4],PERIODS[5]]=9 /\ timetable22[DAYS[4],PERIODS[6]]=9) \/
(timetable22[DAYS[5],PERIODS[1]]=9 /\ timetable22[DAYS[5],PERIODS[2]]=9) \/ (timetable22[DAYS[5],PERIODS[3]]=9 /\ timetable22[DAYS[5],PERIODS[4]]=9) \/ (timetable22[DAYS[5],PERIODS[5]]=9 /\ timetable22[DAYS[5],PERIODS[6]]=9);

constraint
(timetable22[DAYS[1],PERIODS[1]]=10 /\ timetable22[DAYS[1],PERIODS[2]]=10) \/ (timetable22[DAYS[1],PERIODS[3]]=10 /\ timetable22[DAYS[1],PERIODS[4]]=10) \/ (timetable22[DAYS[1],PERIODS[5]]=10 /\ timetable22[DAYS[1],PERIODS[6]]=10) \/
(timetable22[DAYS[2],PERIODS[1]]=10 /\ timetable22[DAYS[2],PERIODS[2]]=10) \/ (timetable22[DAYS[2],PERIODS[3]]=10 /\ timetable22[DAYS[2],PERIODS[4]]=10) \/ (timetable22[DAYS[2],PERIODS[5]]=10 /\ timetable22[DAYS[2],PERIODS[6]]=10) \/
(timetable22[DAYS[3],PERIODS[1]]=10 /\ timetable22[DAYS[3],PERIODS[2]]=10) \/ (timetable22[DAYS[3],PERIODS[3]]=10 /\ timetable22[DAYS[3],PERIODS[4]]=10) \/ (timetable22[DAYS[3],PERIODS[5]]=10 /\ timetable22[DAYS[3],PERIODS[6]]=10) \/
(timetable22[DAYS[4],PERIODS[1]]=10 /\ timetable22[DAYS[4],PERIODS[2]]=10) \/ (timetable22[DAYS[4],PERIODS[3]]=10 /\ timetable22[DAYS[4],PERIODS[4]]=10) \/ (timetable22[DAYS[4],PERIODS[5]]=10 /\ timetable22[DAYS[4],PERIODS[6]]=10) \/
(timetable22[DAYS[5],PERIODS[1]]=10 /\ timetable22[DAYS[5],PERIODS[2]]=10) \/ (timetable22[DAYS[5],PERIODS[3]]=10 /\ timetable22[DAYS[5],PERIODS[4]]=10) \/ (timetable22[DAYS[5],PERIODS[5]]=10 /\ timetable22[DAYS[5],PERIODS[6]]=10);

constraint forall(d in DAYS) ( forall(p in PERIODS) ( if(timetable21[d,p]!=11) then timetable21[d,p]!=timetable22[d,p] endif ));


% Constraints for For Year 3

constraint forall(d in DAYS) (forall(c in COURSE3)(0 <= checker3[d,c] /\ checker3[d,c] <= DAILYPERIODS3[c]) );

constraint forall(d in DAYS) (forall(c in COURSE3)( if DAILYPERIODS3[c] = 2 then ( (checker3[d,c] = 0) \/ (checker3[d,c] = 2) ) endif) );

constraint forall(c in COURSE3)( sum( d in DAYS) (checker3[d,c]) =  TOTALPERIODS3[c]);

constraint forall(d in DAYS)( sum( c in COURSE3) (checker3[d,c]) = 6);

constraint forall(d in DAYS)( sum( c in COURSE3) (checker3[d,c] = 2) <= 2);

constraint forall(d in DAYS) (checker3[d,COURSE3[11]]>=1);

constraint forall(d in DAYS)( forall(c in COURSE3) ( sum( p in PERIODS ) ( timetable31[d,p] = c ) =  checker3[d,c]) );

constraint
(timetable31[DAYS[1],PERIODS[1]]=7 /\ timetable31[DAYS[1],PERIODS[2]]=7) \/ (timetable31[DAYS[1],PERIODS[3]]=7 /\ timetable31[DAYS[1],PERIODS[4]]=7) \/ (timetable31[DAYS[1],PERIODS[5]]=7 /\ timetable31[DAYS[1],PERIODS[6]]=7) \/
(timetable31[DAYS[2],PERIODS[1]]=7 /\ timetable31[DAYS[2],PERIODS[2]]=7) \/ (timetable31[DAYS[2],PERIODS[3]]=7 /\ timetable31[DAYS[2],PERIODS[4]]=7) \/ (timetable31[DAYS[2],PERIODS[5]]=7 /\ timetable31[DAYS[2],PERIODS[6]]=7) \/
(timetable31[DAYS[3],PERIODS[1]]=7 /\ timetable31[DAYS[3],PERIODS[2]]=7) \/ (timetable31[DAYS[3],PERIODS[3]]=7 /\ timetable31[DAYS[3],PERIODS[4]]=7) \/ (timetable31[DAYS[3],PERIODS[5]]=7 /\ timetable31[DAYS[3],PERIODS[6]]=7) \/
(timetable31[DAYS[4],PERIODS[1]]=7 /\ timetable31[DAYS[4],PERIODS[2]]=7) \/ (timetable31[DAYS[4],PERIODS[3]]=7 /\ timetable31[DAYS[4],PERIODS[4]]=7) \/ (timetable31[DAYS[4],PERIODS[5]]=7 /\ timetable31[DAYS[4],PERIODS[6]]=7) \/
(timetable31[DAYS[5],PERIODS[1]]=7 /\ timetable31[DAYS[5],PERIODS[2]]=7) \/ (timetable31[DAYS[5],PERIODS[3]]=7 /\ timetable31[DAYS[5],PERIODS[4]]=7) \/ (timetable31[DAYS[5],PERIODS[5]]=7 /\ timetable31[DAYS[5],PERIODS[6]]=7);

constraint
(timetable31[DAYS[1],PERIODS[1]]=8 /\ timetable31[DAYS[1],PERIODS[2]]=8) \/ (timetable31[DAYS[1],PERIODS[3]]=8 /\ timetable31[DAYS[1],PERIODS[4]]=8) \/ (timetable31[DAYS[1],PERIODS[5]]=8 /\ timetable31[DAYS[1],PERIODS[6]]=8) \/
(timetable31[DAYS[2],PERIODS[1]]=8 /\ timetable31[DAYS[2],PERIODS[2]]=8) \/ (timetable31[DAYS[2],PERIODS[3]]=8 /\ timetable31[DAYS[2],PERIODS[4]]=8) \/ (timetable31[DAYS[2],PERIODS[5]]=8 /\ timetable31[DAYS[2],PERIODS[6]]=8) \/
(timetable31[DAYS[3],PERIODS[1]]=8 /\ timetable31[DAYS[3],PERIODS[2]]=8) \/ (timetable31[DAYS[3],PERIODS[3]]=8 /\ timetable31[DAYS[3],PERIODS[4]]=8) \/ (timetable31[DAYS[3],PERIODS[5]]=8 /\ timetable31[DAYS[3],PERIODS[6]]=8) \/
(timetable31[DAYS[4],PERIODS[1]]=8 /\ timetable31[DAYS[4],PERIODS[2]]=8) \/ (timetable31[DAYS[4],PERIODS[3]]=8 /\ timetable31[DAYS[4],PERIODS[4]]=8) \/ (timetable31[DAYS[4],PERIODS[5]]=8 /\ timetable31[DAYS[4],PERIODS[6]]=8) \/
(timetable31[DAYS[5],PERIODS[1]]=8 /\ timetable31[DAYS[5],PERIODS[2]]=8) \/ (timetable31[DAYS[5],PERIODS[3]]=8 /\ timetable31[DAYS[5],PERIODS[4]]=8) \/ (timetable31[DAYS[5],PERIODS[5]]=8 /\ timetable31[DAYS[5],PERIODS[6]]=8);

constraint
(timetable31[DAYS[1],PERIODS[1]]=9 /\ timetable31[DAYS[1],PERIODS[2]]=9) \/ (timetable31[DAYS[1],PERIODS[3]]=9 /\ timetable31[DAYS[1],PERIODS[4]]=9) \/ (timetable31[DAYS[1],PERIODS[5]]=9 /\ timetable31[DAYS[1],PERIODS[6]]=9) \/
(timetable31[DAYS[2],PERIODS[1]]=9 /\ timetable31[DAYS[2],PERIODS[2]]=9) \/ (timetable31[DAYS[2],PERIODS[3]]=9 /\ timetable31[DAYS[2],PERIODS[4]]=9) \/ (timetable31[DAYS[2],PERIODS[5]]=9 /\ timetable31[DAYS[2],PERIODS[6]]=9) \/
(timetable31[DAYS[3],PERIODS[1]]=9 /\ timetable31[DAYS[3],PERIODS[2]]=9) \/ (timetable31[DAYS[3],PERIODS[3]]=9 /\ timetable31[DAYS[3],PERIODS[4]]=9) \/ (timetable31[DAYS[3],PERIODS[5]]=9 /\ timetable31[DAYS[3],PERIODS[6]]=9) \/
(timetable31[DAYS[4],PERIODS[1]]=9 /\ timetable31[DAYS[4],PERIODS[2]]=9) \/ (timetable31[DAYS[4],PERIODS[3]]=9 /\ timetable31[DAYS[4],PERIODS[4]]=9) \/ (timetable31[DAYS[4],PERIODS[5]]=9 /\ timetable31[DAYS[4],PERIODS[6]]=9) \/
(timetable31[DAYS[5],PERIODS[1]]=9 /\ timetable31[DAYS[5],PERIODS[2]]=9) \/ (timetable31[DAYS[5],PERIODS[3]]=9 /\ timetable31[DAYS[5],PERIODS[4]]=9) \/ (timetable31[DAYS[5],PERIODS[5]]=9 /\ timetable31[DAYS[5],PERIODS[6]]=9);

constraint
(timetable31[DAYS[1],PERIODS[1]]=10 /\ timetable31[DAYS[1],PERIODS[2]]=10) \/ (timetable31[DAYS[1],PERIODS[3]]=10 /\ timetable31[DAYS[1],PERIODS[4]]=10) \/ (timetable31[DAYS[1],PERIODS[5]]=10 /\ timetable31[DAYS[1],PERIODS[6]]=10) \/
(timetable31[DAYS[2],PERIODS[1]]=10 /\ timetable31[DAYS[2],PERIODS[2]]=10) \/ (timetable31[DAYS[2],PERIODS[3]]=10 /\ timetable31[DAYS[2],PERIODS[4]]=10) \/ (timetable31[DAYS[2],PERIODS[5]]=10 /\ timetable31[DAYS[2],PERIODS[6]]=10) \/
(timetable31[DAYS[3],PERIODS[1]]=10 /\ timetable31[DAYS[3],PERIODS[2]]=10) \/ (timetable31[DAYS[3],PERIODS[3]]=10 /\ timetable31[DAYS[3],PERIODS[4]]=10) \/ (timetable31[DAYS[3],PERIODS[5]]=10 /\ timetable31[DAYS[3],PERIODS[6]]=10) \/
(timetable31[DAYS[4],PERIODS[1]]=10 /\ timetable31[DAYS[4],PERIODS[2]]=10) \/ (timetable31[DAYS[4],PERIODS[3]]=10 /\ timetable31[DAYS[4],PERIODS[4]]=10) \/ (timetable31[DAYS[4],PERIODS[5]]=10 /\ timetable31[DAYS[4],PERIODS[6]]=10) \/
(timetable31[DAYS[5],PERIODS[1]]=10 /\ timetable31[DAYS[5],PERIODS[2]]=10) \/ (timetable31[DAYS[5],PERIODS[3]]=10 /\ timetable31[DAYS[5],PERIODS[4]]=10) \/ (timetable31[DAYS[5],PERIODS[5]]=10 /\ timetable31[DAYS[5],PERIODS[6]]=10);

constraint forall(d in DAYS)( forall(c in COURSE3) ( sum( p in PERIODS ) ( timetable32[d,p] = c ) =  checker3[d,c]) );

constraint
(timetable32[DAYS[1],PERIODS[1]]=7 /\ timetable32[DAYS[1],PERIODS[2]]=7) \/ (timetable32[DAYS[1],PERIODS[3]]=7 /\ timetable32[DAYS[1],PERIODS[4]]=7) \/ (timetable32[DAYS[1],PERIODS[5]]=7 /\ timetable32[DAYS[1],PERIODS[6]]=7) \/
(timetable32[DAYS[2],PERIODS[1]]=7 /\ timetable32[DAYS[2],PERIODS[2]]=7) \/ (timetable32[DAYS[2],PERIODS[3]]=7 /\ timetable32[DAYS[2],PERIODS[4]]=7) \/ (timetable32[DAYS[2],PERIODS[5]]=7 /\ timetable32[DAYS[2],PERIODS[6]]=7) \/
(timetable32[DAYS[3],PERIODS[1]]=7 /\ timetable32[DAYS[3],PERIODS[2]]=7) \/ (timetable32[DAYS[3],PERIODS[3]]=7 /\ timetable32[DAYS[3],PERIODS[4]]=7) \/ (timetable32[DAYS[3],PERIODS[5]]=7 /\ timetable32[DAYS[3],PERIODS[6]]=7) \/
(timetable32[DAYS[4],PERIODS[1]]=7 /\ timetable32[DAYS[4],PERIODS[2]]=7) \/ (timetable32[DAYS[4],PERIODS[3]]=7 /\ timetable32[DAYS[4],PERIODS[4]]=7) \/ (timetable32[DAYS[4],PERIODS[5]]=7 /\ timetable32[DAYS[4],PERIODS[6]]=7) \/
(timetable32[DAYS[5],PERIODS[1]]=7 /\ timetable32[DAYS[5],PERIODS[2]]=7) \/ (timetable32[DAYS[5],PERIODS[3]]=7 /\ timetable32[DAYS[5],PERIODS[4]]=7) \/ (timetable32[DAYS[5],PERIODS[5]]=7 /\ timetable32[DAYS[5],PERIODS[6]]=7);


constraint
(timetable32[DAYS[1],PERIODS[1]]=8 /\ timetable32[DAYS[1],PERIODS[2]]=8) \/ (timetable32[DAYS[1],PERIODS[3]]=8 /\ timetable32[DAYS[1],PERIODS[4]]=8) \/ (timetable32[DAYS[1],PERIODS[5]]=8 /\ timetable32[DAYS[1],PERIODS[6]]=8) \/
(timetable32[DAYS[2],PERIODS[1]]=8 /\ timetable32[DAYS[2],PERIODS[2]]=8) \/ (timetable32[DAYS[2],PERIODS[3]]=8 /\ timetable32[DAYS[2],PERIODS[4]]=8) \/ (timetable32[DAYS[2],PERIODS[5]]=8 /\ timetable32[DAYS[2],PERIODS[6]]=8) \/
(timetable32[DAYS[3],PERIODS[1]]=8 /\ timetable32[DAYS[3],PERIODS[2]]=8) \/ (timetable32[DAYS[3],PERIODS[3]]=8 /\ timetable32[DAYS[3],PERIODS[4]]=8) \/ (timetable32[DAYS[3],PERIODS[5]]=8 /\ timetable32[DAYS[3],PERIODS[6]]=8) \/
(timetable32[DAYS[4],PERIODS[1]]=8 /\ timetable32[DAYS[4],PERIODS[2]]=8) \/ (timetable32[DAYS[4],PERIODS[3]]=8 /\ timetable32[DAYS[4],PERIODS[4]]=8) \/ (timetable32[DAYS[4],PERIODS[5]]=8 /\ timetable32[DAYS[4],PERIODS[6]]=8) \/
(timetable32[DAYS[5],PERIODS[1]]=8 /\ timetable32[DAYS[5],PERIODS[2]]=8) \/ (timetable32[DAYS[5],PERIODS[3]]=8 /\ timetable32[DAYS[5],PERIODS[4]]=8) \/ (timetable32[DAYS[5],PERIODS[5]]=8 /\ timetable32[DAYS[5],PERIODS[6]]=8);

constraint
(timetable32[DAYS[1],PERIODS[1]]=9 /\ timetable32[DAYS[1],PERIODS[2]]=9) \/ (timetable32[DAYS[1],PERIODS[3]]=9 /\ timetable32[DAYS[1],PERIODS[4]]=9) \/ (timetable32[DAYS[1],PERIODS[5]]=9 /\ timetable32[DAYS[1],PERIODS[6]]=9) \/
(timetable32[DAYS[2],PERIODS[1]]=9 /\ timetable32[DAYS[2],PERIODS[2]]=9) \/ (timetable32[DAYS[2],PERIODS[3]]=9 /\ timetable32[DAYS[2],PERIODS[4]]=9) \/ (timetable32[DAYS[2],PERIODS[5]]=9 /\ timetable32[DAYS[2],PERIODS[6]]=9) \/
(timetable32[DAYS[3],PERIODS[1]]=9 /\ timetable32[DAYS[3],PERIODS[2]]=9) \/ (timetable32[DAYS[3],PERIODS[3]]=9 /\ timetable32[DAYS[3],PERIODS[4]]=9) \/ (timetable32[DAYS[3],PERIODS[5]]=9 /\ timetable32[DAYS[3],PERIODS[6]]=9) \/
(timetable32[DAYS[4],PERIODS[1]]=9 /\ timetable32[DAYS[4],PERIODS[2]]=9) \/ (timetable32[DAYS[4],PERIODS[3]]=9 /\ timetable32[DAYS[4],PERIODS[4]]=9) \/ (timetable32[DAYS[4],PERIODS[5]]=9 /\ timetable32[DAYS[4],PERIODS[6]]=9) \/
(timetable32[DAYS[5],PERIODS[1]]=9 /\ timetable32[DAYS[5],PERIODS[2]]=9) \/ (timetable32[DAYS[5],PERIODS[3]]=9 /\ timetable32[DAYS[5],PERIODS[4]]=9) \/ (timetable32[DAYS[5],PERIODS[5]]=9 /\ timetable32[DAYS[5],PERIODS[6]]=9);

constraint
(timetable32[DAYS[1],PERIODS[1]]=10 /\ timetable32[DAYS[1],PERIODS[2]]=10) \/ (timetable32[DAYS[1],PERIODS[3]]=10 /\ timetable32[DAYS[1],PERIODS[4]]=10) \/ (timetable32[DAYS[1],PERIODS[5]]=10 /\ timetable32[DAYS[1],PERIODS[6]]=10) \/
(timetable32[DAYS[2],PERIODS[1]]=10 /\ timetable32[DAYS[2],PERIODS[2]]=10) \/ (timetable32[DAYS[2],PERIODS[3]]=10 /\ timetable32[DAYS[2],PERIODS[4]]=10) \/ (timetable32[DAYS[2],PERIODS[5]]=10 /\ timetable32[DAYS[2],PERIODS[6]]=10) \/
(timetable32[DAYS[3],PERIODS[1]]=10 /\ timetable32[DAYS[3],PERIODS[2]]=10) \/ (timetable32[DAYS[3],PERIODS[3]]=10 /\ timetable32[DAYS[3],PERIODS[4]]=10) \/ (timetable32[DAYS[3],PERIODS[5]]=10 /\ timetable32[DAYS[3],PERIODS[6]]=10) \/
(timetable32[DAYS[4],PERIODS[1]]=10 /\ timetable32[DAYS[4],PERIODS[2]]=10) \/ (timetable32[DAYS[4],PERIODS[3]]=10 /\ timetable32[DAYS[4],PERIODS[4]]=10) \/ (timetable32[DAYS[4],PERIODS[5]]=10 /\ timetable32[DAYS[4],PERIODS[6]]=10) \/
(timetable32[DAYS[5],PERIODS[1]]=10 /\ timetable32[DAYS[5],PERIODS[2]]=10) \/ (timetable32[DAYS[5],PERIODS[3]]=10 /\ timetable32[DAYS[5],PERIODS[4]]=10) \/ (timetable32[DAYS[5],PERIODS[5]]=10 /\ timetable32[DAYS[5],PERIODS[6]]=10);

constraint forall(d in DAYS) ( forall(p in PERIODS) ( if(timetable31[d,p]!=11) then timetable31[d,p]!=timetable32[d,p] endif ));


% Constraints for For Year 4

constraint forall(d in DAYS) (forall(c in COURSE4)(0 <= checker4[d,c] /\ checker4[d,c] <= DAILYPERIODS4[c]) );

constraint forall(d in DAYS) (forall(c in COURSE4)( if DAILYPERIODS4[c] = 2 then ( (checker4[d,c] = 0) \/ (checker4[d,c] = 2) ) endif) );

constraint forall(c in COURSE4)( sum( d in DAYS) (checker4[d,c]) =  TOTALPERIODS4[c]);

constraint forall(d in DAYS)( sum( c in COURSE4) (checker4[d,c]) = 6);

constraint forall(d in DAYS)( sum( c in COURSE4) (checker4[d,c] = 2) <= 2);

constraint forall(d in DAYS) (checker4[d,COURSE4[10]]>=1);

constraint forall(d in DAYS)( forall(c in COURSE4) ( sum( p in PERIODS ) ( timetable41[d,p] = c ) =  checker4[d,c]) );

constraint
(timetable41[DAYS[1],PERIODS[1]]=7 /\ timetable41[DAYS[1],PERIODS[2]]=7) \/ (timetable41[DAYS[1],PERIODS[3]]=7 /\ timetable41[DAYS[1],PERIODS[4]]=7) \/ (timetable41[DAYS[1],PERIODS[5]]=7 /\ timetable41[DAYS[1],PERIODS[6]]=7) \/
(timetable41[DAYS[2],PERIODS[1]]=7 /\ timetable41[DAYS[2],PERIODS[2]]=7) \/ (timetable41[DAYS[2],PERIODS[3]]=7 /\ timetable41[DAYS[2],PERIODS[4]]=7) \/ (timetable41[DAYS[2],PERIODS[5]]=7 /\ timetable41[DAYS[2],PERIODS[6]]=7) \/
(timetable41[DAYS[3],PERIODS[1]]=7 /\ timetable41[DAYS[3],PERIODS[2]]=7) \/ (timetable41[DAYS[3],PERIODS[3]]=7 /\ timetable41[DAYS[3],PERIODS[4]]=7) \/ (timetable41[DAYS[3],PERIODS[5]]=7 /\ timetable41[DAYS[3],PERIODS[6]]=7) \/
(timetable41[DAYS[4],PERIODS[1]]=7 /\ timetable41[DAYS[4],PERIODS[2]]=7) \/ (timetable41[DAYS[4],PERIODS[3]]=7 /\ timetable41[DAYS[4],PERIODS[4]]=7) \/ (timetable41[DAYS[4],PERIODS[5]]=7 /\ timetable41[DAYS[4],PERIODS[6]]=7) \/
(timetable41[DAYS[5],PERIODS[1]]=7 /\ timetable41[DAYS[5],PERIODS[2]]=7) \/ (timetable41[DAYS[5],PERIODS[3]]=7 /\ timetable41[DAYS[5],PERIODS[4]]=7) \/ (timetable41[DAYS[5],PERIODS[5]]=7 /\ timetable41[DAYS[5],PERIODS[6]]=7);

constraint
(timetable41[DAYS[1],PERIODS[1]]=8 /\ timetable41[DAYS[1],PERIODS[2]]=8) \/ (timetable41[DAYS[1],PERIODS[3]]=8 /\ timetable41[DAYS[1],PERIODS[4]]=8) \/ (timetable41[DAYS[1],PERIODS[5]]=8 /\ timetable41[DAYS[1],PERIODS[6]]=8) \/
(timetable41[DAYS[2],PERIODS[1]]=8 /\ timetable41[DAYS[2],PERIODS[2]]=8) \/ (timetable41[DAYS[2],PERIODS[3]]=8 /\ timetable41[DAYS[2],PERIODS[4]]=8) \/ (timetable41[DAYS[2],PERIODS[5]]=8 /\ timetable41[DAYS[2],PERIODS[6]]=8) \/
(timetable41[DAYS[3],PERIODS[1]]=8 /\ timetable41[DAYS[3],PERIODS[2]]=8) \/ (timetable41[DAYS[3],PERIODS[3]]=8 /\ timetable41[DAYS[3],PERIODS[4]]=8) \/ (timetable41[DAYS[3],PERIODS[5]]=8 /\ timetable41[DAYS[3],PERIODS[6]]=8) \/
(timetable41[DAYS[4],PERIODS[1]]=8 /\ timetable41[DAYS[4],PERIODS[2]]=8) \/ (timetable41[DAYS[4],PERIODS[3]]=8 /\ timetable41[DAYS[4],PERIODS[4]]=8) \/ (timetable41[DAYS[4],PERIODS[5]]=8 /\ timetable41[DAYS[4],PERIODS[6]]=8) \/
(timetable41[DAYS[5],PERIODS[1]]=8 /\ timetable41[DAYS[5],PERIODS[2]]=8) \/ (timetable41[DAYS[5],PERIODS[3]]=8 /\ timetable41[DAYS[5],PERIODS[4]]=8) \/ (timetable41[DAYS[5],PERIODS[5]]=8 /\ timetable41[DAYS[5],PERIODS[6]]=8);

constraint
(timetable41[DAYS[1],PERIODS[1]]=9 /\ timetable41[DAYS[1],PERIODS[2]]=9) \/ (timetable41[DAYS[1],PERIODS[3]]=9 /\ timetable41[DAYS[1],PERIODS[4]]=9) \/ (timetable41[DAYS[1],PERIODS[5]]=9 /\ timetable41[DAYS[1],PERIODS[6]]=9) \/
(timetable41[DAYS[2],PERIODS[1]]=9 /\ timetable41[DAYS[2],PERIODS[2]]=9) \/ (timetable41[DAYS[2],PERIODS[3]]=9 /\ timetable41[DAYS[2],PERIODS[4]]=9) \/ (timetable41[DAYS[2],PERIODS[5]]=9 /\ timetable41[DAYS[2],PERIODS[6]]=9) \/
(timetable41[DAYS[3],PERIODS[1]]=9 /\ timetable41[DAYS[3],PERIODS[2]]=9) \/ (timetable41[DAYS[3],PERIODS[3]]=9 /\ timetable41[DAYS[3],PERIODS[4]]=9) \/ (timetable41[DAYS[3],PERIODS[5]]=9 /\ timetable41[DAYS[3],PERIODS[6]]=9) \/
(timetable41[DAYS[4],PERIODS[1]]=9 /\ timetable41[DAYS[4],PERIODS[2]]=9) \/ (timetable41[DAYS[4],PERIODS[3]]=9 /\ timetable41[DAYS[4],PERIODS[4]]=9) \/ (timetable41[DAYS[4],PERIODS[5]]=9 /\ timetable41[DAYS[4],PERIODS[6]]=9) \/
(timetable41[DAYS[5],PERIODS[1]]=9 /\ timetable41[DAYS[5],PERIODS[2]]=9) \/ (timetable41[DAYS[5],PERIODS[3]]=9 /\ timetable41[DAYS[5],PERIODS[4]]=9) \/ (timetable41[DAYS[5],PERIODS[5]]=9 /\ timetable41[DAYS[5],PERIODS[6]]=9);

constraint
(timetable41[DAYS[1],PERIODS[1]]=10 /\ timetable41[DAYS[1],PERIODS[2]]=10) \/ (timetable41[DAYS[1],PERIODS[3]]=10 /\ timetable41[DAYS[1],PERIODS[4]]=10) \/ (timetable41[DAYS[1],PERIODS[5]]=10 /\ timetable41[DAYS[1],PERIODS[6]]=10) \/
(timetable41[DAYS[2],PERIODS[1]]=10 /\ timetable41[DAYS[2],PERIODS[2]]=10) \/ (timetable41[DAYS[2],PERIODS[3]]=10 /\ timetable41[DAYS[2],PERIODS[4]]=10) \/ (timetable41[DAYS[2],PERIODS[5]]=10 /\ timetable41[DAYS[2],PERIODS[6]]=10) \/
(timetable41[DAYS[3],PERIODS[1]]=10 /\ timetable41[DAYS[3],PERIODS[2]]=10) \/ (timetable41[DAYS[3],PERIODS[3]]=10 /\ timetable41[DAYS[3],PERIODS[4]]=10) \/ (timetable41[DAYS[3],PERIODS[5]]=10 /\ timetable41[DAYS[3],PERIODS[6]]=10) \/
(timetable41[DAYS[4],PERIODS[1]]=10 /\ timetable41[DAYS[4],PERIODS[2]]=10) \/ (timetable41[DAYS[4],PERIODS[3]]=10 /\ timetable41[DAYS[4],PERIODS[4]]=10) \/ (timetable41[DAYS[4],PERIODS[5]]=10 /\ timetable41[DAYS[4],PERIODS[6]]=10) \/
(timetable41[DAYS[5],PERIODS[1]]=10 /\ timetable41[DAYS[5],PERIODS[2]]=10) \/ (timetable41[DAYS[5],PERIODS[3]]=10 /\ timetable41[DAYS[5],PERIODS[4]]=10) \/ (timetable41[DAYS[5],PERIODS[5]]=10 /\ timetable41[DAYS[5],PERIODS[6]]=10);

constraint forall(d in DAYS)( forall(c in COURSE4) ( sum( p in PERIODS ) ( timetable42[d,p] = c ) =  checker4[d,c]) );

constraint
(timetable42[DAYS[1],PERIODS[1]]=7 /\ timetable42[DAYS[1],PERIODS[2]]=7) \/ (timetable42[DAYS[1],PERIODS[3]]=7 /\ timetable42[DAYS[1],PERIODS[4]]=7) \/ (timetable42[DAYS[1],PERIODS[5]]=7 /\ timetable42[DAYS[1],PERIODS[6]]=7) \/
(timetable42[DAYS[2],PERIODS[1]]=7 /\ timetable42[DAYS[2],PERIODS[2]]=7) \/ (timetable42[DAYS[2],PERIODS[3]]=7 /\ timetable42[DAYS[2],PERIODS[4]]=7) \/ (timetable42[DAYS[2],PERIODS[5]]=7 /\ timetable42[DAYS[2],PERIODS[6]]=7) \/
(timetable42[DAYS[3],PERIODS[1]]=7 /\ timetable42[DAYS[3],PERIODS[2]]=7) \/ (timetable42[DAYS[3],PERIODS[3]]=7 /\ timetable42[DAYS[3],PERIODS[4]]=7) \/ (timetable42[DAYS[3],PERIODS[5]]=7 /\ timetable42[DAYS[3],PERIODS[6]]=7) \/
(timetable42[DAYS[4],PERIODS[1]]=7 /\ timetable42[DAYS[4],PERIODS[2]]=7) \/ (timetable42[DAYS[4],PERIODS[3]]=7 /\ timetable42[DAYS[4],PERIODS[4]]=7) \/ (timetable42[DAYS[4],PERIODS[5]]=7 /\ timetable42[DAYS[4],PERIODS[6]]=7) \/
(timetable42[DAYS[5],PERIODS[1]]=7 /\ timetable42[DAYS[5],PERIODS[2]]=7) \/ (timetable42[DAYS[5],PERIODS[3]]=7 /\ timetable42[DAYS[5],PERIODS[4]]=7) \/ (timetable42[DAYS[5],PERIODS[5]]=7 /\ timetable42[DAYS[5],PERIODS[6]]=7);


constraint
(timetable42[DAYS[1],PERIODS[1]]=8 /\ timetable42[DAYS[1],PERIODS[2]]=8) \/ (timetable42[DAYS[1],PERIODS[3]]=8 /\ timetable42[DAYS[1],PERIODS[4]]=8) \/ (timetable42[DAYS[1],PERIODS[5]]=8 /\ timetable42[DAYS[1],PERIODS[6]]=8) \/
(timetable42[DAYS[2],PERIODS[1]]=8 /\ timetable42[DAYS[2],PERIODS[2]]=8) \/ (timetable42[DAYS[2],PERIODS[3]]=8 /\ timetable42[DAYS[2],PERIODS[4]]=8) \/ (timetable42[DAYS[2],PERIODS[5]]=8 /\ timetable42[DAYS[2],PERIODS[6]]=8) \/
(timetable42[DAYS[3],PERIODS[1]]=8 /\ timetable42[DAYS[3],PERIODS[2]]=8) \/ (timetable42[DAYS[3],PERIODS[3]]=8 /\ timetable42[DAYS[3],PERIODS[4]]=8) \/ (timetable42[DAYS[3],PERIODS[5]]=8 /\ timetable42[DAYS[3],PERIODS[6]]=8) \/
(timetable42[DAYS[4],PERIODS[1]]=8 /\ timetable42[DAYS[4],PERIODS[2]]=8) \/ (timetable42[DAYS[4],PERIODS[3]]=8 /\ timetable42[DAYS[4],PERIODS[4]]=8) \/ (timetable42[DAYS[4],PERIODS[5]]=8 /\ timetable42[DAYS[4],PERIODS[6]]=8) \/
(timetable42[DAYS[5],PERIODS[1]]=8 /\ timetable42[DAYS[5],PERIODS[2]]=8) \/ (timetable42[DAYS[5],PERIODS[3]]=8 /\ timetable42[DAYS[5],PERIODS[4]]=8) \/ (timetable42[DAYS[5],PERIODS[5]]=8 /\ timetable42[DAYS[5],PERIODS[6]]=8);

constraint
(timetable42[DAYS[1],PERIODS[1]]=9 /\ timetable42[DAYS[1],PERIODS[2]]=9) \/ (timetable42[DAYS[1],PERIODS[3]]=9 /\ timetable42[DAYS[1],PERIODS[4]]=9) \/ (timetable42[DAYS[1],PERIODS[5]]=9 /\ timetable42[DAYS[1],PERIODS[6]]=9) \/
(timetable42[DAYS[2],PERIODS[1]]=9 /\ timetable42[DAYS[2],PERIODS[2]]=9) \/ (timetable42[DAYS[2],PERIODS[3]]=9 /\ timetable42[DAYS[2],PERIODS[4]]=9) \/ (timetable42[DAYS[2],PERIODS[5]]=9 /\ timetable42[DAYS[2],PERIODS[6]]=9) \/
(timetable42[DAYS[3],PERIODS[1]]=9 /\ timetable42[DAYS[3],PERIODS[2]]=9) \/ (timetable42[DAYS[3],PERIODS[3]]=9 /\ timetable42[DAYS[3],PERIODS[4]]=9) \/ (timetable42[DAYS[3],PERIODS[5]]=9 /\ timetable42[DAYS[3],PERIODS[6]]=9) \/
(timetable42[DAYS[4],PERIODS[1]]=9 /\ timetable42[DAYS[4],PERIODS[2]]=9) \/ (timetable42[DAYS[4],PERIODS[3]]=9 /\ timetable42[DAYS[4],PERIODS[4]]=9) \/ (timetable42[DAYS[4],PERIODS[5]]=9 /\ timetable42[DAYS[4],PERIODS[6]]=9) \/
(timetable42[DAYS[5],PERIODS[1]]=9 /\ timetable42[DAYS[5],PERIODS[2]]=9) \/ (timetable42[DAYS[5],PERIODS[3]]=9 /\ timetable42[DAYS[5],PERIODS[4]]=9) \/ (timetable42[DAYS[5],PERIODS[5]]=9 /\ timetable42[DAYS[5],PERIODS[6]]=9);

constraint forall(d in DAYS) ( forall(p in PERIODS) ( if(timetable41[d,p]!=11) then timetable41[d,p]!=timetable42[d,p] endif ));

%common constraint for all 
%CS10: This constraint is to check if we can allocate every period of everyday of every section of every semester within my allocated rooms
constraint forall(d in DAYS) ( forall(p in PERIODS) ( ((timetable11[d,p] != 11) + (timetable12[d,p] != 11) + (timetable21[d,p] != 11) + (timetable22[d,p] != 11) + (timetable31[d,p] != 11) + (timetable32[d,p] != 11) + (timetable41[d,p] != 10) + (timetable42[d,p] != 10)) <= NUMROOM ) );

%CS11: We can fix the class for a particular required course on a particular period of a particular day 
constraint timetable42[DAYS[3],PERIODS[1]]=3;


%objective
solve satisfy; 

%1st Year

%output 
output["Winter Semester\n"];
output["First Semester Section A\n"];
output["DOP | "];
output["\(p)  "| p in PERIODS];
output["PERIOD7"];
output["\n==================================================================="];
output [
  if p = 1 then "\n\(d) |" else " " endif ++
  if p = 5 then " BRKTIME  " else " " endif ++ 
  show(timetable11[d,p]) | d in DAYS,p in PERIODS
];

output["\n\n"];
output["First Semester Section B\n"];
output["DOP | "];
output["\(p)  "| p in PERIODS];
output["PERIOD7"];
output["\n==================================================================="];
output [
  if p = 1 then "\n\(d) |" else " " endif ++
  if p = 5 then " BRKTIME  " else " " endif ++ 
     show(timetable12[d,p])
  | d in DAYS,p in PERIODS 
];

%2nd Year

output["\n\n"];
output["Third Semester Section A\n"];
output["DOP | "];
output["\(p)  "| p in PERIODS];
output["PERIOD7"];
output["\n==================================================================="];
output [
  if p = 1 then "\n\(d) |" else " " endif ++
  if p = 5 then " BRKTIME  " else " " endif ++
     show(timetable21[d,p])
  | d in DAYS,p in PERIODS 
];

output["\n\n"];
output["Third Semester Section B\n"];
output["DOP | "];
output["\(p)  "| p in PERIODS];
output["PERIOD7"];
output["\n==================================================================="];
output [
  if p = 1 then "\n\(d) |" else " " endif ++
  if p = 5 then " BRKTIME  " else " " endif ++
     show(timetable22[d,p])
  | d in DAYS,p in PERIODS 
];

%3rd Year

output["\n\n"];
output["Fifth Semester Section A\n"];
output["DOP | "];
output["\(p)  "| p in PERIODS];
output["PERIOD7"];
output["\n==================================================================="];
output [
  if p = 1 then "\n\(d) |" else " " endif ++
  if p = 5 then " BRKTIME  " else " " endif ++
     show(timetable31[d,p])
  | d in DAYS,p in PERIODS 
];

output["\n\n"];
output["Fifth Semester Section B\n"];
output["DOP | "];
output["\(p)  "| p in PERIODS];
output["PERIOD7"];
output["\n==================================================================="];
output [
  if p = 1 then "\n\(d) |" else " " endif ++
  if p = 5 then " BRKTIME  " else " " endif ++
     show(timetable32[d,p])
  | d in DAYS,p in PERIODS 
];

%4th Year

output["\n\n"];
output["Seventh Semester Section A\n"];
output["DOP | "];
output["\(p)  "| p in PERIODS];
output["PERIOD7"];
output["\n==================================================================="];
output [
  if p = 1 then "\n\(d) |" else " " endif ++
  if p = 5 then " BRKTIME  " else " " endif ++
     show(timetable41[d,p])
  | d in DAYS,p in PERIODS 
];

output["\n\n"];
output["Seventh Semester Section B\n"];
output["DOP | "];
output["\(p)  "| p in PERIODS];
output["PERIOD7"];
output["\n==================================================================="];

output [
  if p = 1 then "\n\(d) |" else " " endif ++
  if p = 5 then " BRKTIME  " else " " endif ++
     show(timetable42[d,p])
  | d in DAYS,p in PERIODS 
];            
