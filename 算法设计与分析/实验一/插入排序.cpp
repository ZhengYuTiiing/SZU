#include<iostream>
#include <windows.h>
#include<time.h>
using namespace std;
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
		  for (int i = 2; i <= n; i++) {    // ���յ�2������n����˳�����β���
		        int j, x = A[i];    // �Ƚ�i��Ԫ������ʱ���������ֹ���޸ġ�
		        for (j = i; j > 1 && A[j - 1] > x; --j) {   
		            // ����ѭ���������൱�ڷֽ���Ӧ��ǰ�ƣ�
		            // �ֽ�����ǰ�ƣ��͵��ڽ��ֽ���ǰ��>x��Ԫ�������
		            A[j] = A[j - 1];                                                          
		        }
		        // �ҵ��ֽ���λ�ã����������Ԫ��x
		        A[j] = x;                         
		    }
		long end = clock();
	cout << double(end - start) << endl;
	delete []A;
	}
	return 0;
}
