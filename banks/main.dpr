program main;

var
	n, d, i, money, nowmoney, prevoffset, b1, b2 : longint;
	index, bestindex, bestmoney : array[0 .. 200000] of longint;

begin
	b1 := -1;
	b2 := -1;
	nowmoney := 0;
	prevoffset := 0;

	readln(n, d);

	for i := 0 to n - 1 do
	begin
		readln(index[i], money);
		if i = 0 then
		begin
			bestindex[i] := i;
			bestmoney[i] := money;
		end else
		begin
			if money > bestmoney[i - 1] then
			begin
				bestindex[i] := i;
				bestmoney[i] := money;
			end else
			begin
				bestindex[i] := bestindex[i - 1];
				bestmoney[i] := bestmoney[i - 1];
			end;
		end;
		
		while (i <> prevoffset) and (index[i] >= index[prevoffset + 1] + d) do
			prevoffset := prevoffset + 1;

		if (bestmoney[prevoffset] + money > nowmoney) and (index[i] >= index[prevoffset] + d) then
		begin
			b1 := bestindex[prevoffset] + 1;
			b2 := i + 1;
			nowmoney := bestmoney[prevoffset] + money;
		end
	end;

	writeln(b1, ' ', b2);

end.

