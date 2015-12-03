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

#define W 5
#define H 5
    NSInteger map[H][W] = {
        {1, 1, 1, 1, 1},
        {1, 0, 0, 0, 0},
        {1, 0, 0, 1, 0},
        {1, 0, 1, 1, 0},
        {1, 0, 0, 0, 0}
    };
    
    NSArray *tiles = @[@"Tiles/black", @"Tiles/blue"];
    _tileMap = [[IsoTileMap alloc] initWithTiles:tiles mapSize:CGSizeMake(W,H)];
    
    NSInteger x, y;
    for (y=0; y<H; y++) {
        for (x=0; x<W; x++) {
            [_tileMap setTile:map[y][x] at:CGPointMake(x, y)];
            
        }
    }

    _tileMap.position = CGPointMake(CGRectGetMidX(self.frame),
                                    CGRectGetMidY(self.frame));
    _tileMap.centerTile = CGPointMake(3, 3);
    [_tileMap addAsChildOf:self];
}

-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    
    CGPoint location = [theEvent locationInNode:self];

    CGPoint grid = [_tileMap gridAtLocation:location];

    _tileMap.centerTile = grid;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
