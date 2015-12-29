//
//  NCActorEntity.m
//  Devember2015
//
//  Created by Calle Englund on 26/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCActorEntity.h"
#import "NCSpriteNode.h"
#import "NCBodyComponent.h"
#import "NCTorchComponent.h"
#import "NCPlayerBrainComponent.h"
#import "NCMobBrainComponent.h"
#import "NCConsoleComponent.h"
#import "GameScene.h"
#import "NCPriorityQueue.h"
#import "NCRandomResolver.h"

@implementation NCActorEntity

-(instancetype)init {
    self = [super init];
    if (self) {
        _name = self.className;
        _resolve = [NCRandomResolver new];
    }
    return self;
}

-(instancetype)initWithName:(NSString *)name {
    self = [self init];
    if (self) {
        _name = name;
    }
    return self;
}

-(NCBodyComponent *)body {
    return (NCBodyComponent *)[self componentForClass:[NCBodyComponent class]];
}

#pragma mark - dispatch messages to components

-(void)updateWithDeltaTime:(NSTimeInterval)seconds {
    for (GKComponent *component in self.components) {
        [component updateWithDeltaTime:seconds];
    }
}

-(void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL aSelector = anInvocation.selector;
    
    for (GKComponent *component in [[NCPriorityQueue alloc] initWithArray:self.components]) {
        if ([component respondsToSelector:aSelector]) {
            [anInvocation invokeWithTarget:component];
        }
    }
}

#pragma mark - entity kinds

@end
