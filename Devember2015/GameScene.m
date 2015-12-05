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
    
    _myPosition = _tileMap.centerTile;
    
    _light = [[SKLightNode alloc] init];
    _light.ambientColor = [NSColor blueColor];
    _light.lightColor = [NSColor yellowColor];
    _light.falloff = 1.0;
    _light.categoryBitMask = 0x1;
    _lighttime = 0.0;
    
    _player = [SKSpriteNode spriteNodeWithImageNamed:@"Clutter/Player"];
    [_player addChild:_light];
    [_tileMap positionSprite:_player at:_myPosition];
    [self addChild:_player];
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
            _myPosition.y -= 1;
            break;
        case kVK_ANSI_S:
            _myPosition.y += 1;
            break;
        case kVK_ANSI_A:
            _myPosition.x -= 1;
            break;
        case kVK_ANSI_D:
            _myPosition.x += 1;
            break;
        case kVK_Tab:
            _lighttime = theEvent.timestamp;
            break;
        default:
            break;
    }
    [_tileMap positionSprite:_player at:_myPosition];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    CFTimeInterval burntime = (currentTime - _lighttime);
    if (burntime < 10.0) {
        NSColor *lightcolor = [NSColor blackColor];
        _light.lightColor = [lightcolor blendedColorWithFraction:(burntime * burntime)/100.0
                                                         ofColor:[NSColor yellowColor]];
    } else {
//        _light.lightColor = [NSColor blackColor];
    }
}

@end
