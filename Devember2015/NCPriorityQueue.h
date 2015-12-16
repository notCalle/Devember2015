//
//  NCPriorityQueue.h
//  Devember2015
//
//  Created by Calle Englund on 14/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NCQueuePriority <NSObject>

@property(readonly) CGFloat priority;

@end

@interface NCPriorityQueue<ObjectType> : NSMutableArray {
    NSMutableArray<ObjectType> *_queue;
}

+(instancetype)queue;

@end
