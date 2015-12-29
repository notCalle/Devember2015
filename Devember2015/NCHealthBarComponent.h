//
//  NCHealthBarComponent.h
//  Devember2015
//
//  Created by Calle Englund on 2015-12-29.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <GameplayKit/GameplayKit.h>
#import <SpriteKit/SpriteKit.h>
#import "NCActorEntity.h"

@class NCBodyComponent;

@interface NCHealthBarComponent : GKComponent <NCActorInteraction>

@property(readonly) SKShapeNode *healthBar;
@property(readonly) SKShapeNode *healthBox;
@property(readonly) NCBodyComponent *body;
@property(nonatomic) CGFloat fadeToAlpha;

-(instancetype)initWithBody:(NCBodyComponent *)body;

@end
