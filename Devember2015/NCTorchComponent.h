//
//  NCTorchComponent.h
//  Devember2015
//
//  Created by Calle Englund on 26/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <GameplayKit/GameplayKit.h>
#import <SpriteKit/SpriteKit.h>
#import "NCActorEntity.h"

@interface NCTorchComponent : GKComponent <NCActorInteraction>

@property(readonly) CGFloat burnTime;
@property(readonly) CGFloat burnOutTime;
@property(readonly) SKLightNode *light;
@property NSColor *lightColor;
@property(readonly) BOOL isLit;
@property(readonly) BOOL isBurnedOut;

@end
