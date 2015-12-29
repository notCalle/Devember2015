//
//  NCComponent.h
//  Devember2015
//
//  Created by Calle Englund on 29/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <GameplayKit/GameplayKit.h>
#import "NCPriorityQueue.h"
#import "NCActorEntity.h"

@interface NCComponent : GKComponent <NCQueuePriority,NCActorInteraction> {
    CGFloat _priority;
}

@end
