//
//  ActorSpriteNode.h
//  Devember2015
//
//  Created by Calle Englund on 07/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

@import GameKit;
#import "IsoTileNode.h"
#import "IsoTileMap.h"

@interface ActorSpriteNode : SKSpriteNode

@property CGFloat stepHeight;

-(void)reParent:(IsoTileNode *)newParent;
-(IsoTileNode *)tileInDirection:(char)direction;
-(BOOL)move:(char)direction;
-(BOOL)canStepTo:(IsoTileNode *)target;
-(BOOL)canStepTo:(IsoTileNode *)target from:(IsoTileNode *)here;
-(CGFloat)costOfStepTo:(IsoTileNode *)target;
-(CGFloat)costOfStepTo:(IsoTileNode *)target from:(IsoTileNode *)here;

@end
