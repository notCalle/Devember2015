//
//  NCConsoleComponent.m
//  Devember2015
//
//  Created by Calle Englund on 2015-12-27.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCConsoleComponent.h"
#import "GameScene.h"
#import "NCConsoleNode.h"

@implementation NCConsoleComponent

-(instancetype)initWithConsole:(NCConsoleNode *)console {
    self = [self init];
    if (self) {
        _console = console;
    }
    return self;
}

-(void)didGetKilledBy:(NCActorEntity *)aggressor {
    NCActorEntity *entity = (NCActorEntity *)self.entity;
    
    [_console addText:[NSString stringWithFormat:@"%@ was killed by %@",
                                   entity.name, aggressor.name]];
}

-(void)didLightTorch:(BOOL)isLit {
    NCActorEntity *entity = (NCActorEntity *)self.entity;

    if (isLit) {
        [_console addText:[NSString stringWithFormat:@"%@ lit their torch",
                           entity.name]];
    } else {
        [_console addText:[NSString stringWithFormat:@"%@ put out their torch",
                           entity.name]];
    }
}

-(void)didReplaceTorch {
    NCActorEntity *entity = (NCActorEntity *)self.entity;
    
    [_console addText:[NSString stringWithFormat:@"%@ replaced their torch",
                       entity.name]];
}

@end
