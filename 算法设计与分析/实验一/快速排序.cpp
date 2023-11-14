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
//�������򣨴�С����
void quickSort(int low, int high, int *A) {
	if (low >= high)
		return;
	int i, j, pivot, temp;
	i = low, j = high;
	pivot = A[low];  //ȡ����ߵ���Ϊ��׼��
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
	//��׼����λ
	A[low] = A[i];
	A[i] = pivot;
	quickSort(low, i - 1, A);//�ݹ����
	quickSort(i + 1, high, A);//�ݹ��ұ�
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
