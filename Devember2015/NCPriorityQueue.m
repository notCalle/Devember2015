//
//  NCPriorityQueue.m
//  Devember2015
//
//  Created by Calle Englund on 14/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCPriorityQueue.h"

@implementation NCPriorityQueue

-(instancetype)init {
    self = [super init];
    if (self) {
        _queue = [NSMutableArray array];
    }
    return self;
}

+(instancetype)queue {
    return [[NCPriorityQueue alloc] init];
}

-(NSUInteger)count {
    return [_queue count];
}

-(id)objectAtIndex:(NSUInteger)index {
    return [_queue objectAtIndex:index];
}

-(void)insertObject:(id<NCQueuePriority>)anObject atIndex:(NSUInteger)index {
    [self addObject:anObject];
}

-(void)removeObjectAtIndex:(NSUInteger)index {
    [_queue removeObjectAtIndex:index];
}

-(void)addObject:(id<NCQueuePriority>)anObject {
    NSInteger n;
    for (n=0; n<[_queue count]; n++) {
        id<NCQueuePriority>this = _queue[n];
        if (anObject.priority > this.priority) {
            [_queue insertObject:anObject atIndex:n];
            break;
        }
    }
    if (n == [_queue count]) {
        [_queue addObject:anObject];
    }
}

-(void)removeLastObject {
    [_queue removeLastObject];
}

-(void)replaceObjectAtIndex:(NSUInteger)index withObject:(id<NCQueuePriority>)anObject {
    [self removeObjectAtIndex:index];
    [self addObject:anObject];
}

@end
