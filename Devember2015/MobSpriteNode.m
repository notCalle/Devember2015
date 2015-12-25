//
//  MobSpriteNode.m
//  Devember2015
//
//  Created by Calle Englund on 20/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "MobSpriteNode.h"
#import "GameScene.h"
#import "IsoTileMap.h"
#import "IsoTileNode.h"

@implementation MobSpriteNode

-(instancetype)initWithImageNamed:(NSString *)name cowardice:(CGFloat)cowardice curiosity:(CGFloat)curiosity {
    self = [super initWithImageNamed:name];
    if (self) {
        _cowardice = cowardice;
        _curiosity = curiosity;
    }
    return self;
}

+(instancetype)withImageNamed:(NSString *)name cowardice:(CGFloat)cowardice curiosity:(CGFloat)curiosity {
    return [[MobSpriteNode alloc] initWithImageNamed:name cowardice:cowardice curiosity:curiosity];
}

-(void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];
    if (![self hasActions]) {
        GameScene *scene = (GameScene *)[self scene];
        ActorSpriteNode *player = (ActorSpriteNode *)scene.player;
        IsoTileNode *myTile = (IsoTileNode *)self.parent;
        IsoTileNode *playerTile = (IsoTileNode *)player.parent;
        NSInteger dx = (myTile.gridPosition.x - playerTile.gridPosition.x);
        NSInteger dy = (myTile.gridPosition.y - playerTile.gridPosition.y);
        CGFloat distance = sqrt(dx*dx + dy*dy);

        if (_aggressor && distance < _aggressiveness) {
            IsoTileNode *aggressorTile = (IsoTileNode *)_aggressor.parent;
            [scene.console addText:[NSString stringWithFormat:@"%@ is hunting %@...", self.name, _aggressor.name]];
            [self moveTo:aggressorTile];
        } else if (distance < _cowardice) {
            // should move away from instead of randomly
            NCPerlinNoise *noise = [NCPerlinNoise octaves:5 persistance:0.5];
            CGFloat directionChange = [noise perlinNoise:currentTime] * 2.0;
            if (directionChange > 0.0) {
                _direction += directionChange + 1.0;
            } else {
                _direction += directionChange - 1.0;
            }
            [self move:((int)_direction) & 0x7];
        } else if (distance < _curiosity) {
            [self moveTo:playerTile maxSteps:1];
        } else {
            NCPerlinNoise *noise = [NCPerlinNoise octaves:5 persistance:0.5];
            _direction += [noise perlinNoise:currentTime];
            [self move:((int)_direction) & 0x7];
        }
    }
}

@end
