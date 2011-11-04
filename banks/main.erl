-module(main).

-compile(export_all).


check_for_index(Money, 0, BMETS, BIETS) ->
	ets:insert(BMETS, {0, Money}),
	ets:insert(BIETS, {0, 0});

check_for_index(Money, Count, BMETS, BIETS) when Count > 0  ->
	[{_, Value}] = ets:lookup(BMETS, Count - 1),
	case Value of
		X when X =< Money ->
			ets:insert(BMETS, {Count, Money}),
			ets:insert(BIETS, {Count, Count});
		X when X > Money ->
			ets:insert(BMETS, {Count, X}),
			[{_, BI}] = ets:lookup(BIETS,
				Count - 1),
			ets:insert(BIETS, {Count, BI})
	end.

tiling_up(_, _, _, _, Count, Prevoffset) when Prevoffset == Count ->
	Prevoffset - 1;

tiling_up(IETS, BIETS, BMETS, D, Count, PrevOffset) ->
	[{Count, I}] = ets:lookup(IETS, Count),
	[{PrevOffset, J}] = ets:lookup(IETS, PrevOffset + 1),
	case I - (J + D) of
		X when X >= 0 ->
			tiling_up(IETS, BIETS, BMETS, D, Count, PrevOffset + 1);
		X when X < 0 ->
			PrevOffset
	end.

do_check(_, _, BMAtPrevOffset, Count, BIAtPrevOffset, Money,
	NowMoney, IndexI, IndexAtPrevOffset, D) when
	(BMAtPrevOffset + Money > NowMoney) and (IndexI >= IndexAtPrevOffset + D) ->
	{BIAtPrevOffset + 1, Count + 1, BMAtPrevOffset + Money};

do_check(B1, B2, _, _, _, _, NowMoney, _, _, _) ->
	{B1, B2, NowMoney}.


solve(Count, _, {B1, B2, _, _, _, _ ,_ }, Count) ->
	{B1, B2};

solve(Count, D, {B1, B2, NowMoney, PrevOffset, Index, BestMoney, BestIndex}, N) ->
	{ok, [Pos, Money]} = io:fread("", "~d ~d"),
	ets:insert(Index, {Count, Pos}),
	check_for_index(Money, Count, BestMoney, BestIndex),
	Offset = tiling_up(Index, BestIndex, BestMoney, D, Count, PrevOffset),
	[{Offset, BMAtPrevOffset}] = ets:lookup(BestMoney, Offset),
	[{Offset, BIAtPrevOffset}] = ets:lookup(BestIndex, Offset),
	[{Offset, IndexAtPrevOffset}] = ets:lookup(Index, Offset),
	[{Offset, IndexI}] = ets:lookup(Index, Count),
	{NewB1, NewB2, NewNowMoney} = do_check(B1, B2, BMAtPrevOffset, Count,
		BIAtPrevOffset, Money, NowMoney, IndexI, IndexAtPrevOffset, D),
	solve(Count + 1, D, {NewB1, NewB2, NewNowMoney, Offset, Index,
		BestMoney, BestIndex}, N).
	
main() ->
	Index = ets:new(index, []),
	BestMoney = ets:new(bestmoney, []),
	BestIndex = ets:new(bestindex, []),
	{ok, [N, D]} = io:fread("", "~d ~d"),
	solve(0, D, {-1, -1, 0, 0, Index, BestMoney, BestIndex}, N).

