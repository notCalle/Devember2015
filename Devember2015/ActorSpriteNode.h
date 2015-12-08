//
//  ActorSpriteNode.h
//  Devember2015
//
//  Created by Calle Englund on 07/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "IsoTileNode.h"

@interface ActorSpriteNode : SKSpriteNode

@property CGFloat stepHeight;

-(BOOL)reParent:(IsoTileNode *)newParent;
-(BOOL)move:(char)direction;

@end
