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

pieceHasAdjacentDifferentBlock(Board, PieceType, PieceOrientation, PieceX, PieceY) :-
	writeln('To be implemented!'),
	!.

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
	!,
	write(Player), write(', please choose an orientation ([v]ertical/[h]orizontal): '),
	readPieceOrientation(PieceOrientation),
	!,
	promptForCoordinates(Player, PieceX, PieceY, 20, 20),
	validateTurn(Board, PieceType, PieceOrientation, PieceX, PieceY).

startGame :-
	nl,
	writeln('Welcome to Le Bloq, Prolog Edition!'),
	nl,
	initialBoard(X),
	printBoard(X),
	runMainLoop(X),
	!.
	