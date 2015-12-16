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
    
    NSArray<IsoTile *> *tiles = @[[IsoTile tileWithImageNamed:@"Terrain/00-Water" height:0 cost:3.0],
                                  [IsoTile tileWithImageNamed:@"Terrain/01-Sandy" height:0.5 cost:1.5],
                                  [IsoTile tileWithImageNamed:@"Terrain/02-Grass" height:1.0 cost:1.0],
                                  [IsoTile tileWithImageNamed:@"Terrain/03-Grass" height:1.5 cost:1.0],
                                  [IsoTile tileWithImageNamed:@"Terrain/04-Grassy mountains" height:2.0 cost:1.5],
                                  [IsoTile tileWithImageNamed:@"Terrain/05-Rocky mountains" height:2.5 cost:1.5],
                                  [IsoTile tileWithImageNamed:@"Terrain/06-Snowy mountains" height:3.0 cost:2.0]];
    
    _tileMap = [[IsoTileMap alloc] initWithTiles:tiles width:W height:H];
    [_tileMap randomizeMap];

    _tileMap.centerTile = (vector_int2){0,7};
    [self addChild:_tileMap];

    _player = [PlayerSpriteNode spriteNodeWithImageNamed:@"Clutter/Player"];
    _player.anchorPoint = CGPointMake(0.5, 0);
    _player.stepHeight = 0.5;
    [_player addLightNode];
    
    [_tileMap addChild:_player toTileAt:(vector_int2){0,7}];
}

-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    
    CGPoint location = [theEvent locationInNode:self];
    vector_int2 grid = [_tileMap gridAtLocation:location];
    NCPathFinder *pathFinder = [NCPathFinder finderFor:_player on:_tileMap];
    NSArray<IsoTileNode *> *path = [pathFinder findPathTo:[_tileMap tileAt:grid]];
    for (IsoTileNode *tile in path) {
        tile.color = [NSColor redColor];
        tile.colorBlendFactor = 1.0;
        [tile runAction:[SKAction colorizeWithColorBlendFactor:0.0 duration:5.0]];
    }
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
