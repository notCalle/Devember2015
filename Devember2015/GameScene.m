//
//  GameScene.m
//  Devember2015
//
//  Created by Calle Englund on 01/12/15.
//  Copyright (c) 2015 Calle Englund. All rights reserved.
//

#import "GameScene.h"
#import <Carbon/Carbon.h>
#import "Actors.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */

    _actors = [NSMutableSet new];
    _console = [NCConsoleNode withCapacity:5];
    _console.zPosition = 1000.0;
    _console.position = CGPointMake(self.frame.size.width/-2.1, self.frame.size.height/2.1);
    [self addChild:_console];
    [_console addText:@"Initializing..."];
    
#define W 100
#define H 100

    NSArray<IsoTile *> *tiles = @[[WaterTile00 tile],
                                  [SandTile01 tile],
                                  [GrassTile02 tile],
                                  [GrassTile03 tile],
                                  [GrassyMountainTile04 tile],
                                  [RockyMountainTile05 tile],
                                  [SnowyMountainTile06 tile]];
    
    _tileMap = [[IsoTileMap alloc] initWithTiles:tiles width:W height:H];
    [_tileMap randomizeMap];

    [self addChild:_tileMap];

    _player = [PlayerSpriteNode spriteNodeWithImageNamed:@"Clutter/Player"];
    _player.name = @"Player";
    _player.anchorPoint = CGPointMake(0.5, 0);
    _player.stepHeight = 0.5;
    _player.stepSpeed = 1.0;
    _player.health = 10.0;
    
    [_player reParent:[_tileMap tileAt:_tileMap.centerTile]];
    
    MobSpriteNode *creepy = [CreepySpriteNode new];
    [creepy reParent:[_tileMap tileAt:(vector_int2){40,40}]];
    
    MobSpriteNode *crawly = [CrawlySpriteNode new];
    [crawly reParent:[_tileMap tileAt:(vector_int2){40,60}]];
    
    
}

-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    
    CGPoint location = [theEvent locationInNode:self];
    vector_int2 grid = [_tileMap gridAtLocation:location];

    [_player removeAllActions];
    [_player moveTo:[_tileMap tileAt:grid]];
}

-(void)keyDown:(NSEvent *)theEvent {
    UInt16 keycode = [theEvent keyCode];
    
    switch (keycode) {
        case kVK_ANSI_W:
            [_player move:MOVE_NORTH];
            break;
        case kVK_ANSI_S:
            [_player move:MOVE_SOUTH];
            break;
        case kVK_ANSI_A:
            [_player move:MOVE_WEST];
            break;
        case kVK_ANSI_D:
            [_player move:MOVE_EAST];
            break;
        case kVK_Space:
            [_player addLightNode];
            break;
        default:
            break;
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    for (ActorSpriteNode *actor in _actors) {
        [actor update:currentTime];
    }
    CGPoint positionInScene = [_player.scene convertPoint:_player.position fromNode:_player.parent];
    CGPoint distanceFromCenter = CGPointMake(positionInScene.x - CGRectGetMidX(self.frame),
                                             positionInScene.y - CGRectGetMidY(self.frame));
    if (!CGPointEqualToPoint(distanceFromCenter, CGPointZero)) {
        _tileMap.position = CGPointMake(_tileMap.position.x - distanceFromCenter.x/10.0,
                                        _tileMap.position.y - distanceFromCenter.y/20.0);
    }

    
}

@end
