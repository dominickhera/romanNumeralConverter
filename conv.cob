identification division.
program-id. conv.
environment division.
input-output section.
file-control.
	select STANDARD-OUTPUT assign to display.

data division.
file section.
fd STANDARD-OUTPUT.
	01 STDOUT-RECORD pic X(80).

working-storage section.
77 I pic S99 usage is comp.
77 K pic 9(2) value 0.
77 PREV pic S9(8) usage is comp.
77 D pic S9(4) usage is comp.
01 ERROR-MESS.
	02 FILLER pic X(22) value ' ILLEGAL ROMAN NUMERAL'.

linkage section.
77 M    pic S99 usage is comp.
77 ERR  pic S9 usage is comp-3.
77 SUM1 pic S9(8) usage is comp.
01 ARRAY-AREA.
	02 S pic X(1) occurs 30 times.

procedure division using ARRAY-AREA, M, ERR, SUM1.
	move 0 to SUM1. move 1001 to PREV. move 0 to K.
	inspect ARRAY-AREA tallying K for characters before initial " ".
	perform LOOP thru END-LOOP varying I from 1 by 1
	until I is greater than K.
	move 1 to ERR. perform B8.
LOOP.
	display S(I)
	if S(I) is equal to 'I' or S(I) is equal to 'i' then 
		move 1 to D
	else if S(I) is equal to 'V' or S(I) is equal to 'v' then
		move 5 to D
	else if S(I) is equal to 'X' or S(I) is equal to 'x' then
		move 10 to D
	else if S(I) is equal to 'L' or S(I) is equal to 'l' then 
		move 50 to D
	else if S(I) is equal to 'C' or S(I) is equal to 'c' then
		move 100 to D
	else if S(I) is equal to 'D' or S(I) is equal to 'd' then 
		move 500 to D
	else if S(I) is equal to 'M' or S(I) is equal to 'm' then
		move 1000 to D
	else
		perform B7
	end-if.

	add D to SUM1.
	if D is greater than PREV
		compute SUM1 = SUM1 - 2 * PREV.
END-LOOP. move D to PREV.
B7. open output STANDARD-OUTPUT.
	write STDOUT-RECORD from ERROR-MESS after advancing 1 line.
	move 2 to ERR. close STANDARD-OUTPUT.
B8. goback.
