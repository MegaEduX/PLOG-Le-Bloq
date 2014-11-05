:- ensure_loaded(['utilities.pl', 'printing.pl', 'lists.pl']).

initialBoard([
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],	
	['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']
]).

%
%	Main Run Loop
%

runMainLoop(Board, PlayCount, CurrentPlayer, PlayerOnHold) :-
	promptForPlay(Board, PlayCount, CurrentPlayer),
	
	NewPlayCount is (PlayCount + 1),
	
	runMainLoop(Board, NewPlayCount, PlayerOnHold, CurrentPlayer).

readPieceType(RetVal) :-
	readInteger(RetVal),
	
	RetVal > 0,
	RetVal < 4,
	
	!.

readPieceType(RetVal) :-
	writeln('You need to choose one value from 1/2/3.'),
	readPieceType(RetVal).

readPieceOrientation(RetVal) :-
	read(RetVal),
	
	(RetVal == 'v'; RetVal == 'h'),
	
	!.

readPieceOrientation(RetVal) :-
	writeln('You need to type either "v" or "h".'),
	readPieceOrientation(RetVal).

%
%	Validation
%

checkForBlankSpaces(Row, 0) :-
	!.

checkForBlankSpaces([Head | Tail], NumberOfSpaces) :-
	(Tail == '   '),
	
	NewNumber is (NumberOfSpaces - 1),
	
	checkForBlankSpaces(Tail, NewNumber).

getPieceWidthAndHeight(PieceType, PieceOrientation, WidthReturn, HeightReturn) :-

	(
		(PieceType == 1),
		
		(
			(PieceOrientation == 'v', WidthReturn is 2, HeightReturn is 3);
			(PieceOrientation == 'h', WidthReturn is 3, HeightReturn is 2)
		)
	);
	
	(
		(PieceType == 2),
		
		(
			(PieceOrientation == 'v', WidthReturn is 2, HeightReturn is 4);
			(PieceOrientation == 'h', WidthReturn is 4, HeightReturn is 2)
		)
	);
	
	(
		(PieceType == 3),
		
		(
			(PieceOrientation == 'v', WidthReturn is 3, HeightReturn is 4);
			(PieceOrientation == 'h', WidthReturn is 4, HeightReturn is 3)
		)
	)
	
	.

pieceTypeToBoardRepresentation(PieceType, BoardRepresentation) :-
	(
		PieceType == 1,
		BoardRepresentation is ' 1 '
	);
	
	(
		PieceType == 2,
		BoardRepresentation is ' 2 '
	);
	
	(
		PieceType == 3,
		BoardRepresentation is ' 3 '
	).

checkHorizontalAvailability(_, _, 0) :-
	!.

checkHorizontalAvailability(Row, Index, Length) :-
	getListObjectAtIndex(Row, Index, RetVal),
	
	RetVal == '   ',
	
	NewIndex is Index + 1,
	NewLength is Length - 1,
	
	!,
	
	checkHorizontalAvailability(Row, NewIndex, NewLength).

%
%	Piece Positioning Checks
%

checkRectangularAvailability(_, _, _, _, 0) :-
	!.

checkRectangularAvailability(_, _, _, 0, _) :-
	!.

checkRectangularAvailability(Board, FirstX, FirstY, LengthX, LengthY) :-
	getListObjectAtIndex(Board, FirstY, Row),
	
	checkHorizontalAvailability(Row, FirstX, LengthX),
	
	NextY is FirstY + 1,
	NewLengthY is LengthY - 1,
	
	checkRectangularAvailability(Board, FirstX, NextY, LengthX, NewLengthY).

pieceHasFreeSpace(Board, PieceType, PieceOrientation, PieceX, PieceY) :-
	getPieceWidthAndHeight(PieceType, PieceOrientation, Width, Height),
	
	checkRectangularAvailability(Board, PieceX, PieceY, Width, Height).

%
%	Check Line for Block Existance
%

checkLineForBlockExistance(_, _, 0) :-
	!,
	
	(1 == 2).			%	This should do the same as return false?

checkLineForBlockExistance(Line, Index, Length) :-
	getListObjectAtIndex(Line, Index, Object),
	
	(Object != '   '),
	
	!.

checkLineForBlockExistance(Line, Index, Length) :-
	%	404 Piece Not Found.
	
	NewIndex is Index + 1,
	NewLength is Length - 1,
	
	checkLineForBlockExistance(Line, NewIndex, NewLength).

%
%	Check Column for Block Existance
%

checkColumnForBlockExistance(_, _, _, 0) :-
	!,
	
	(1 == 2).

checkColumnForBlockExistance(Board, Column, X, Length) :-
	getListObjectAtIndex(Board, Column, RetLine),
	getListObjectAtIndex(RetLine, X, RetObject),
	
	(RetObject != '   '),
	
	!.

checkColumnForBlockExistance(Board, Column, X, Length) :-
	%	404 Piece Not Found.
	
	NewCol is Column + 1,
	NewLen is Length - 1,
	
	checkColumnForBlockExistance(Board, NewCol, X, NewLen).

%
%	Check Line for Block Occurence
%

checkLineForBlockOccurence(_, _, _, 0) :-
	!,
	
	(1 == 2).

checkLineForBlockOccurence(Line, Match, Index, Length) :-
	getListObjectAtIndex(Line, Index, Object),
	
	(Object == Match),
	
	!.

checkLineForBlockOccurence(Line, Match, Index, Length) :-
	%	404 Piece Not Found.
	
	NewIndex is Index + 1,
	NewLength is Length - 1,
	
	checkLineForBlockOccurence(Line, Match, NewIndex, NewLength).

%
%	Adjacent Block Check
%

pieceHasAdjacentBlock(Board, PieceType, PieceOrientation, PieceX, PieceY) :-
	getPieceWidthAndHeight(PieceType, PieceOrientation, PieceWidth, PieceHeight),
	
	(
		%	Top Line
		
		(
			TopY is PieceY - 1,
			
			getListObjectAtIndex(Board, TopY, ReturnLineTop),
			checkLineForBlockExistance(ReturnLineTop, PieceX, PieceWidth)
		);
		
		
		%	Bottom Line
		
		(
			BottomY is PieceY + PieceHeight + 1,
			
			getListObjectAtIndex(Board, BottomY, ReturnLineBottom),
			checkLineForBlockExistance(ReturnLineBottom, PieceX, PieceWidth)	
		);
		
		%	Left Column
		
		(
			LeftX is PieceX - 1,
			
			checkColumnForBlockExistance(Board, PieceY, LeftX, PieceHeight);
		);
		
		
		%	Right Column
		
		(
			RightX is PieceY + PieceWidth + 1,
			
			checkColumnForBlockExistance(Board, PieceY, RightX, PieceHeight);
		);
		
	).

pieceHasNoAdjacentSameBlock(Board, PieceType, PieceOrientation, PieceX, PieceY) :-

	getPieceWidthAndHeight(PieceType, PieceOrientation, PieceWidth, PieceHeight),
	pieceTypeToBoardRepresentation(PieceType, PieceRep),
	
	(
		%	Top Line
		
		(
			TopY is PieceY - 1,
			
			getListObjectAtIndex(Board, TopY, ReturnLineTop),
			not(checkLineForBlockOccurence(ReturnLineTop, PieceRep, PieceX, PieceWidth))
		),
		
		%	Bottom Line
		
		(
			BottomY is PieceY + PieceHeight + 1,
			
			getListObjectAtIndex(Board, BottomY, ReturnLineBottom),
			not(checkLineForBlockOccurence(ReturnLineBottom, PieceRep, PieceX, PieceWidth))
		),
		
		%	Left Column
		
		(
			
		),
		
		%	Right Column
		
		(
			
		),
	),
	
	writeln('To be implemented!').

%
%	Turn Validation
%

validateTurn(Board, PieceType, PieceOrientation, PieceX, PieceY) :-
	writeln('[Turn Validation] Checking for free space...'),
	pieceHasFreeSpace(Board, PieceType, PieceOrientation, PieceX, PieceY),
	
	writeln('[Turn Validation] Checking for adjacent blocks...'),
	pieceHasAdjacentDifferentBlock(Board, PieceType, PieceOrientation, PieceX, PieceY),
	
	!.

validateTurn(Board, PieceType, PieceOrientation, PieceX, PieceY) :-
	writeln('Turn validation failed.').

validateFirstTurn(Board, PieceType, PieceOrientation, PieceX, PieceY) :-
	writeln('[Turn Validation] Checking for free space...'),
	pieceHasFreeSpace(Board, PieceType, PieceOrientation, PieceX, PieceY),
	!.

validateFirstTurn(Board, PieceType, PieceOrientation, PieceX, PieceY) :-
	writeln('Turn validation failed.').

%
%	Game Prompts
%

promptForCoordinates(Player, PieceX, PieceY, BoardSizeX, BoardSizeY) :-
	write(Player), write(', please choose an X coordinate: '),
	readInteger(PieceX),
	
	PieceX >= 0,
	BoardSizeX >= PieceX,
	
	write(Player), write(' please choose an Y coordinate: '),
	readInteger(PieceY),
	
	PieceY >= 0,
	BoardSizeY >= PieceY,
	
	!.

promptForCoordinates(Player, PieceX, PieceY, BoardSizeX, BoardSizeY) :-
	write('Invalid coordinates! Please try again.'),
	promptForCoordinates(Player, PieceX, PieceY, BoardSizeX, BoardSizeY).

promptForPlay(Board, PlayCount, Player) :-
	write(Player), write(', please choose a piece type (1/2/3): '),
	readPieceType(PieceType),
	
	write(Player), write(', please choose an orientation ([v]ertical/[h]orizontal): '),
	readPieceOrientation(PieceOrientation),
	
	promptForCoordinates(Player, PieceX, PieceY, 20, 20),
	validateTurn(Board, PieceType, PieceOrientation, PieceX, PieceY).

startGame :-
	nl, writeln('Welcome to Le Bloq, Prolog Edition!'), nl,
	
	initialBoard(X),
	
	printBoard(X),
	
	runMainLoop(X),
	
	.
	