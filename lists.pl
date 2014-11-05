getListObjectAtIndex([First | Others], 0, First) :-
	write(First),
	!.

getListObjectAtIndex([_ | Others], Row, First) :-
	Row2 is Row - 1,
	getListObjectAtIndex(Others, Row2, First).