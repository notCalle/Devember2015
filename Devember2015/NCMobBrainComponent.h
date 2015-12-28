//
//  NCMobBrainComponent.h
//  Devember2015
//
//  Created by Calle Englund on 27/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <GameplayKit/GameplayKit.h>
#import "NCActorEntity.h"

@interface NCMobBrainComponent : GKComponent <NCActorInteraction> {
    NCActorEntity *_aggressor;
}

@property CGFloat cowardice;
@property CGFloat curiosity;
@property CGFloat aggressiveness;
@property(readonly) GKRuleSystem *ruleSystem;

@end
