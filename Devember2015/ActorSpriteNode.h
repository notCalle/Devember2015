//
//  ActorSpriteNode.h
//  Devember2015
//
//  Created by Calle Englund on 07/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "ITSpriteNode.h"

@interface ActorSpriteNode : ITSpriteNode

@property CGFloat stepHeight;

-(BOOL)reParent:(ITSpriteNode *)newParent;
-(BOOL)move:(char)direction;

@end
