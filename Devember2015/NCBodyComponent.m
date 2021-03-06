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
#import "NCConsoleNode.h"
#import "NCRandomResolver.h"

@implementation NCBodyComponent

-(instancetype)init {
    self = [super init];
    if (self) {
        _priority = 0.0;
        _movement = [NSMutableArray array];
        _maxHealth = 0.0;
    }
    return self;
}

-(instancetype)initWithSprite:(NCSpriteNode *)sprite {
    self = [self init];
    if (self) {
        sprite.size = sprite.texture.size;
        sprite.anchorPoint = CGPointMake(0.5, 0.0);
        _sprite = sprite;
    }
    return self;
}

-(void)addMovement:(SKAction *)action {
    [_movement addObject:action];
}

-(void)setStrength:(CGFloat)strength {
    _strength = strength;
    _stepSpeed = (_strength * _agility) / 100.0;
}

-(void)setAgility:(CGFloat)agility {
    _agility = agility;
    _stepSpeed = (_strength * _agility) / 100.0;
}

-(void)setHealth:(CGFloat)health {
    _health = health;
    if (health > _maxHealth)
        _maxHealth = health;
}

-(CGFloat)healthGrade {
    return _health/_maxHealth;
}

#pragma mark - movement

-(void)stepTo:(IsoTileNode *)target from:(IsoTileNode *)here {
    NCActorEntity *entity = (NCActorEntity *)self.entity;
    
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

        CGVector smoothMovement = CGVectorMake((target.position.x - here.position.x) / 2.0,
                                               (target.position.y - here.position.y) / 2.0);
        CGFloat stepCost = [self costOfStepTo:target from:here];
        
        target.color = [NSColor redColor];
        target.colorBlendFactor = 1.0;
        [target runAction:[SKAction colorizeWithColorBlendFactor:0.0 duration:1.0]];

        CGFloat deltaZ = fabs(target.zPosition - here.zPosition) + 1.0;
        [self addMovement:[SKAction runBlock:^{
            _sprite.zPosition += deltaZ;
        }]];
        [self addMovement:[SKAction moveBy:smoothMovement duration:0.1*stepCost/_stepSpeed]];
        [self addMovement:[SKAction runBlock:^(void){
            NSArray<SKNode *> *victims = [target objectForKeyedSubscript:@"NCSpriteNode"];
            NSInteger victimCount = 0;
            for (NCSpriteNode *victim in victims) {
                if (victim.entity) {
                    [entity willAttack:(NCActorEntity *)victim.entity];
                    victimCount++;
                }
            }
            if (victimCount > 0) {
                [_sprite removeActionForKey:@"movement"];
            } else {
                _sprite.tile = target;
                _sprite.zPosition += deltaZ;
            }
            _sprite.position = CGPointMake(_sprite.position.x - smoothMovement.dx, _sprite.position.y - smoothMovement.dy);
        }]];
        [self addMovement:[SKAction moveBy:smoothMovement duration:0.1*stepCost/_stepSpeed]];
        [self addMovement:[SKAction runBlock:^{
            _sprite.zPosition -= deltaZ;
        }]];
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

#pragma mark - clock tick update

-(void)updateWithDeltaTime:(NSTimeInterval)seconds {
    if ([_sprite actionForKey:@"movement"] == nil &&
        _movement.count > 0)
    {
        [_sprite runAction:[SKAction sequence:_movement] withKey:@"movement"];
        [_movement removeAllObjects];
    }
    
    if (_health < _maxHealth) {
        _health += seconds * (_maxHealth / 100.0);
        if (_health > _maxHealth)
            _health = _maxHealth;
    }
}

#pragma mark - NCActorInteraction Protocol

-(void)didSpawnAt:(IsoTileNode *)tile {
    NCActorEntity *entity = (NCActorEntity *)self.entity;
    
    _sprite.tile = tile;
    [entity.scene.actors addObject:entity];
}

-(void)didGetAttackedBy:(NCActorEntity *)aggressor for:(CGFloat)damage {
    NCActorEntity *entity = (NCActorEntity *)self.entity;
    
    _health -= damage;
    if (_health < 0.0) {
        _health = 0.0;
    }
    _sprite.color = [NSColor redColor];
    _sprite.colorBlendFactor = 1.0;
    [_sprite runAction:[SKAction colorizeWithColorBlendFactor:0.0 duration:0.5] withKey:@"damage"];
    if (_health == 0.0) {
        [entity didGetKilledBy:aggressor];
    }
}

-(void)didGetKilledBy:(NCActorEntity *)aggressor {
    NCActorEntity *entity = (NCActorEntity *)self.entity;

    [aggressor didKill:entity];
    [_sprite removeFromParent];
    [entity.scene.actors removeObject:entity];
}

-(void)willAttack:(NCActorEntity *)victim {
    NCActorEntity *entity = (NCActorEntity *)self.entity;
    if (![victim isKindOfClass:entity.class]) {
        CGFloat success = [entity.resolve successGrade:entity.body.strength vs:victim.body.agility];
    
        if (success > 0.0) {
            [victim didGetAttackedBy:entity for:success];
        } else {
            [victim didAvoidAttackBy:entity];
        }
    }
}

-(void)willMove:(NCMovementDirection)direction {
    IsoTileNode *here = _sprite.tile;
    IsoTileNode *target = [here tileInDirection:direction];
    if ([self canStepTo:target]) {
        [self stepTo:target from:here];
    }
}

-(void)willMoveTo:(IsoTileNode *)target {
    [self willMoveTo:target maxSteps:NSIntegerMax];
}

-(void)willMoveTo:(IsoTileNode *)target maxSteps:(NSInteger)steps {
    NCPathFinder *pathFinder = [NCPathFinder finderFor:(NCActorEntity *)self.entity
                                                    on:(IsoTileMap *)target.parent];
    NSArray<IsoTileNode *> *path = [pathFinder findPathTo:target];
    
    if (path && path.count > 1) {
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

-(void)didGainLevel:(NSInteger)level; {
    switch (level % 3) {
        case 0:
            _maxHealth += 1;
            _health += 1;
            break;
            
        case 1:
            _strength += 1;
            break;
            
        case 2:
            _agility += 1;
            break;
            
        default:
            break;
    }
}

@end
