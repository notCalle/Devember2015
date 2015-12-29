//
//  NCHealthBarComponent.m
//  Devember2015
//
//  Created by Calle Englund on 2015-12-29.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCHealthBarComponent.h"
#import "NCActorEntity.h"
#import "NCBodyComponent.h"
#import "NCSpriteNode.h"

@implementation NCHealthBarComponent

-(instancetype)init {
    self = [super init];
    if (self) {
        _priority = 0.0;
        CGRect outer = CGRectMake(0.0, 0.0, 64.0, 4.0);
        CGRect inner = CGRectMake(0.0, 0.0, 64.0, 4.0);
        _healthBar = [SKShapeNode shapeNodeWithRect:inner];
        _healthBar.fillColor = [NSColor greenColor];
        _healthBar.lineWidth = 0.0;
        _healthBox = [SKShapeNode shapeNodeWithRect:outer];
        _healthBox.fillColor = [NSColor blackColor];
        _healthBox.strokeColor = _healthBox.fillColor;
        _healthBox.glowWidth = 1.0;
        _healthBox.lineWidth = 1.0;
        _fadeToAlpha = 0.0;
        _healthBox.alpha = _fadeToAlpha;
        [_healthBox addChild:_healthBar];
    }
    return self;
}

-(instancetype)initWithBody:(NCBodyComponent *)body {
    self = [self init];
    if (self) {
        _body = body;
        _healthBox.position = CGPointMake(-32.0, -8.0);
        _healthBox.zPosition = 10.0;
        [_body.sprite addChild:_healthBox];
    }
    return self;
}

-(void)setFadeToAlpha:(CGFloat)fadeToAlpha {
    _fadeToAlpha = fadeToAlpha;
    _healthBox.alpha = fadeToAlpha;
}

#pragma mark - clock tick update

-(void)updateWithDeltaTime:(NSTimeInterval)seconds {
    CGRect inner = CGRectMake(0.0, 0.0, 64.0*_body.healthGrade, 4.0);
    _healthBar.path = CGPathCreateWithRect(inner, nil);
    _healthBar.fillColor = [[NSColor redColor] blendedColorWithFraction:_body.healthGrade
                                                                ofColor:[NSColor greenColor]];
}

#pragma mark - NCActorInteraction Protocol

-(void)didGetAttackedBy:(NCActorEntity *)aggressor for:(CGFloat)damage {
    _healthBox.alpha = 0.8;
    [_healthBox runAction:[SKAction fadeAlphaTo:_fadeToAlpha duration:30.0]];
}

@end
