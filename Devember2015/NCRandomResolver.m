//
//  NCRandomResolver.m
//  Devember2015
//
//  Created by Calle Englund on 29/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCRandomResolver.h"

@implementation NCRandomResolver

-(instancetype)init {
    self = [super init];
    if (self) {
        _randomSource = [GKARC4RandomSource new];
    }
    return self;
}

-(BOOL)isSuccessful:(CGFloat)attack vs:(CGFloat)defense {
    return [self successGrade:attack vs:defense] > 0.0;
}

-(CGFloat)successGrade:(CGFloat)attack vs:(CGFloat)defense {
    CGFloat chance;
    CGFloat random = _randomSource.nextUniform;
    
    if (attack > defense) {
        // chance of defender winning
        chance = defense/attack/2.0;
        return (random - chance)/chance;
    } else {
        // chance of attacker winning
        chance = attack/defense/2.0;
        return (chance - random)/chance;
    }
}

@end
