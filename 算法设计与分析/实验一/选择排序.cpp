#include<iostream>
#include <windows.h>
#include<time.h>
using namespace std;
int main() {
	int t = 20;
	int n, min;
	cin >> n;
	while (t--) {
		int *A=new int[n+1];
		for (int i = 1; i <= n; i++) {
			A[i] = rand();
		}
		long start = clock();
		for (int i = 1; i <= n; i++) {
			min = i;
			for (int j = i + 1; j <= n; j++) {
				if (A[j] < A[min]) min = j;
			}
			if (min != i) swap(A[i], A[min]);
		}
		long end = clock();
		cout << double(end - start) << endl;
		delete []A;
	}
	return 0;
}
