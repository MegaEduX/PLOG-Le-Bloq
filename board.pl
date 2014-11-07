:- ensure_loaded(['utilities.pl', 'printing.pl', 'lists.pl']).

initialBoard([
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],	
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
]).

%
%	Main Run Loop
%

runMainLoop(Board, PlayCount, CurrentPlayer, PlayerOnHold) :-
	nl,
	
	printBoard(Board),
	
	nl,
	
	promptForPlay(Board, PlayCount, CurrentPlayer, NewBoard),
	
	(
		(
			not(PlayCount is 0),
			
			checkForAvailableTurns(Board, 20, 20),
			
			GameRunning is 1
		);
		
		(
			not(PlayCount is 0),
			
			not(checkForAvailableTurns(Board, 20, 20)),
			
			GameRunning is 0
		);
		
		(
			PlayCount is 0,
			
			GameRunning is 1
		)
	),
	
	(
		(
			GameRunning is 1,
			
			NewPlayCount is (PlayCount + 1),
			
			runMainLoop(NewBoard, NewPlayCount, PlayerOnHold, CurrentPlayer)
		);
		
		(
			GameRunning is 0,
			
			writeln('Game Over!')
		)
	).

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

checkForBlankSpaces(_, 0) :-
	!.

checkForBlankSpaces([_ | Tail], NumberOfSpaces) :-
	Tail is 0,
	
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
	
	RetVal is 0,
	
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
	
	fail.

checkLineForBlockExistance(Line, Index, _) :-
	getListObjectAtIndex(Line, Index, Object),
	
	(Object \== 0),
	
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
	
	fail.

checkColumnForBlockExistance(Board, Column, X, _) :-
	getListObjectAtIndex(Board, Column, RetLine),
	getListObjectAtIndex(RetLine, X, RetObject),
	
	(RetObject \== 0),
	
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
	
	fail.

checkLineForBlockOccurence(Line, Match, Index, _) :-
	getListObjectAtIndex(Line, Index, Object),
	
	(Object == Match),
	
	!.

checkLineForBlockOccurence(Line, Match, Index, Length) :-
	%	404 Piece Not Found.
	
	NewIndex is Index + 1,
	NewLength is Length - 1,
	
	checkLineForBlockOccurence(Line, Match, NewIndex, NewLength).

%
%	Check Column for Block Occurence
%

checkColumnForBlockOccurence(_, _, _, _, 0) :-
	!,
	
	fail.

checkColumnForBlockOccurence(Board, Match, Column, X, _) :-
	getListObjectAtIndex(Board, Column, RetLine),
	getListObjectAtIndex(RetLine, X, RetObject),
	
	(RetObject == Match),
	
	!.

checkColumnForBlockOccurence(Block, Match, Column, X, Length) :-
	%	404 Piece Not Found
	
	NewColumn is Column + 1,
	NewLength is Length - 1,
	
	checkColumnForBlockOccurence(Block, Match, NewColumn, X, NewLength).
	

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
			BottomY is PieceY + PieceHeight,
			
			getListObjectAtIndex(Board, BottomY, ReturnLineBottom),
			checkLineForBlockExistance(ReturnLineBottom, PieceX, PieceWidth)	
		);
		
		%	Left Column
		
		(
			LeftX is PieceX - 1,
			
			checkColumnForBlockExistance(Board, PieceY, LeftX, PieceHeight)
		);
		
		
		%	Right Column
		
		(
			RightX is PieceX + PieceWidth,
			
			checkColumnForBlockExistance(Board, PieceY, RightX, PieceHeight)
		)
		
	).

pieceHasNoAdjacentSameBlock(Board, PieceType, PieceOrientation, PieceX, PieceY) :-
	getPieceWidthAndHeight(PieceType, PieceOrientation, PieceWidth, PieceHeight),
	
	(
		%	Top Line
		
		(
			TopY is PieceY - 1,
			
			getListObjectAtIndex(Board, TopY, ReturnLineTop),
			not(checkLineForBlockOccurence(ReturnLineTop, PieceType, PieceX, PieceWidth))
		),
		
		%	Bottom Line
		
		(
			BottomY is PieceY + PieceHeight,
			
			getListObjectAtIndex(Board, BottomY, ReturnLineBottom),
			not(checkLineForBlockOccurence(ReturnLineBottom, PieceType, PieceX, PieceWidth))
		),
		
		%	Left Column
		
		(
			LeftX is PieceX - 1,
			
			not(checkColumnForBlockOccurence(Board, PieceType, PieceY, LeftX, PieceHeight))
		),
		
		%	Right Column
		
		(
			RightX is PieceX + PieceWidth,
			
			not(checkColumnForBlockOccurence(Board, PieceType, PieceY, RightX, PieceHeight))
		)
	).
	
%
%	Line Fill
%

lineFill(Line, _, 0, _, Line) :-
	!.

lineFill(Line, PieceType, Width, X, NewLine) :-
	replace(Line, X, PieceType, ReturnedLine),
	
	NewWidth is Width - 1,
	NewX is X + 1,
	
	lineFill(ReturnedLine, PieceType, NewWidth, NewX, NewLine).

%
%	Board Fill
%

boardFill(Board, _, _, 0, _, _, Board) :-
	!.

boardFill(Board, PieceType, Width, Height, X, Y, NewBoard) :-
	getListObjectAtIndex(Board, Y, Line),
	
	lineFill(Line, PieceType, Width, X, NewLine),
	replace(Board, Y, NewLine, ReturnedBoard),
	
	NewHeight is Height - 1,
	NewY is Y + 1,
	
	boardFill(ReturnedBoard, PieceType, Width, NewHeight, X, NewY, NewBoard).

fillBoardWithNewBlock(Board, PieceType, PieceOrientation, PieceX, PieceY, NewBoard) :-
	getPieceWidthAndHeight(PieceType, PieceOrientation, PieceWidth, PieceHeight),
	
	boardFill(Board, PieceType, PieceWidth, PieceHeight, PieceX, PieceY, NewBoard).

%
%	Turn Validation
%

validateTurn(Board, PieceType, PieceOrientation, PieceX, PieceY, NewBoard) :-
	nl,
	
	writeln('[Turn Validation] Checking for free space...'),
	pieceHasFreeSpace(Board, PieceType, PieceOrientation, PieceX, PieceY),
	
	writeln('[Turn Validation] Checking for adjacent blocks of the same type...'),
	pieceHasNoAdjacentSameBlock(Board, PieceType, PieceOrientation, PieceX, PieceY),
	
	writeln('[Turn Validation] Checking for at least a block nearby...'),
	pieceHasAdjacentBlock(Board, PieceType, PieceOrientation, PieceX, PieceY),
	
	%	And after all validations...
	
	writeln('[Turn Validation] Filling board...'),
	
	fillBoardWithNewBlock(Board, PieceType, PieceOrientation, PieceX, PieceY, NewBoard),
	
	!.

validateTurn(_, _, _, _, _, _) :-
	writeln('Turn validation failed.'),
	
	fail.

validateTurnSilent(Board, PieceType, PieceOrientation, PieceX, PieceY, NewBoard) :-
	pieceHasFreeSpace(Board, PieceType, PieceOrientation, PieceX, PieceY),
	pieceHasNoAdjacentSameBlock(Board, PieceType, PieceOrientation, PieceX, PieceY),
	pieceHasAdjacentBlock(Board, PieceType, PieceOrientation, PieceX, PieceY).

validateFirstTurn(Board, PieceType, PieceOrientation, PieceX, PieceY, NewBoard) :-
	nl,
	
	writeln('[Turn Validation] Checking for free space...'),
	
	pieceHasFreeSpace(Board, PieceType, PieceOrientation, PieceX, PieceY),
	
	writeln('[Turn Validation] Filling board...'),
	
	fillBoardWithNewBlock(Board, PieceType, PieceOrientation, PieceX, PieceY, NewBoard),
	
	!.

validateFirstTurn(_, _, _, _, _, _) :-
	writeln('Turn validation failed.'),
	
	fail.

%
%	Check for Available Turns
%

iterateThroughBoard(Board, PieceType, PieceOrientation, _, _, CurrentX, CurrentY) :-
	validateTurnSilent(Board, PieceType, PieceOrientation, CurrentX, CurrentY, _),
	
	!.

iterateThroughBoard(Board, PieceType, PieceOrientation, BoardSizeX, BoardSizeY, CurrentX, CurrentY) :-
	(	
		CurrentX is BoardSizeX - 1,
		not(CurrentY is BoardSizeY - 1),
		
		%	writeln('End of row case.'),
		
		NewX is 0,
		NewY is CurrentY + 1,
		
		iterateThroughBoard(Board, PieceType, PieceOrientation, BoardSizeX, BoardSizeY, NewX, NewY)
	);
	
	%	End of everything...
	
	(	
		CurrentY is BoardSizeY - 1,
		CurrentX is BoardSizeX - 1,
		
		fail
		
		%	writeln('End of everything case.')
		
		%	Return True! Or something.
	);
	
	%	Normal case...
	
	(	
		not(CurrentX is BoardSizeX - 1),
		
		%	writeln('Normal case.'),
		
		NewX is CurrentX + 1,
		
		iterateThroughBoard(Board, PieceType, PieceOrientation, BoardSizeX, BoardSizeY, NewX, CurrentY)
	).

checkForAvailableTurns(Board, BoardSizeX, BoardSizeY) :-
	writeln('[Logic] Checking for endgame condition...'),
	
	iterateThroughBoard(Board, 1, 'v', BoardSizeX, BoardSizeY, 0, 0);
	iterateThroughBoard(Board, 1, 'h', BoardSizeX, BoardSizeY, 0, 0);
	iterateThroughBoard(Board, 2, 'v', BoardSizeX, BoardSizeY, 0, 0);
	iterateThroughBoard(Board, 2, 'h', BoardSizeX, BoardSizeY, 0, 0);
	iterateThroughBoard(Board, 3, 'v', BoardSizeX, BoardSizeY, 0, 0);
	iterateThroughBoard(Board, 3, 'h', BoardSizeX, BoardSizeY, 0, 0).

%
%	Calculate Scoring
%

%	MISSING!

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

promptForPlay(Board, PlayCount, Player, NewBoard) :-
	write(Player), write(', please choose a piece type (1/2/3): '),
	readPieceType(PieceType),
	
	write(Player), write(', please choose an orientation ([v]ertical/[h]orizontal): '),
	readPieceOrientation(PieceOrientation),
	
	promptForCoordinates(Player, PieceX, PieceY, 20, 20),
	
	(
		(
			PlayCount is 0,
			validateFirstTurn(Board, PieceType, PieceOrientation, PieceX, PieceY, NewBoard)
		);
		
		(
			not(PlayCount is 0),
			validateTurn(Board, PieceType, PieceOrientation, PieceX, PieceY, NewBoard)
		)
	),
	
	!.

promptForPlay(Board, PlayCount, Player, NewBoard) :-
	writeln('You messed up. Try again! :)'),
	
	promptForPlay(Board, PlayCount, Player, NewBoard).

startGame :-
	nl, writeln('Welcome to Le Bloq, Prolog Edition!'),
	
	initialBoard(X),
	
	runMainLoop(X, 0, 'Player 1', 'Player 2').
	