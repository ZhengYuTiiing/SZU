#include<iostream>
#include <windows.h>
#include<time.h>
using namespace std;
int main() {
	int t = 20;
	int n;
	cin >> n;
	while (t--) {
		int *A = new int[1000000001];
		for (int i = 1; i <= n; i++) {
			A[i] = rand();
		}
		long start = clock();
		for (int i = 2; i <= 10; i++) {    // ���յ�2������n����˳�����β���
			int j, x = A[i];    // �Ƚ�i��Ԫ������ʱ���������ֹ���޸ġ�
			for (j = i; j > 1 && A[j - 1] < x; --j) {
				// ����ѭ���������൱�ڷֽ���Ӧ��ǰ�ƣ�
				// �ֽ�����ǰ�ƣ��͵��ڽ��ֽ���ǰ��>x��Ԫ�������
				A[j] = A[j - 1];
			}
			// �ҵ��ֽ���λ�ã����������Ԫ��x
			A[j] = x;
		}
		for(int i=11;i<=1000000000;i++){
			if(A[i]>A[10]){
				A[10]=A[i];
				for(int j=9;j>0;j--){
					if(A[j+1]>A[j]){
						int temp=A[j+1];
						A[j+1]=A[j];
						A[j]=temp; 
					}else
					break;
				}
			}
		}
		long end = clock();
		cout << double(end - start) << endl;
	}
	return 0;
}
