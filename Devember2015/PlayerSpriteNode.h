//
//  PlayerSpriteNode.h
//  Devember2015
//
//  Created by Calle Englund on 2015-12-05.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "IsoTileMap.h"

@interface PlayerSpriteNode : SKSpriteNode {
    CGPoint _myPosition;
}

@property CGPoint myPosition;
@property SKLightNode *light;
@property NSTimeInterval lighttime;

-(BOOL)reposition;

-(BOOL)moveNorth;
-(BOOL)moveSouth;
-(BOOL)moveWest;
-(BOOL)moveEast;

@end
