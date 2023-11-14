#include<iostream>
#include <windows.h>
#include<time.h>
using namespace std;
int main() {
	int t = 20;
	int n, n1, n2, n3;
	cin >> n;
	while (t--) {
		int A[n + 1];
		for (int i = 1; i <= n; i++) {
			A[i] = rand();
		}
		long start = clock();
		for (int i = 1; i < n; i++) {
			int tag = 0;
			for (int j = 1; j <= n - i; j++) {
				if ( A[j] > A[j + 1]) {
					swap(A[j], A[j + 1]);
					tag = 1;
				}
			}
			if (tag == 0) break;
		}
		long end = clock();
		cout << double(end - start) << endl;
	}


	return 0;
}
