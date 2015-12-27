//
//  NCMobBrainComponent.m
//  Devember2015
//
//  Created by Calle Englund on 27/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCMobBrainComponent.h"

@implementation NCMobBrainComponent

-(void)didKill:(NCActorEntity *)victim {
    if (_aggressor == victim) {
        _aggressor = nil;
    }
}

@end
