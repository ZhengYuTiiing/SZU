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
		  for (int i = 2; i <= n; i++) {    // 按照第2个到第n个的顺序依次插入
		        int j, x = A[i];    // 先将i号元素用临时变量保存防止被修改。
		        for (j = i; j > 1 && A[j - 1] > x; --j) {   
		            // 满足循环条件，相当于分界线应向前移，
		            // 分界线向前移，就等于将分界线前面>x的元素向后移
		            A[j] = A[j - 1];                                                          
		        }
		        // 找到分界线位置，插入待插入元素x
		        A[j] = x;                         
		    }
		long end = clock();
	cout << double(end - start) << endl;
	delete []A;
	}
	return 0;
}
