#include <iostream>
#include <math.h>
#include<time.h>
#include <algorithm>
#include <vector> 
using namespace std;

#define MAXXX 99999999;
int x1,x2,yy1,y2;
class Point{
public:
    int x,y;
    Point(){};
    Point(int xx,int yy):x(xx),y(yy){};
};

int min(int a,int b) {
	return (a<b)?a:b; 
}
bool cmpx(const Point &p1, const Point &p2) {
    return p1.x < p2.x;
} 
bool cmpy(const Point &p1, const Point &p2) {
    return p1.y < p2.y;
}
double dis(Point a, Point b) {
    return sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
}
double baoli(Point *A, int n) {
    double min = 9999999;
    for (int i = 0; i < n - 1; i++) {
        for (int j = i + 1; j < n; j++) {
            if ((A[i].x - A[j].x) > min) continue;
            double dis = sqrt((A[i].x - A[j].x) * (A[i].x - A[j].x) + (A[i].y - A[j].y) * (A[i].y - A[j].y));
            if (dis < min) {
                min = dis;
                x1 = A[i].x;
                yy1 = A[i].y;
                x2 = A[j].x;
                y2 = A[j].y;
            }
        }
    }
}
//left是已经排好序后，点在数组x_sort[]里第left个，同理第right个
double divide(int left,int right,Point *A){
	if(left>=right) return MAXXX;
	if((left+1)==right){
		if(cmpy(A[right],A[left])){
			swap(A[right],A[left]);
		}
			x1 = A[left].x;
	        yy1= A[left].y;
	        x2 = A[right].x;
	        y2 = A[right].y;
			return dis(A[left],A[right]);
	}
	int lx1, lx2, ly1, ly2;
	double dl=divide(left,(left + right) / 2,A);
	lx1 = x1;
	lx2 = x2;
	ly1 = yy1;
	ly2 = y2;
	double dr=divide((left + right) / 2+1,right,A);
	double d=min(dl,dr);
	if (d == dl) {
	        x1 = lx1;
	        x2 = lx2;
	        yy1 = ly1;
	        y2 = ly2;
	    }
	Point midp=A[(left + right) / 2];
	inplace_merge(A,A+(left + right) / 2 + 1,A+right+1, cmpy);
	vector<Point> Y;
	for(int i=left;i<=right;i++){
		if(((midp.x>=A[i].x )&&((midp.x- A[i].x)<=d))||((midp.x<=A[i].x)&&(( A[i].x-midp.x)<=d))){
			Y.push_back(A[i]);
		}
	}
	for(int i=0;i<Y.size();i++){
		int small=min(6,Y.size()-i-1);
		for(int j=0;j<small;j++){
			if(dis(Y[i],Y[i+1+j])<d){
				d=dis(Y[i],Y[i+j+1]);
			}
		}
	}
	return d;
}

int main(){
    int x, y;
	    long n[10] = {100000, 200000, 300000, 400000, 500000, 600000, 700000, 800000, 900000, 1000000};
	    for (int k = 0; k < 1; k++) {
	        cout << "when n=" << n[k] << endl;
	        //生成随机点集
	        Point *A = new Point[n[k]];
	        for (int i = 0; i < n[k]; i++) {
	            x = rand();
	            y = rand();
	            Point a = Point(x, y);
	            A[i] = a;
	            for (int j = 0; j < i; j++)
	                if ((A[i].x == A[j].x) && (A[i].y == A[j].y)) {
	                    i--;
	                    continue;
	                }
	        }
	
	        //穷举法
	//        cout << "穷举法：" << endl;
	//        double start = clock();
	//        double min_dis = baoli(A, n[k]);
	//        double end = clock();
	//        cout << "min_dis=" << min_dis << endl;
	//        cout << "(" << x1 << "," << yy1 << ") and (" << x2 << "," << y2 << ")" << endl;
	//        cout << "time:" << double(end - start) << "ms" << endl;
	
	
	        //分治+归并
	        cout << "my分治归并法：";
	        double start = clock();
	        sort(A, A + n[k], cmpx);
	        double  d= divide(0, n[k] - 1, A);
	        double end = clock();
	        cout << "min_dis=" << d << endl;
	        cout << "(" << x1 << "," << yy1 << ") and (" << x2 << "," << y2 << ")" << endl;
	        cout << "time:" << double(end - start) << "ms" << endl;
	        delete[]A;
	    }
	    return 0;
}
