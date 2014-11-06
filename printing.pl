printBoard([]).

printBoard([FirstRow|OtherRows]) :-
	printList(FirstRow),
	printBoard(OtherRows).

printList([]) :-
	nl.

printList([First|Others]) :-
	write('[ '),
	
	(
		(
			First is 0,
			write(' ')
		);
		
		(
			not(First is 0),
			write(First)
		)
	),
	
	write(' ]'),
	printList(Others).
	