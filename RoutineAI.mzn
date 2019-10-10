include "globals.mzn";
include "alldifferent.mzn";

enum COURSE1;
enum COURSE2;
enum COURSE3;
enum COURSE4;

enum PERIODS;
enum ROOMS;
enum DAYS;
int : NUMROOM;
int : NUMTEACHER;

array[COURSE1] of int : DAILYPERIODS1;
array[COURSE1] of int : TOTALPERIODS1;

array[COURSE2] of int : DAILYPERIODS2;
array[COURSE2] of int : TOTALPERIODS2;

array[COURSE3] of int : DAILYPERIODS3;
array[COURSE3] of int : TOTALPERIODS3;

array[COURSE4] of int : DAILYPERIODS4;
array[COURSE4] of int : TOTALPERIODS4;

array[DAYS,PERIODS] of var COURSE1 : timetable1;
array[DAYS,PERIODS] of var COURSE2 : timetable2;
array[DAYS,PERIODS] of var COURSE3 : timetable3;
array[DAYS,PERIODS] of var COURSE4 : timetable4;
%array[DAYS,PERIODS] of var

array[DAYS,COURSE1] of var int : checker1;
array[DAYS,COURSE2] of var int : checker2;
array[DAYS,COURSE3] of var int : checker3;
array[DAYS,COURSE4] of var int : checker4;

% Constraints for For Year 1

constraint forall(d in DAYS) (forall(c in COURSE1)(0 <= checker1[d,c] /\ checker1[d,c] <= DAILYPERIODS1[c]) );

constraint forall(d in DAYS) (forall(c in COURSE1)( if DAILYPERIODS1[c] = 2 then ( (checker1[d,c] = 0) \/ (checker1[d,c] = 2) ) endif) );

constraint forall(c in COURSE1)( sum( d in DAYS) (checker1[d,c]) =  TOTALPERIODS1[c]);

constraint forall(d in DAYS)( sum( c in COURSE1) (checker1[d,c]) = 6);

constraint forall(d in DAYS)( sum( c in COURSE1) (checker1[d,c] = 2) <= 2);

constraint forall(d in DAYS)( forall(c in COURSE1) ( sum( p in PERIODS ) ( timetable1[d,p] = c ) =  checker1[d,c]) );

% Constraints for For Year 2

constraint forall(d in DAYS) (forall(c in COURSE2)(0 <= checker2[d,c] /\ checker2[d,c] <= DAILYPERIODS2[c]) );

constraint forall(d in DAYS) (forall(c in COURSE2)( if DAILYPERIODS2[c] = 2 then ( (checker2[d,c] = 0) \/ (checker2[d,c] = 2) ) endif) );

constraint forall(c in COURSE2)( sum( d in DAYS) (checker2[d,c]) =  TOTALPERIODS2[c]);

constraint forall(d in DAYS)( sum( c in COURSE2) (checker2[d,c]) = 6);

constraint forall(d in DAYS)( sum( c in COURSE2) (checker2[d,c] = 2) <= 2);

constraint forall(d in DAYS)( forall(c in COURSE2) ( sum( p in PERIODS ) ( timetable2[d,p] = c ) =  checker2[d,c]) );

% Constraints for For Year 3

constraint forall(d in DAYS) (forall(c in COURSE3)(0 <= checker3[d,c] /\ checker3[d,c] <= DAILYPERIODS3[c]) );

constraint forall(d in DAYS) (forall(c in COURSE3)( if DAILYPERIODS3[c] = 2 then ( (checker3[d,c] = 0) \/ (checker3[d,c] = 2) ) endif) );

constraint forall(c in COURSE3)( sum( d in DAYS) (checker3[d,c]) =  TOTALPERIODS3[c]);

constraint forall(d in DAYS)( sum( c in COURSE3) (checker3[d,c]) = 6);

constraint forall(d in DAYS)( sum( c in COURSE3) (checker3[d,c] = 2) <= 2);

constraint forall(d in DAYS)( forall(c in COURSE3) ( sum( p in PERIODS ) ( timetable3[d,p] = c ) =  checker3[d,c]) );

% Constraints for For Year 4

constraint forall(d in DAYS) (forall(c in COURSE4)(0 <= checker4[d,c] /\ checker4[d,c] <= DAILYPERIODS4[c]) );

constraint forall(d in DAYS) (forall(c in COURSE4)( if DAILYPERIODS4[c] = 2 then ( (checker4[d,c] = 0) \/ (checker4[d,c] = 2) ) endif) );

constraint forall(c in COURSE4)( sum( d in DAYS) (checker4[d,c]) =  TOTALPERIODS4[c]);

constraint forall(d in DAYS)( sum( c in COURSE4) (checker4[d,c]) = 6);

constraint forall(d in DAYS)( sum( c in COURSE4) (checker4[d,c] = 2) <= 2);

constraint forall(d in DAYS)( forall(c in COURSE4) ( sum( p in PERIODS ) ( timetable4[d,p] = c ) =  checker4[d,c]) );          



%constraint forall(d in DAYS)( forall(p in PERIODS) (  )  ) 


%total room count constraint

%%%%%%constraint forall(d in DAYS)  ( forall (c1 in COURSE1, c2 in COURSE2, c3 in COURSE3, c4 in COURSE4 where ((c1=c2) /\ (c2=c3) /\ (c3=c4))) (checker1[d,c1] + checker2[d,c2] + checker3[d,c3] + checker4[d,c4] <= NUMROOM));


%constraint forall(d in DAYS)  ( forall (c in 1..8) (checker1[d,c] + checker2[d,c] + checker3[d,c] + checker4[d,c] <= NUMROOM));

%%%%%constraint forall(d in DAYS)( forall(p,q in PERIODS) ( if (DAILYPERIODS[timetable[DAYS[d],PERIODS[p]]]=2) /\ DAILYPERIODS[timetable[DAYS[d],PERIODS[q]]]=2  then ((p = 1 /\ q = 2) \/ (p = 3 /\ q = 4) \/ (p = 5 /\ q = 6)) endif) );

%constraint forall(d in DAYS)( forall(c in COURSE) ( if  sum( p in PERIODS ) ( timetable[d,p] = c ) = 2 then (timetable[d,PERIODS[1]]=c /\ timetable[d,PERIODS[2]]=c) endif ) );

solve satisfy; 

%output [ "\(p): \(produce[p])\n" | p in PRODUCT ]++["PROFIT: \(sum(p in PRODUCT)(profit[p]*produce[p]))"];
%%%%%output["\(DAILYPERIODS[timetable[DAYS[1],PERIODS[1]]])"];


%year 1



%output [
%  if c = 1 then "\n" else " " endif ++
%     show(checker1[d,c])
%  | d in DAYS,c in COURSE1 
%];

output["Winter Semester\n"];

output["First Year\n"];
output["\(p) "| p in PERIODS];


output [
  if p = 1 then "\n" else " " endif ++
     show(timetable1[d,p])
  | d in DAYS,p in PERIODS 
];

%year 2

output["\n\n"];

%output["\(c) "| c in COURSE2];


%output [
%  if c = 1 then "\n" else " " endif ++
%     show(checker2[d,c])
%  | d in DAYS,c in COURSE2 
%];

output["Second Year\n"];
output["\(p) "| p in PERIODS];

output [
  if p = 1 then "\n" else " " endif ++
     show(timetable2[d,p])
  | d in DAYS,p in PERIODS 
];

%year 3

output["\n\n"];

%output["\(c) "| c in COURSE3];


%output [
%  if c = 1 then "\n" else " " endif ++
%     show(checker3[d,c])
%  | d in DAYS,c in COURSE3 
%];

output["Third Year\n"];
output["\(p) "| p in PERIODS];

output [
  if p = 1 then "\n" else " " endif ++
     show(timetable3[d,p])
  | d in DAYS,p in PERIODS 
];

%year 4

output["\n\n"];

%output["\(c) "| c in COURSE4];

%output [
%  if c = 1 then "\n" else " " endif ++
%     show(checker4[d,c])
%  | d in DAYS,c in COURSE4 
%];

output["Fourth Year\n"];
output["\(p) "| p in PERIODS];

output [
  if p = 1 then "\n" else " " endif ++
     show(timetable4[d,p])
  | d in DAYS,p in PERIODS 
];
