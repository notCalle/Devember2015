//
//  NCSpriteComponent.h
//  Devember2015
//
//  Created by Calle Englund on 25/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCComponent.h"
#import <SpriteKit/SpriteKit.h>
#import "NCDirection.h"

@class NCSpriteNode;
@class IsoTileNode;

@interface NCBodyComponent : NCComponent {
    CGFloat _maxHealth;
}

@property NCSpriteNode *sprite;
@property NSMutableArray<SKAction *> *movement;

@property CGFloat direction;
@property CGFloat stepHeight;
@property(readonly) CGFloat stepSpeed;
@property(nonatomic) CGFloat strength;
@property(nonatomic) CGFloat agility;
@property(nonatomic) CGFloat health;
@property(readonly) CGFloat healthGrade;

-(instancetype)initWithSprite:(NCSpriteNode *)sprite;

//-(void)step:(NCMovementDirection)direction;
-(void)stepTo:(IsoTileNode *)target from:(IsoTileNode *)here;

-(BOOL)canStepTo:(IsoTileNode *)target;
-(BOOL)canStepTo:(IsoTileNode *)target from:(IsoTileNode *)here;
-(CGFloat)costOfStepTo:(IsoTileNode *)target;
-(CGFloat)costOfStepTo:(IsoTileNode *)target from:(IsoTileNode *)here;

@end
