//
//  GameScene.m
//  Devember2015
//
//  Created by Calle Englund on 01/12/15.
//  Copyright (c) 2015 Calle Englund. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */

#define W 15
#define H 15
    NSInteger map[H][W] = {
        {2, 2, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 2, 2, 2},
        {2, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 2},
        {2, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 2},
        {2, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 2},
        {2, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 2},
        {2, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 2},
        {2, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 2},
        {0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0},
        {2, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 2},
        {2, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 2},
        {2, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 2},
        {2, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 2},
        {2, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 2},
        {2, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 2},
        {2, 2, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 2, 2, 2}
    };
    
    NSArray *tiles = @[@"Tiles/White", @"Tiles/Gray", @"Walls/WhiteWall"];
    _tileMap = [[IsoTileMap alloc] initWithTiles:tiles mapSize:CGSizeMake(W,H)];
    
    NSInteger x, y;
    for (y=0; y<H; y++) {
        for (x=0; x<W; x++) {
            [_tileMap setTile:map[y][x] at:CGPointMake(x, y)];
            
        }
    }

    _tileMap.position = CGPointMake(CGRectGetMidX(self.frame),
                                    CGRectGetMidY(self.frame));
    _tileMap.centerTile = CGPointMake(8, 8);
    [_tileMap addAsChildOf:self];
    
    _player = [SKSpriteNode spriteNodeWithImageNamed:@"Clutter/Player"];
    [_tileMap positionSprite:_player at:_tileMap.centerTile];
    [self addChild:_player];
}

-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    
    CGPoint location = [theEvent locationInNode:self];

    CGPoint grid = [_tileMap gridAtLocation:location];

    [_tileMap positionSprite:_player at:grid];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
