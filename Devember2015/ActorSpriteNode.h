//
//  ActorSpriteNode.h
//  Devember2015
//
//  Created by Calle Englund on 07/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

@import GameKit;
#import "ClutterSpriteNode.h"

@interface ActorSpriteNode : ClutterSpriteNode {
    NSMutableArray<SKAction *> *_actions;
}

@property CGFloat stepHeight;

-(IsoTileNode *)tileInDirection:(char)direction;
-(void)move:(char)direction;
-(void)moveTo:(IsoTileNode *)target;
-(void)addAction:(SKAction *)action;
-(void)addActionStepTo:(IsoTileNode *)target from:(IsoTileNode *)here;
-(BOOL)canStepTo:(IsoTileNode *)target;
-(BOOL)canStepTo:(IsoTileNode *)target from:(IsoTileNode *)here;
-(CGFloat)costOfStepTo:(IsoTileNode *)target;
-(CGFloat)costOfStepTo:(IsoTileNode *)target from:(IsoTileNode *)here;

-(void)update:(NSTimeInterval)currentTime;

@end
