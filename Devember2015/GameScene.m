//
//  GameScene.m
//  Devember2015
//
//  Created by Calle Englund on 01/12/15.
//  Copyright (c) 2015 Calle Englund. All rights reserved.
//

#import "GameScene.h"
#import <Carbon/Carbon.h>

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */

#define W 100
#define H 100
    
//    NSArray<IsoTile *> *tiles = @[[IsoTile tileWithImageNamed:@"Grass+Water/GGGG1" height:0.2],
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/GGGG2" height:0.2],
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/GGGG3" height:0.2],
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/GGGG4" height:0.2],
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/WWWW1" height:-0.1 cost:2.0],
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/WWWW2" height:-0.2 cost:2.0],
//
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/GGGW" height:0.1],
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/GGWG" height:0.1],
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/GGWW" height:0.1],
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/GWGG" height:0.1],
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/GWGW" height:0.1],
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/GWWG" height:0.1],
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/GWWW" height:0.1],
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/WGGG" height:0.1],
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/WGGW" height:0.1],
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/WGWG" height:0.1],
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/WGWW" height:0.1],
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/WWGG" height:0.1],
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/WWGW" height:0.1],
//                                  [IsoTile tileWithImageNamed:@"Grass+Water/WWWG" height:0.1],
//                                  ];
    
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
    _player.anchorPoint = CGPointMake(0.5, 0);
    _player.stepHeight = 1.0;
    [_player reParent:[_tileMap tileAt:_tileMap.centerTile]];
//    [_tileMap addChild:_player toTileAt:_tileMap.centerTile];
}

-(void)mouseMoved:(NSEvent *)theEvent {
    static vector_int2 lastGrid;
    CGPoint location = [theEvent locationInNode:self];
    vector_int2 grid = [_tileMap gridAtLocation:location];
    if (grid.x != lastGrid.x && grid.y != lastGrid.y) {
        [_tileMap tileAt:lastGrid].colorBlendFactor = 0.0;
        [_tileMap tileAt:grid].color = [NSColor redColor];
        [_tileMap tileAt:grid].colorBlendFactor = 1.0;
        lastGrid = grid;
    }
}

-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    
    CGPoint location = [theEvent locationInNode:self];
    vector_int2 grid = [_tileMap gridAtLocation:location];

    [_player moveTo:[_tileMap tileAt:grid]];
}

-(void)keyDown:(NSEvent *)theEvent {
    UInt16 keycode = [theEvent keyCode];
    
    switch (keycode) {
        case kVK_ANSI_W:
            [_player move:'N'];
            break;
        case kVK_ANSI_S:
            [_player move:'S'];
            break;
        case kVK_ANSI_A:
            [_player move:'W'];
            break;
        case kVK_ANSI_D:
            [_player move:'E'];
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
    [_player update:currentTime];
    CGPoint positionInScene = [_player.scene convertPoint:_player.position fromNode:_player.parent];
    CGPoint distanceFromCenter = CGPointMake(positionInScene.x - CGRectGetMidX(self.frame),
                                             positionInScene.y - CGRectGetMidY(self.frame));
    if (!CGPointEqualToPoint(distanceFromCenter, CGPointZero)) {
        _tileMap.position = CGPointMake(_tileMap.position.x - distanceFromCenter.x/10.0,
                                        _tileMap.position.y - distanceFromCenter.y/20.0);
    }

    
}

@end
