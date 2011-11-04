#include <fstream>
#include <ctime>
#include <cstdlib>

using namespace std;

const int size = 180000;

int main(void) {
	ofstream of("input.txt");
	srand(time(0));

	of << size << " " <<   rand() % 2048 + 2048 << endl;
	int dist = 0;
	for (int i = 0; i < size; ++i) {
		of << (dist += rand() % 1024 + 2) << " " << (rand() % size + 2) << endl;
	}
	return 0;
}
