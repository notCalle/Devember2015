//
//  CreepySpriteNode.m
//  Devember2015
//
//  Created by Calle Englund on 2015-12-23.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "CreepySpriteNode.h"

@implementation CreepySpriteNode

-(instancetype)init {
    self = [super initWithImageNamed:@"Clutter/Creepy"];
    if (self) {
        self.name = @"Creepy";
        self.anchorPoint = CGPointMake(0.5, 0.0);
        self.health = 2.0;
        self.stepHeight = 0.5;
        self.stepSpeed = 0.5;
        self.cowardice = 5.0;
        self.curiosity = 10.0;
    }
    return self;
}

@end
