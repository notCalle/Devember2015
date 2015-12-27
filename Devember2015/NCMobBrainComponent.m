//
//  NCMobBrainComponent.m
//  Devember2015
//
//  Created by Calle Englund on 27/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCMobBrainComponent.h"
#import "NCBodyComponent.h"
#import "NCActorEntity.h"
#import "NCSpriteNode.h"
#import "GameScene.h"
#import "IsoTileNode.h"
#import "NCConsoleNode.h"
#import "NCPerlinNoise.h"

@implementation NCMobBrainComponent

-(void)updateWithDeltaTime:(NSTimeInterval)seconds {
    NCActorEntity *entity = (NCActorEntity *)self.entity;
    
    if (![entity.body.sprite hasActions]) {
        GameScene *scene = (GameScene *)entity.scene;
        NCActorEntity *player = scene.player;
        IsoTileNode *myTile = entity.body.sprite.tile;
        IsoTileNode *playerTile = player.body.sprite.tile;
        NSInteger dx = (myTile.gridPosition.x - playerTile.gridPosition.x);
        NSInteger dy = (myTile.gridPosition.y - playerTile.gridPosition.y);
        CGFloat distance = sqrt(dx*dx + dy*dy);
        CGFloat direction = entity.body.direction;
        
        if (_aggressor && distance < _aggressiveness) {
            IsoTileNode *aggressorTile = _aggressor.body.sprite.tile;
            [scene.console addText:[NSString stringWithFormat:@"%@ is hunting %@...",
                                    entity.name, _aggressor.name]];
            [entity willMoveTo:aggressorTile];
        } else if (distance < _cowardice) {
            // should move away from instead of randomly
            NCPerlinNoise *noise = [NCPerlinNoise octaves:5 persistance:0.5];
            CGFloat directionChange = [noise perlinNoise:scene.lastTime] * 2.0;
            if (directionChange > 0.0) {
                direction += directionChange + 1.0;
            } else {
                direction += directionChange - 1.0;
            }
            [entity willMove:((int)direction) & 0x7];
        } else if (distance < _curiosity) {
            [entity willMoveTo:playerTile maxSteps:1];
        } else {
            NCPerlinNoise *noise = [NCPerlinNoise octaves:5 persistance:0.5];
            direction += [noise perlinNoise:scene.lastTime];
            [entity willMove:((int)direction) & 0x7];
        }
    }
}

#pragma mark - NCActorInteraction Protocol

-(void)didKill:(NCActorEntity *)victim {
    if (_aggressor == victim) {
        _aggressor = nil;
    }
}

@end
