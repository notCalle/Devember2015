//
//  NCSpriteComponent.m
//  Devember2015
//
//  Created by Calle Englund on 25/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCBodyComponent.h"
#import "NCSPriteNode.h"
#import "IsoTileNode.h"
#import "IsoTile.h"
#import "NCPathFinder.h"
#import "NCActorEntity.h"
#import "GameScene.h"

@implementation NCBodyComponent

-(instancetype)init {
    self = [super init];
    if (self) {
        _movement = [NSMutableArray array];
    }
    return self;
}

-(instancetype)initWithSprite:(NCSpriteNode *)sprite {
    self = [self init];
    if (self) {
        _sprite = sprite;
    }
    return self;
}

-(void)addMovement:(SKAction *)action {
    [_movement addObject:action];
}

#pragma mark - movement

-(void)step:(NCMovementDirection)direction {
    IsoTileNode *here = _sprite.tile;
    IsoTileNode *target = [here tileInDirection:direction];
    if ([self canStepTo:target]) {
        [self stepTo:target from:here];
    }
}

-(void)stepTo:(IsoTileNode *)target from:(IsoTileNode *)here {
    if (target) {
        if (target == here.east) {
            _direction = MOVE_EAST;
        } else if (target == here.northEast) {
            _direction = MOVE_NORTHEAST;
        } else if (target == here.north) {
            _direction = MOVE_NORTH;
        } else if (target == here.northWest) {
            _direction = MOVE_NORTHWEST;
        } else if (target == here.west) {
            _direction = MOVE_WEST;
        } else if (target == here.southWest) {
            _direction = MOVE_SOUTHWEST;
        } else if (target == here.south) {
            _direction = MOVE_SOUTH;
        } else if (target == here.southEast) {
            _direction = MOVE_SOUTHEAST;
        }

        for (NCSpriteNode *child in [target objectForKeyedSubscript:@"NCSpriteNode"]) {
            [child.entity didGetAttackedBy:(NCActorEntity *)self.entity];
            target = here;
        }

        CGVector smoothMovement = CGVectorMake((target.position.x - here.position.x) / 2.0,
                                               (target.position.y - here.position.y) / 2.0);
        CGFloat stepCost = [self costOfStepTo:target from:here];
        
        target.color = [NSColor redColor];
        target.colorBlendFactor = 1.0;
        [target runAction:[SKAction colorizeWithColorBlendFactor:0.0 duration:1.0]];
        [self addMovement:[SKAction moveBy:smoothMovement duration:0.1*stepCost/_stepSpeed]];
        [self addMovement:[SKAction runBlock:^(void){
            _sprite.tile = target;
            _sprite.position = CGPointMake(_sprite.position.x - smoothMovement.dx, _sprite.position.y - smoothMovement.dy);
        }]];
        [self addMovement:[SKAction moveBy:smoothMovement duration:0.1*stepCost/_stepSpeed]];
    }
}

-(void)moveTo:(IsoTileNode *)target {
    [self moveTo:target maxSteps:NSIntegerMax];
}

-(void)moveTo:(IsoTileNode *)target maxSteps:(NSInteger)steps {
    NCPathFinder *pathFinder = [NCPathFinder finderFor:self on:(IsoTileMap *)target.parent];
    NSArray<IsoTileNode *> *path = [pathFinder findPathTo:target];
    
    if (path) {
        if (steps > path.count - 1) {
            steps = path.count - 1;
        }
        for (IsoTileNode *tile in [path subarrayWithRange:NSMakeRange(1,steps)]) {
            if (tile.cameFrom) {
                [self stepTo:tile from:(IsoTileNode *)tile.cameFrom];
            }
        }
    }
}

-(BOOL)canStepTo:(IsoTileNode *)target {
    return [self canStepTo:target from:(IsoTileNode *)_sprite.tile];
}

-(BOOL)canStepTo:(IsoTileNode *)target from:(IsoTileNode *)here {
    if (target != nil &&
        (target == here.east      ||
         target == here.northEast ||
         target == here.north     ||
         target == here.northWest ||
         target == here.west      ||
         target == here.southWest ||
         target == here.south     ||
         target == here.southEast))
    {
        CGFloat stepHeight = fabs(target.tile.stepHeight - here.tile.stepHeight);
        return (stepHeight <= _stepHeight);
    }
    return NO;
}

-(CGFloat)costOfStepTo:(IsoTileNode *)target {
    return [self costOfStepTo:target from:(IsoTileNode *)_sprite.tile];
}

-(CGFloat)costOfStepTo:(IsoTileNode *)target from:(IsoTileNode *)here {
    if ([self canStepTo:target from:here]) {
        CGFloat xDelta = abs(target.gridPosition.x - here.gridPosition.x);
        CGFloat yDelta = abs(target.gridPosition.y - here.gridPosition.y);
        CGFloat distance = (xDelta > yDelta) ? (xDelta + yDelta/2.0) : (xDelta/2.0 + yDelta);
        CGFloat baseCost = (target.stepCost + here.stepCost) / 2.0;
        CGFloat stepHeight = target.stepHeight - here.stepHeight;
        return baseCost*(distance + stepHeight);
    }
    return CGFLOAT_MAX;
}

-(void)updateWithDeltaTime:(NSTimeInterval)seconds {
    if ([_sprite actionForKey:@"movement"] == nil &&
        _movement.count > 0)
    {
        [_sprite runAction:[SKAction sequence:_movement]];
        [_movement removeAllObjects];
    }
}

#pragma mark - NCActorInteraction Protocol

-(void)didGetAttackedBy:(NCActorEntity *)aggressor {
    NCActorEntity *entity = (NCActorEntity *)self.entity;
    CGFloat damage = 1.0;
    
    _health -= damage;
    _sprite.color = [NSColor redColor];
    _sprite.colorBlendFactor = 1.0;
    [_sprite runAction:[SKAction colorizeWithColorBlendFactor:0.0 duration:0.5] withKey:@"damage"];
    [entity.scene.console addText:[NSString stringWithFormat:@"%@ was hit by %@ for %f", entity.name, aggressor.name, damage]];
    if (_health < 0.0) {
        [self didGetKilledBy:aggressor];
    }
}

@end
