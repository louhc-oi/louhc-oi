disqus:
pagetime:
title: 康托展开

# 康托展开

## 1.康托展开

康托展开真是个神奇的东西。  
除了本题用于求某排列的排名外，康托展开一般用于哈希，不过我也没做到过这样的哈希题。
先给你柿子。  
$$
ans=1+\sum_{i=1}^{n} A[i]\times(n-i)!
$$  
其中$A[i]$代表$\sum_{j=i}^{n}[a[j] < a[i]]$  
怎么来理解这个柿子呢？想象构造出字典序比当前排列小的有几个排列。
枚举到$i$表示$1$到$i-1$和原来的排列一样,$i$位肯定不一样,之后咋样都行。  
既然到$i$位不一样，那么字典序大小其实就是取决于$i$位。很明显，第$i$位肯定要小于$a[i]$。然后只要把$i$后面小于$a[i]$的数交换到$i$位,后面随便排就行了。  
很明显，这样枚举可以做到不重不漏。因为要求的是排名,所以$ans+=1$。  
当然要用树状数组优化一下，复杂度是$O(nlgn)$的。

### 双语代码（滑稽
~~写Pascal就是为了卡常数,加O2秒杀C++)~~

#### C++98/11/14/17

```cpp
#include<bits/stdc++.h>
using namespace std;
#define MAXN 1000005
#define rgt register
#define mod 998244353

int N, a[MAXN], fac, c[MAXN], ans;
char *p;

inline void read( rgt int &x ){
	x = 0; while( !isdigit(*p) ) ++p;
	while( isdigit(*p) ) x = x * 10 + ( *p & 15 ), ++p;
}

int main(){
	scanf( "%d", &N ), fac = 1;
	p = new char[N * 8 + 100],
	fread( p, 1, N * 8 + 100, stdin );
	for ( rgt int i = N; i; --i ) read(a[i]);
	for ( rgt int i = 1, s, j; i <= N; ++i ){
		for ( s = 0, j = a[i]; j; j -= j & -j ) s += c[j];
		ans = ( ans + 1ll * fac * s ) % mod, fac = 1ll * fac * i % mod;
		for ( j = a[i]; j <= N; j += j & -j ) ++c[j];
	} printf( "%d\n", ans + 1 );
	return 0;
}
```

#### Pascal

```pas
var
n, fac, s, ans, i, j:longint;
a, c:array[1..1000000] of longint;
begin
    read(n); fac := 1; ans := 0;
    for i := n downto 1 do
    begin
        read(a[i]);
        c[i] := 0;
    end;
    for i := 1 to n do
    begin
        j := a[i]; s := 0;
        while j > 0 do
        begin
            s := s + c[j];
            j := j - ( j and -j ); 
        end;
        ans := ( QWORD(ans) + QWORD(fac) * QWORD(s) ) mod 998244353;
        fac := QWORD(fac) * QWORD(i) mod 998244353;
        j := a[i];
        while j <= n do
        begin
            c[j] := c[j] + 1;
            j := j + ( j and -j );
        end;
    end;
    writeln((ans + 1) mod 998244353);
end.
```
## 2.逆康托展开

类似于进制转换，不断 $\%(n-i)!$, $/(n-1)!$就可以得到A数组，然后就可以还原出原排列。  

**Update on 2019.7.23**  
~~昨天刚刚集训回来，于是就来填坑了~~

[例题](https://www.luogu.org/problemnew/show/UVA11525)  
这题十分好心地为我们省去了求出$A$数组的过程（否则要高精度除法？  
问题说白了就是在每一个$[i,n]$区间内求$K$大值。可以使用权值线段树+二分来解决这一问题。这应该比较基础，所以看代码吧qaq。

### 代码

~~没怎么卡常数，本来想搞zkw线段树非递归减小常数，但是懒。。。~~

```cpp
#include<bits/stdc++.h>
using namespace std;
#define MAXN 50005

int T, N, tr[MAXN << 2];

void Build( int c, int l, int r ){ //建树
	if ( l == r ) return tr[c] = 1, void();
	int mid((l + r) >> 1), ls(c << 1), rs(c << 1 | 1);
	Build( ls, l, mid ), Build( rs, mid + 1, r ),
	tr[c] = tr[ls] + tr[rs];
}

int Get( int c, int l, int r, int k ){ //找到k大值的同时删除k大值
	--tr[c]; if ( l == r ) return l;
	int mid((l + r) >> 1), ls(c << 1), rs(ls | 1);
	if ( tr[ls] < k ) return Get( rs, mid + 1, r, k - tr[ls] );//线段树上二分找到k大值
	return Get( ls, l, mid, k );
}

int main(){
	scanf( "%d", &T );
	while( T-- ){
		scanf( "%d", &N ), Build( 1, 1, N );
		for ( int i = 1, s; i <= N; ++i )
			scanf( "%d", &s ), printf( "%d%c", Get(1, 1, N, s + 1), "\n "[i < N] );
	} return 0;
}
```