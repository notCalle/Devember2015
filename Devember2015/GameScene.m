//
//  GameScene.m
//  Devember2015
//
//  Created by Calle Englund on 01/12/15.
//  Copyright (c) 2015 Calle Englund. All rights reserved.
//

#import "GameScene.h"
#import <Carbon/Carbon.h>
#import "NCActorEntity.h"
#import "NCPlayerEntity.h"
#import "NCCreepyEntity.h"
#import "NCCrawlyEntity.h"
#import "NCBodyComponent.h"
#import "Tiles.h"
#import "IsoTileMap.h"
#import "NCConsoleNode.h"
#import "NCSpriteNode.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    _lastTime = 0.0;
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

    _player = [NCPlayerEntity entityForScene:self];
    [_player didSpawnAt:[_tileMap tileAt:(vector_int2){W/2,H/2}]];

    NCActorEntity *creepy = [NCCreepyEntity entityForScene:self];
    [creepy didSpawnAt:[_tileMap tileAt:(vector_int2){40,40}]];
    
    NCActorEntity *crawly = [NCCrawlyEntity entityForScene:self];
    [crawly didSpawnAt:[_tileMap tileAt:(vector_int2){40,60}]];
    
    
}

-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    
    CGPoint location = [theEvent locationInNode:self];
    vector_int2 grid = [_tileMap gridAtLocation:location];

    [_player willMoveTo:[_tileMap tileAt:grid]];
}

-(void)keyDown:(NSEvent *)theEvent {
    UInt16 keycode = [theEvent keyCode];
    
    switch (keycode) {
        case kVK_ANSI_W:
            [_player willMove:MOVE_NORTH];
            break;
        case kVK_ANSI_S:
            [_player willMove:MOVE_SOUTH];
            break;
        case kVK_ANSI_A:
            [_player willMove:MOVE_WEST];
            break;
        case kVK_ANSI_D:
            [_player willMove:MOVE_EAST];
            break;
        case kVK_Space:
            [_player willLightTorch];
            break;
        default:
            break;
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */

    CGPoint positionInScene = [_player.scene convertPoint:_player.body.sprite.position
                                                 fromNode:_player.body.sprite.parent];
    CGPoint distanceFromCenter = CGPointMake(positionInScene.x - CGRectGetMidX(self.frame),
                                             positionInScene.y - CGRectGetMidY(self.frame));
    if (!CGPointEqualToPoint(distanceFromCenter, CGPointZero)) {
        _tileMap.position = CGPointMake(_tileMap.position.x - distanceFromCenter.x/10.0,
                                        _tileMap.position.y - distanceFromCenter.y/20.0);
    }
    
    _daylight = cos(currentTime/60.0)*0.75 + cos(currentTime/600.0)*0.25;
    if (_daylight > 1.0)
        _daylight = 1.0;
    else if (_daylight < 0.0)
        _daylight = 0.0;
    
    if (_lastTime > 0.0) {
        NSTimeInterval deltaTime = currentTime - _lastTime;

        for (NCActorEntity *actor in _actors) {
            [actor updateWithDeltaTime:deltaTime];
        }
    }
    _lastTime = currentTime;
}

@end
