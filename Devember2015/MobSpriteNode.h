//
//  MobSpriteNode.h
//  Devember2015
//
//  Created by Calle Englund on 20/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "ActorSpriteNode.h"

@interface MobSpriteNode : ActorSpriteNode

@property CGFloat cowardice;
@property CGFloat curiosity;
@property CGFloat aggressiveness;

-(instancetype)initWithImageNamed:(NSString *)name cowardice:(CGFloat)cowardice curiosity:(CGFloat)curiosity;
+(instancetype)withImageNamed:(NSString *)name cowardice:(CGFloat)cowardice curiosity:(CGFloat)curiosity;

@end
