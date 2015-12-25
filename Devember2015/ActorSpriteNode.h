//
//  ActorSpriteNode.h
//  Devember2015
//
//  Created by Calle Englund on 07/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

@import GameKit;
#import "NCSpriteNode.h"

@interface ActorSpriteNode : NCSpriteNode {
    NSMutableArray<SKAction *> *_actions;
    ActorSpriteNode *_aggressor;
}

@property CGFloat health;

-(void)addAction:(SKAction *)action;
-(void)addActionStepTo:(IsoTileNode *)target from:(IsoTileNode *)here;

-(void)update:(NSTimeInterval)currentTime;

-(void)didGetAttackedBy:(ActorSpriteNode *)aggressor;
-(void)didGetKilledBy:(ActorSpriteNode *)aggressor;
-(void)didKill:(ActorSpriteNode *)victim;

@end
