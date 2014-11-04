%
%	[Utilities] -> writeln
%

writeln(X) :-
	write(X),
	nl.

%
%	[Utilities] -> Read Integer
%

readInteger(ReturnValue) :-
	read(ReturnValue),
	integer(ReturnValue),
	!.

readInteger(ReturnValue) :-
	writeln('An integer was expected, not something else!'),
	readInteger(ReturnValue).

%
%	[Utilities] -> Read Yes / No
%

readYN(y).
readYN(n).

readYN(X) :- 
	read(X), 
	readYN(X), 
	!.

readYN(X) :- 
	writeln('You need to choose between "y" and "n".'),
	readYN(X).

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

printBoard([]).

printBoard([FirstRow|OtherRows]) :-
	printList(FirstRow),
	printBoard(OtherRows).
	
%
%	The function below is required else the program will stop printing the board after the first line.
%

printList([]) :-
	nl.

printList([First|Others]) :-
	write('['),
	write(First),
	write(']'),
	printList(Others).
	
%	play(InputBoard, PieceType, PositionX, PositionY, OutputBoard) :-

runMainLoop(Board) :-
	writeln('got here!'),
	promptForPlay('Player1', a, b, c, d).

readPieceType(RetVal) :-
	readInteger(RetVal),
	RetVal > 0,
	RetVal < 4,
	!.

readPieceType(RetVal) :-
	writeln('You need to choose one value from 1/2/3.'),
	readPieceType(RetVal).

%
%	validatePiecePosition(PieceType, PieceOrientation, PieceX, PieceY) is not done at all!
%

validatePiecePosition(PieceType, PieceOrientation, PieceX, PieceY) :-
	.

promptForCoordinates(PieceType, PieceOrientation, PieceX, PieceY) :-
	write(Player), write(', please choose an X coordinate: '),
	readCoordinateX(PieceX),
	write(Player), write(' please choose an Y coordinate: '),
	readCoordinateY(PieceY),
	validatePiecePosition(PieceType, PieceOrientation, PieceX, PieceY),
	!.

promptForCoordinates(PieceType, PieceOrientation, PieceX, PieceY) :-
	writeln('Invalid coordinates! Please try again.'),
	promptForCoordinates(PieceType, PieceOrientation, PieceX, PieceY).

promptForPlay(Player, PieceType, PieceOrientation, PieceX, PieceY) :-
	!, 
	write(Player), write(', please choose a piece type (1/2/3): '),
	readPieceType(PieceType),
	!,
	write(Player), write(', please choose an orientation (Vertical/Horizontal): '),
	readPieceOrientation(PieceOrientation),
	!,
	promptForCoordinates(PieceX, PieceY).

startGame :-
	nl,
	writeln('Welcome to Le Bloq, Prolog Edition!'),
	nl,
	initialBoard(X),
	printBoard(X),
	runMainLoop(X).
	