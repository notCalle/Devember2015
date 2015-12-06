//
//  PlayerSpriteNode.h
//  Devember2015
//
//  Created by Calle Englund on 2015-12-05.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ITSpriteNode.h"
#import "IsoTileMap.h"

@interface PlayerSpriteNode : ITSpriteNode

@property SKLightNode *light;
@property NSTimeInterval lightTime;
@property NSColor *lightColor;
@property NSColor *ambientColor;

-(SKLightNode *)addLightNode;

-(void)reParent:(ITSpriteNode *)newParent;
-(BOOL)move:(char)direction;

-(void)update:(NSTimeInterval)currentTime;

@end
