identification division.
program-id. ROMANNUMERALS.
environment division.
input-output section.
file-control.
	select STANDARD-INPUT assign to KEYBOARD.
	select STANDARD-OUTPUT assign to DISPLAY.
	select inputFile assign to "roman.txt"
		organization is line sequential.
data division.
file section.
fd STANDARD-INPUT.
	01 STDIN-RECORD	pic X(80).
fd STANDARD-OUTPUT.
	01 STDOUT-RECORD pic X(80).
fd inputFile.
	01 inputFile-Record pic X(80).
working-storage section.
77	N    pic S99 usage is comp.
77	TEMP pic S9(8) usage is comp.
77	RET  pic S9 usage is comp-3.
01	inputType pic x(5).
*> 01	fileName pic x(30).
01	ARRAY-AREA.
	*> 02 R pic x(30).
	02 R pic X(30) occurs 30 times.
01	INPUT-AREA.
	02 IN-R   pic X(30).
	02 FILLER pic X(50).
01	TITLE-LINE.
	02 FILLER pic X(11) value SPACES.
	02 FILLER pic X(24) value 'ROMAN NUMBER EQUIVALENTS'.
01	UNDERLINE-1.
	02 FILLER pic X(45) value
		' --------------------------------------------'.
01	COL-HEADS.
	02 FILLER pic X(9) value SPACES.
	02 FILLER pic X(12) value 'ROMAN NUMBER'.
	02 FILLER pic X(13) value SPACES.
	02 FILLER pic X(11) value 'DEC. EQUIV.'.
01	UNDERLINE-2.
	02 FILLER pic X(45) value
		' ------------------------------   -----------'.
01	PRINT-LINE.
	02 FILLER pic X value SPACE.
	02 OUT-R pic X(30).
	02 FILLER pic X(3) value SPACES.
	02 OUT-EQ pic Z(9).

procedure division.
	open input STANDARD-INPUT, output STANDARD-OUTPUT.
	open input inputFile.
	write STDOUT-RECORD from TITLE-LINE after advancing 0 lines. 
	write STDOUT-RECORD from UNDERLINE-1 after advancing 1 line. 
	write STDOUT-RECORD from COL-HEADS after advancing 1 line. 
	write STDOUT-RECORD from UNDERLINE-2 after advancing 1 line. 
	write STDOUT-RECORD from PRINT-LINE after advancing 1 line. 
L1.	move 1 to N. move SPACES to ARRAY-AREA.
L3. display "Enter 1 for file or 0 for keyboard"
	accept inputType
	evaluate inputType
		when 1 perform L5
		when 0 perform L4.
	perform B2.
L4.	move zero to inputType
	accept INPUT-AREA
	perform L2.
L5. read inputFile into INPUT-AREA
		at end
			write STDOUT-RECORD from INPUT-AREA after advancing 1 line
			close inputFile
			perform L2
		not at end
			write STDOUT-RECORD from INPUT-AREA after advancing 1 line
			perform L2.
	write STDOUT-RECORD from INPUT-AREA after advancing 1 line.
	perform L2.
L2.	
	move IN-R to R(N).
	if IN-R is equal to SPACE
		perform B1.
	add 1 to N. perform L4.
B1.	subtract 1 from N.
	call "conv" using ARRAY-AREA, N, RET, TEMP.
	move 1 to RET.
	evaluate RET
		when 1 perform B2
		when 0 perform L1.
	*> go to B2, L1 depending on RET.
B2.	move TEMP to OUT-EQ. move ARRAY-AREA to OUT-R.
	write STDOUT-RECORD from PRINT-LINE after advancing 1 line. 
	*> go to L1.
	perform L3.
B3.	close STANDARD-INPUT, STANDARD-OUTPUT, inputFile.
	stop run.
