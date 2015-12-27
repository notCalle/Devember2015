//
//  NCConsoleComponent.h
//  Devember2015
//
//  Created by Calle Englund on 2015-12-27.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <GameplayKit/GameplayKit.h>
#import "NCActorEntity.h"

@class NCConsoleNode;

@interface NCConsoleComponent : GKComponent <NCActorInteraction>

@property(readonly) NCConsoleNode *console;

-(instancetype)initWithConsole:(NCConsoleNode *)console;

@end
