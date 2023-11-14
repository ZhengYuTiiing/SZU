#include<iostream>
#include <windows.h>
#include<time.h>
using namespace std;
void Merge(int *A,int p,int q,int r){
	int n=r-p+1;
	int *B=new int[n+1];
	int k=0;
	int j=q+1;
	for(int i=p;i<=q;i++){
		if(A[i]<A[j]||j>r)  {
			B[k]=A[i];
			i++;
			k++;
		}
		else{
			B[k]=A[j];
			j++;
			k++;
		}
	}
		for( j;j<=r;j++){
				B[k]=A[j];
				j++;
				k++;
		}
		for(int i=0;i<n;i++){
			A[p+i]=B[i];
		}
}


void Merge_sort(int *A, int p, int r) {
	if (p < r) {
		int q;
		q = ( p + r ) / 2;
		Merge_sort(A, p, q);
		Merge_sort(A, q + 1, r);
		Merge(A, p, q, r);
	}
}

int main() {
	int t = 20;
	int n;
	cin >> n;
	while (t--) {
		int *A=new int[n+1];
	for (int i = 1; i <= n; i++) {
			A[i] = rand();
		}
	long start = clock();
	Merge_sort(A,1,n);
	long end = clock();
	cout << double(end - start) << endl;
	delete []A;
	}
	return 0;
}


