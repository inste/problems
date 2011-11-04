#include <iostream>
#include <list>
using namespace std;

int main(void) {
	int n, d, money;
	int nowmoney = 0;
	int b1 = -1, b2 = -1;
	list<int> index, bestindex, bestmoney;
	list<int>::iterator prevoffset_it, bestmoney_it, bestindex_it, prevoffset_it_p1, index_end_m1;
	cin >> n >> d;

	for (int i = 0; i < n; ++i) {
		int x;
		cin >> x >> money;
		index.push_back(x);
		if ((i == 0) || (money > bestmoney.back())) {
			bestindex.push_back(i);
			bestmoney.push_back(money);
		} else {
			bestindex.push_back(bestindex.back());
			bestmoney.push_back(bestmoney.back());
		}

		prevoffset_it_p1 = prevoffset_it = index.begin();
		bestmoney_it = bestmoney.begin();
		bestindex_it = bestindex.begin();
		index_end_m1 = index.end();
		--index_end_m1;
		++prevoffset_it_p1;
		
		while ((index_end_m1 != prevoffset_it) && (index.back() >= *(prevoffset_it_p1) + d)) {
			++prevoffset_it;
			++bestmoney_it;
			++bestindex_it;
			++prevoffset_it_p1;
		}
		index.erase(index.begin(), prevoffset_it);
		bestmoney.erase(bestmoney.begin(), bestmoney_it);
		bestindex.erase(bestindex.begin(), bestindex_it);

		if ((bestmoney.front() + money > nowmoney) && (index.back() >= index.front() + d)) {
			b1 = bestindex.front() + 1;
			b2 = i + 1;
			nowmoney = bestmoney.front() + money;
		}
		
	}

	cout << b1 << " " << b2 << std::endl;

	return 0;
}
