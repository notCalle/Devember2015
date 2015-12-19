//
//  ClutterSpriteNode.h
//  Devember2015
//
//  Created by Calle Englund on 2015-12-19.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "IsoTileNode.h"

@interface ClutterSpriteNode : SKSpriteNode

-(void)reParent:(IsoTileNode *)newParent;

@end
