//
//  NCPriorityQueue.h
//  Devember2015
//
//  Created by Calle Englund on 14/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCPriorityQueue<ObjectType> : NSMutableArray {
    NSMutableArray<ObjectType> *_queue;
    NSDictionary<ObjectType,NSNumber *> *_prio;
}

-(instancetype)initWithPriorities:(NSDictionary<ObjectType,NSNumber *> *)priorities;
+(instancetype)queueWithPriorities:(NSDictionary<ObjectType,NSNumber *> *)priorities;

@end
