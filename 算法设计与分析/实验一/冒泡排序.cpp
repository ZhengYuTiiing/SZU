#include<iostream>
#include <windows.h>
#include<time.h>
using namespace std;
int main() {
	int t = 20;
	int n,temp;
	cin >> n;
	while (t--) {
		int *A=new int[n+1];
		for (int i = 1; i <= n; i++) {
			A[i] = rand();
		}
		long start = clock();
		for(int i=1;i<n;i++){
			for(int j=1;j<=n-i;j++){
			 if( A[j] > A[j + 1]) {
			 temp=A[j];
			 A[j]=A[j+1];
			 A[j+1]=temp;	
			 }
			 //swap(A[j] , A[j + 1]);
			}
		}
		long end = clock();
		cout << double(end - start) << endl;
		delete []A;
	}
	return 0;
}
