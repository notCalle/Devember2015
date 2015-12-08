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

#define W 15
#define H 15
    
    NSArray<IsoTile *> *tiles = @[[IsoTile tileWithImageNamed:@"Grass+Water/G1" andStep:0.1],
                                  [IsoTile tileWithImageNamed:@"Grass+Water/G2" andStep:0.1],
                                  [IsoTile tileWithImageNamed:@"Grass+Water/G3" andStep:0.1],
                                  [IsoTile tileWithImageNamed:@"Grass+Water/G4" andStep:0.1],
                                  [IsoTile tileWithImageNamed:@"Grass+Water/W1" andStep:-CGFLOAT_MAX],
                                  [IsoTile tileWithImageNamed:@"Grass+Water/W2" andStep:-CGFLOAT_MAX]
                                  ];
    _tileMap = [[IsoTileMap alloc] initWithTiles:tiles mapSize:CGSizeMake(W,H)];
    
//    NSInteger map[H][W] = {
//        {2, 2, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 2, 2, 2},
//        {2, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 2},
//        {2, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 2},
//        {2, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 2},
//        {3, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 2},
//        {2, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 2},
//        {2, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 2},
//        {0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0},
//        {2, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 2},
//        {2, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 2},
//        {2, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 2},
//        {2, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 2},
//        {2, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 2},
//        {2, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 2},
//        {2, 2, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 2, 2, 2}
//    };
//    NSInteger x, y;
//    for (y=0; y<H; y++) {
//        for (x=0; x<W; x++) {
//            [_tileMap setTile:map[y][x] at:CGPointMake(x, y)];
//            
//        }
//    }

    [_tileMap randomizeMap];
    
    _tileMap.position = CGPointMake(CGRectGetMidX(self.frame),
                                    CGRectGetMidY(self.frame));
    _tileMap.centerTile = CGPointMake(7, 7);
    [self addChild:_tileMap];

    _player = [PlayerSpriteNode spriteNodeWithImageNamed:@"Clutter/Player"];
    _player.anchorPoint = CGPointMake(0.5, 0);
    _player.stepHeight = 1.5;
    [_player addLightNode];
    
    [_tileMap addChild:_player toTileAt:CGPointMake(0,7)];
}

-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    
    CGPoint location = [theEvent locationInNode:self];

    CGPoint grid = [_tileMap gridAtLocation:location];

    _tileMap.centerTile = grid;
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
}

@end
