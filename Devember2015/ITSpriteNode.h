//
//  ITSpriteNode.h
//  Devember2015
//
//  Created by Calle Englund on 06/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ITSpriteNode : SKSpriteNode

@property(nonatomic) ITSpriteNode *north;
@property(nonatomic) ITSpriteNode *south;
@property(nonatomic) ITSpriteNode *west;
@property(nonatomic) ITSpriteNode *east;

@end
