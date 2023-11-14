#include<iostream>
#include <math.h>
#include<time.h>
#include<functional>
using namespace std;
struct Point
{
double x, y;
};
struct eqfunc{
	bool operator()(const Point &p1,const Point &p2) const
	{
		return ((p1.x==p2.x)&&(p1.y==p2.y));
	}
}; 
struct hashfunc
{
	size_t operator()(const Point &P) const
	{
		return size_t(P.x*201928+P.y);
	}
};
int main() {
	int n, x, y;
	cin >> n;
	Point *A = new Point[n];
	for (int i = 0; i < n; i++) {
		A[i].x=rand();
		A[i].y=rand();
		if(hash.find(A[i])==hash.end()){
			hash.insert(A[i]);
		}
		
	}
	
	
	
	return 0;
}
