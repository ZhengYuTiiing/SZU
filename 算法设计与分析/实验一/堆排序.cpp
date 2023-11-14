#include<iostream>
#include <windows.h>
#include<time.h>
using namespace std;
void Adjust(int *A,int i,int m){
        int temp=A[i];
        for(int j=2*i+1;j<=m;j=j*2+1){
            if(j<m&&A[j]>A[j+1])
                j++;
            if(A[j]>=temp)
                break;
            A[i]=A[j];
            i=j;
        }
        A[i]=temp;
    }
int main() {
	int t = 20;
	int n;
	cin >> n;
	while (t--) {
		int *A=new int[1000000001];
		for (int i = 1; i <= n; i++) {
			A[i] = rand();
		}
		long start = clock();
		for(int i=5;i>=1;i--)
		    Adjust(A,i,10);

		for(int i=11;i<=n;i++){
		if(A[i]>A[1]) {
			A[1]=A[i];
		 Adjust(A,i,10);	
		}
		}
		long end = clock();
		cout << double(end - start) << endl;
		delete []A;
	}
	return 0;
}
