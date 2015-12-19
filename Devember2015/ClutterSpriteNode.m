//
//  ClutterSpriteNode.m
//  Devember2015
//
//  Created by Calle Englund on 2015-12-19.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "ClutterSpriteNode.h"

@implementation ClutterSpriteNode

-(void)reParent:(IsoTileNode *)newParent {
    if (newParent) {
        if (self.parent) {
            [self removeFromParent];
        }
        self.position = CGPointMake(0.0, (newParent.stepHeight - 0.5) * newParent.size.width / 2.0);
        self.zPosition = 0.5;
        [newParent addChild:self];
    }
}

@end
