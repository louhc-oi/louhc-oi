---
title: CF618F Double Knapsack
date: 2019-07-07 11:26:14
tags:
 - codeforces
 - 解题报告
 - 神仙题
---

# [CF618F Double Knapsack](http://codeforces.com/problemset/problem/618/F)

## 题目描述

给你两个可重集$A$,$B$,$A$、$B$的元素个数都为$n$且$n\le1000000$,它们中每个元素的大小$x\in[1,n]$。 请你分别找出$A$,$B$的可重子集,使得它们中的元素之和相等。

## 输入格式

第一行为一个整数$n$,表示两个子集的大小。

第二、三行皆为$n$个整数,分别表示$A$、$B$的元素。

## 输出格式

如果无解,请输出$-1$。如果有解,第一行输出$A$的可重子集中元素的个数,第二行输出该子集中元素在$A$ 中对应的下标;第三行输出$B$的可重子集中元素的个数,第四行输出该子集中元素在$B$中对应的下标。

数据可能存在多组解,输出一组即可。

---

# 思路

不得不说此题十分神仙。  
先讲做法。  
读入数据保存在数组$a$,$b$中。  
设$sa_i=\sum_{i=1}^n a_i,sb_i=\sum_{i=1}^n b_i$假设$sa[n]\ge sb[b]$ 如果不是的话交换就OK了XD  
对于每个$sa_i$,($i\in[0,n]$),选取$sb_j$使$sb_j$小于等于$sa_i$且$j$最大。  
如果$sa_i-sb_j$的值之前未出现过,将$sa_i-sb_j$记录,并保存此时的$i$,$j$  
如果该值之前出现过,直接将$a$,$b$中之前出现位置到$a$,$b$目前的位置$i$,$j$分别输出即可。  
由于保证所有数都在$[1,n]$之间,因此若$sb_j$是$sb$中最大的小于$sa_i$的数,$sa_i-sb_j$小于$n$,有$n$种取值。  
从$0$到$n$有$n+1$种取值,根据抽屉原理,肯定能遇到$sa_i-sb_j$之前出现过的情况,因此肯定有解。  

# 代码

```cpp
#include<bits/stdc++.h>
using namespace std;
#define i64 long long
#define MAXN 1000005

int N, flg, p1, p2, t;
i64 a[MAXN], b[MAXN];
int ra[MAXN], rb[MAXN];

inline void print( int x, int y ){
	printf( "%d\n", y - x + 1 );
	for ( int i = x; i <= y; ++i ) printf( "%d ", i );
	putchar('\n'); 
}

int main(){
	scanf( "%d", &N ), b[N + 1] = 0x7f7f7f7f7f7f7f7f;
	for ( int i = 1; i <= N; ++i ) scanf( "%lld", a + i ), a[i] += a[i - 1];
	for ( int i = 1; i <= N; ++i ) scanf( "%lld", b + i ), b[i] += b[i - 1];	
	if ( a[N] < b[N] ) swap( a, b ), flg = 1;
	memset( ra, -1, sizeof ra );
	for ( p1 = p2 = 0; p1 <= N; ++p1 ){
		while( b[p2 + 1] <= a[p1] ) ++p2;
		t = a[p1] - b[p2];
		if ( ra[t] != -1 ){
			flg ? print(rb[t] + 1, p2), print(ra[t] + 1, p1) : (print(ra[t] + 1, p1), print(rb[t] + 1, p2)); break;
		} ra[t] = p1, rb[t] = p2;
	} return 0;
} 
```