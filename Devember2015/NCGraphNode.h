//
//  NCGraphNode.h
//  Devember2015
//
//  Created by Calle Englund on 15/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NCPriorityQueue.h"

@protocol NCGraphNode <NCQueuePriority>

@property(nonatomic) CGFloat estimatedGoalCost;
@property(nonatomic) CGFloat bestPathCost;
@property(readonly) NSArray<id<NCGraphNode>> *neighbors;
@property id<NCGraphNode> cameFrom;
@property BOOL visited;

@end
