//
//  NCMobBrainComponent.h
//  Devember2015
//
//  Created by Calle Englund on 27/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCComponent.h"

@interface NCMobBrainComponent : NCComponent {
    NCActorEntity *_aggressor;
}

@property CGFloat cowardice;
@property CGFloat curiosity;
@property CGFloat aggressiveness;
@property(readonly) GKRuleSystem *ruleSystem;

@end
