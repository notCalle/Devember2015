//
//  CrawlySpriteNode.m
//  Devember2015
//
//  Created by Calle Englund on 2015-12-23.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "CrawlySpriteNode.h"

@implementation CrawlySpriteNode

-(instancetype)init {
    self = [super initWithImageNamed:@"Clutter/Crawly"];
    if (self) {
        self.name = @"Crawly";
        self.anchorPoint = CGPointMake(0.5, 0);
        self.health = 3.0;
        self.stepHeight = 1.0;
        self.stepSpeed = 0.3;
        self.cowardice = 2.0;
        self.curiosity = 10.0;
        self.aggressiveness = 20.0;
    }
    return self;
}
@end
