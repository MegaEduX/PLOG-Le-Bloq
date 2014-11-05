printBoard([]).

printBoard([FirstRow|OtherRows]) :-
	printList(FirstRow),
	printBoard(OtherRows).

printList([]) :-
	nl.

printList([First|Others]) :-
	write('['),
	write(First),
	write(']'),
	
	printList(Others).