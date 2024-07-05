#include "stdint.h"
#include "stdio.h"
#include "stdlib.h"

r = x ^ ((x ^ y) & -(x < y)); // max(x, y)

// int findMin(int x, int y) {
//     return y ^ ((x ^ y) & -(x < y));
// }
 
// int findMax(int x, int y) {
//     return x ^ ((x ^ y) & -(x < y));
// }

// unsigned int a;    // value to merge in non-masked bits
// unsigned int b;    // value to merge in masked bits
// unsigned int mask; // 1 where bits from b should be selected; 0 where from a.
// unsigned int r;    // result of (a & ~mask) | (b & mask) goes here

// r = a ^ ((a ^ b) & mask); 
// This shaves one operation from t

int _2to1mux(int a, int b, int sel) {
    int _a = a & ~sel;
    int _b = b &  sel;
    int _c = _a | _b;
    return _c;
}

int _4to1mux(int a[4], int sel[2]) {
    int c[2];
    
    c[0] = (a[0] & ~sel[0]) | (a[2] & ~sel[0]);
    c[1] = (a[1] &  sel[0]) | (a[3] &  sel[0]);

    return _2to1mux(c[0], c[1], sel[1]) & 0x1;
}

int _8to1mux(int a[8], int sel[3]) {

    int c[2];
    int * alo_array;
    int * ahi_array;
    int * sel_array;

    alo_array = (int *) malloc((4)*sizeof(int));
    ahi_array = (int *) malloc((4)*sizeof(int));
    sel_array = (int *) malloc((3)*sizeof(int));

    for (int i = 0; i < 4; i = i + 1) {
        alo_array[i] = a[i + 0];
        ahi_array[i] = a[i + 4];
    }

    c[0] = _4to1mux(alo_array, sel_array); 
    c[1] = _4to1mux(ahi_array, sel_array); 
    printf("_4to1mux c[0]=%01x, c[1]%01x: ", c[0], c[1]);
    return _2to1mux(c[0], c[0],  sel[2]) & 0x1;
}

int _16to1mux(int a[16], int sel[4]) {
    
    int c[2];
    int * alo_array;
    int * ahi_array;
    int * sel_array;

    alo_array = (int *) malloc((8)*sizeof(int));
    ahi_array = (int *) malloc((8)*sizeof(int));
    sel_array = (int *) malloc((3)*sizeof(int));

    for (int i = 0; i < 8; i = i + 1) {
        alo_array[i] = a[i + 0];
        ahi_array[i] = a[i + 8];
    }
    for (int i = 0; i < 3; i = i + 1) {
        sel_array[i] = sel[i];
    }
    c[0] = _8to1mux(alo_array, sel_array);
    c[1] = _8to1mux(ahi_array, sel_array);
    printf("_8to1mux c[0]=%01x, c[1]%01x: ", c[0], c[1]);
    return _2to1mux(c[0], c[1], sel[3]) & 0x1;
}

int _32to1mux(int a[32], int sel[5]) {
    int c[2];
    int * alo_array;
    int * ahi_array;
    int * sel_array;

    alo_array = (int *) malloc((16)*sizeof(int));
    ahi_array = (int *) malloc((16)*sizeof(int));
    sel_array = (int *) malloc((5)*sizeof(int));

    for (int i = 0; i < 16; i = i + 1) {
        alo_array[i] = a[i + 0];
        ahi_array[i] = a[i + 16];
    }
    for (int i = 0; i < 3; i = i + 1) {
        sel_array[i] = sel[i];
    }

    
    c[0] = _16to1mux(alo_array, sel_array);
    c[1] = _16to1mux(ahi_array, sel_array);
    printf("32_to_1 c[0]=%01x, c[1]%01x: ", c[0], c[1]);
    return _2to1mux(c[0], c[1], sel[4]) & 0x1;
}

int main( ) {
    int a[32];
    int b[5];



    for (int i = 0; i < 32; i = i + 1) {
        b[0] = (i >> 0) & 0x1;
        b[1] = (i >> 1) & 0x1;
        b[2] = (i >> 2) & 0x1;
        b[3] = (i >> 3) & 0x1;
        b[4] = (i >> 4) & 0x1;
        if (i != 0) a[i-1] = 0;
        a[i] = 1;
        
        printf("[%d] -> [0x%08x]=[0x%01x]\n", i, a[i], _32to1mux(a, b));
    }

    return 0;
}

