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
        _prio = nil;
    }
    return self;
}

-(instancetype)initWithPriorities:(NSDictionary<ObjectType,NSNumber *> *)priorities {
    self = [self init];
    if (self) {
        _prio = priorities;
    }
    return self;
}

+(instancetype)queueWithPriorities:(NSDictionary<ObjectType,NSNumber *> *)priorities {
    return [[NCPriorityQueue alloc] initWithPriorities:priorities];
}

-(NSUInteger)count {
    return [_queue count];
}

-(id)objectAtIndex:(NSUInteger)index {
    return [_queue objectAtIndex:index];
}

-(void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    [self addObject:anObject];
}

-(void)removeObjectAtIndex:(NSUInteger)index {
    [_queue removeObjectAtIndex:index];
}

-(void)addObject:(id)anObject {
    NSInteger n;
    for (n=0; n<[_queue count]; n++) {
        if ([_prio[_queue[n]] isLessThan:_prio[anObject]]) {
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

-(void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    [self removeObjectAtIndex:index];
    [self addObject:anObject];
}

@end
