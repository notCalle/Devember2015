//
//  ClutterSpriteNode.h
//  Devember2015
//
//  Created by Calle Englund on 2015-12-19.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class IsoTileNode;
@class NCActorEntity;

@interface NCSpriteNode : SKSpriteNode

@property IsoTileNode *tile;
@property(readonly) NCActorEntity *entity;

-(instancetype)initWithEntity:(NCActorEntity *)entity;

@end
