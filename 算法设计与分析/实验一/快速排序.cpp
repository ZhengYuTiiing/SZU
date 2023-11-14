#include<iostream>
#include <windows.h>
#include<time.h>
using namespace std;
int QUICKSORT(int *A,int low,int high,int pivot){
	int i=low,j=high;
		while (i < j) {
			while (A[j] >= pivot && i < j)
				j--;
			while (A[i] <= pivot && i < j)
				i++;
			if (i < j) swap(A[i],A[j]);
		}
			A[low] = A[i];
			A[i] = pivot;
			return i;
}
//快速排序（从小到大）
void quickSort(int low, int high, int *A) {
	if (low >= high)
		return;
	int i, j, pivot, temp;
	i = low, j = high;
	pivot = A[low];  //取最左边的数为基准数
	while (i < j) {
		while (A[j] >= pivot && i < j)
			j--;
		while (A[i] <= pivot && i < j)
			i++;
		if (i < j) {
			temp = A[i];
			A[i] = A[j];
			A[j] = temp;
		}
	}
	//基准数归位
	A[low] = A[i];
	A[i] = pivot;
	quickSort(low, i - 1, A);//递归左边
	quickSort(i + 1, high, A);//递归右边
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
		quickSort(1, n, A);
		long end = clock();
		cout << double(end - start) << endl;
		delete[]A;
	}
	return 0;
}
