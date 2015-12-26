//
//  ClutterSpriteNode.m
//  Devember2015
//
//  Created by Calle Englund on 2015-12-19.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCSpriteNode.h"
#import "IsoTileNode.h"

@implementation NCSpriteNode

-(instancetype)initWithEntity:(NCActorEntity *)entity {
    self = [self init];
    if (self) {
        _entity = entity;
    }
    return self;
}

-(void)setTile:(IsoTileNode *)tile {
    if (self.parent) {
        [self removeFromParent];
    }
    if (tile) {
        self.position = CGPointMake(0.0, (tile.stepHeight - 0.5) * tile.size.width / 2.0);
        self.zPosition = 0.5;
        [tile addChild:self];
    }
}

-(IsoTileNode *)tile {
    return (IsoTileNode *)self.parent;
}

@end
