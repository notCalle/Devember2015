//
//  NCTorchComponent.h
//  Devember2015
//
//  Created by Calle Englund on 26/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCComponent.h"
#import <SpriteKit/SpriteKit.h>

@class NCBodyComponent;

@interface NCTorchComponent : NCComponent

@property(readonly) CGFloat burnTime;
@property(readonly) CGFloat burnOutTime;
@property(readonly) SKLightNode *light;
@property(readonly) SKSpriteNode *torch;
@property NSColor *lightColor;
@property(readonly) BOOL isLit;
@property(readonly) BOOL isBurnedOut;
@property(readonly) CGFloat burnOut;

-(instancetype)initWithBody:(NCBodyComponent *)body;

@end
