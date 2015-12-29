//
//  NCMobBrainComponent.m
//  Devember2015
//
//  Created by Calle Englund on 27/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCMobBrainComponent.h"
#import "NCBodyComponent.h"
#import "NCActorEntity.h"
#import "NCSpriteNode.h"
#import "GameScene.h"
#import "IsoTileNode.h"
#import "NCConsoleNode.h"
#import "NCPerlinNoise.h"

@implementation NCMobBrainComponent

-(instancetype)init {
    self = [super init];
    if (self) {
        _priority = 10.0;
        _ruleSystem = [GKRuleSystem new];
        NSArray<GKRule *> *rules =
        @[
          [GKRule ruleWithBlockPredicate:^BOOL(GKRuleSystem *rs) {
              NSNumber *health = rs.state[@"health"];
              return (health.floatValue < 0.5);
          } action:^(GKRuleSystem *rs) {
              NSNumber *health = rs.state[@"health"];
              [rs assertFact:@"flee" grade:(0.5-health.floatValue)*2.0];
          }],
          [GKRule ruleWithBlockPredicate:^BOOL(GKRuleSystem *rs) {
              NSNumber *distance = rs.state[@"playerDistance"];
              return (distance.floatValue < 10.0);
          } action:^(GKRuleSystem *rs) {
              NSNumber *distance = rs.state[@"playerDistance"];
              NSNumber *light = rs.state[@"light"];
              [rs assertFact:@"hunt" grade:(1.0-light.floatValue/2.0) * (10.0-distance.floatValue)/10.0];
              [rs assertFact:@"flee" grade:(0.5+light.floatValue/2.0) * (10.0-distance.floatValue)/10.0];
              [rs assertFact:@"seek" grade:distance.floatValue/10.0];
          }],
          [GKRule ruleWithBlockPredicate:^BOOL(GKRuleSystem *rs) {
              NSNumber *distance = rs.state[@"playerDistance"];
              return (distance.floatValue >= 10.0);
          } action:^(GKRuleSystem *rs) {
              NSNumber *distance = rs.state[@"playerDistance"];
              [rs assertFact:@"seek" grade:10.0/distance.floatValue];
          }]
          ];
        [_ruleSystem addRulesFromArray:rules];
    }
    return self;
}

-(void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKeyPath:key];
    _ruleSystem.state[key] = value;
}

-(void)updateWithDeltaTime:(NSTimeInterval)seconds {
    NCActorEntity *entity = (NCActorEntity *)self.entity;
    
    if (![entity.body.sprite hasActions]) {
        GameScene *scene = (GameScene *)entity.scene;
        NCActorEntity *player = scene.player;
        IsoTileNode *myTile = entity.body.sprite.tile;
        IsoTileNode *playerTile = player.body.sprite.tile;
        NSInteger dx = (myTile.gridPosition.x - playerTile.gridPosition.x);
        NSInteger dy = (myTile.gridPosition.y - playerTile.gridPosition.y);
        CGFloat distance = sqrt(dx*dx + dy*dy);
        CGFloat direction = entity.body.direction;

        _ruleSystem.state[@"health"] = @(entity.body.healthGrade);
        _ruleSystem.state[@"playerDistance"] = @(distance);
        _ruleSystem.state[@"light"] = @(scene.light);

        [_ruleSystem reset];
        [_ruleSystem evaluate];

        CGFloat huntGrade = [_ruleSystem gradeForFact:@"hunt"];
        CGFloat fleeGrade = [_ruleSystem gradeForFact:@"flee"];
        CGFloat seekGrade = [_ruleSystem gradeForFact:@"seek"];

//        [scene.console addText:[NSString stringWithFormat:@"%@ hunt:%.1f flee:%.1f seek:%.1f",
//                                entity.name, huntGrade, fleeGrade, seekGrade]];
        
        if (fleeGrade > 1.0 - _cowardice) {
            // should move away from instead of randomly
            NCPerlinNoise *noise = [NCPerlinNoise octaves:5 persistance:0.5];
            CGFloat directionChange = [noise perlinNoise:scene.lastTime] * 2.0;
            if (directionChange > 0.0) {
                direction += directionChange + 1.0;
            } else {
                direction += directionChange - 1.0;
            }
            [entity willMove:((int)direction) & 0x7];
        } else if (huntGrade > 1.0 - _aggressiveness) {
            [entity willMoveTo:playerTile];
        } else if (seekGrade > 1.0 - _curiosity) {
            [entity willMoveTo:playerTile maxSteps:1];
        } else {
            NCPerlinNoise *noise = [NCPerlinNoise octaves:5 persistance:0.5];
            direction += [noise perlinNoise:scene.lastTime];
            [entity willMove:((int)direction) & 0x7];
        }
    }
}

#pragma mark - NCActorInteraction Protocol

-(void)didGetAttackedBy:(NCActorEntity *)aggressor for:(CGFloat)damage {
    _aggressor = aggressor;
}

-(void)didAvoidAttackBy:(NCActorEntity *)aggressor {
    _aggressor = aggressor;
}

-(void)didKill:(NCActorEntity *)victim {
    if (_aggressor == victim) {
        _aggressor = nil;
    }
}

@end
