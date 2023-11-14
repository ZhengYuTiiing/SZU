#include <iostream>
#include <chrono> 
#include <ctime> 
#include <vector>
#include <ctime>
#include<bits/stdc++.h>
using namespace std;
using std::chrono::high_resolution_clock;
using std::chrono::duration;
using namespace std;
using namespace std::chrono;
#define KB 1024
random_device rd;//随机数生成
mt19937 gen(rd());
void random_access(int size)
{
	int n = size / sizeof(char);     
	char* buffer = new char[n];       //创建一个大小为size的字符数组 
	fill(buffer, buffer+n, 1);        //初始化字符数组 
	
	uniform_int_distribution<> dis(0, n-1);
	
	int test_times = 11451419 * 10;
	vector<int> random_index;
		for(int i=0; i<test_times; i++)
		{
			int index = dis(gen);
			random_index.push_back(index); 
		}
		
	auto t1=std::chrono::steady_clock::now(); 
	int sum = 0;
		for(int i=0; i<test_times; i++)
		{
			sum += buffer[random_index[i]];
		}
	auto t2=std::chrono::steady_clock::now();
	double dr_us=std::chrono::duration<double,std::micro>(t2-t1).count();
	cout<<(size/1024)<<" "<<(((double)sum/1024.0) / (dr_us/1000000))<<endl;
	
	
	delete[] buffer;
}

void test1()
{
	//int size = 64 * KB;
	vector<int> sizes{100*KB,200*KB,300*KB,400*KB,500*KB,1024*KB,2048*KB,4096*KB,5120*KB,6144*KB,7168*KB,8192*KB,9216*KB,10240*KB};
	
	for(auto s : sizes)
	{
		random_access(s);
	}
}


int main()
{
  test1();
}
