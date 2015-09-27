//
//  QuickSort.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/28/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "Exercise1.h"


@interface Exercise1 ()

@end

@implementation Exercise1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int arr[8][8];
    int len = 8;
    
    for (int i = 0; i < len; i++) {
        for (int j = 0; j < len; j++) {
            arr[i][j] = arc4random_uniform(100);
            [self write:[NSString stringWithFormat:@"%d\t", arr[i][j]]];
        }
        [self writeln:@""];
    }
    
    for (int i = 0; i < len; i++) {
        [self quickSort:arr[i] NumberOfELements:len];
    }
    
    [self writeln:@"\n"];
    
    for (int i = 0; i < len; i++) {
        for (int j = 0; j < len; j++) {
            [self write:[NSString stringWithFormat:@"%d\t", arr[i][j]]];
        }
        [self writeln:@""];
    }

}


- (void) quickSort:(int *)arr NumberOfELements:(int)n {
    if (n <= 1) return;
    
    int *temp = (int *)malloc(n * sizeof(int));
    
    int pivotIndex = arc4random_uniform(n);
    int pivot = arr[pivotIndex];
    int first = 0, last = n - 1;
    
    for (int i = 0; i < n; i++) {
        if (i == pivotIndex) continue;

        if (arr[i] <= pivot) {
            temp[first++] = arr[i];
        }
        else {
            temp[last--] = arr[i];
        }
    }
    
    temp[first] = pivot;
    
    memcpy(arr, temp, n * sizeof(int));
    free(temp);
    
    [self quickSort:arr NumberOfELements:first];
    [self quickSort:arr + first + 1 NumberOfELements:n - first - 1];
}


@end
